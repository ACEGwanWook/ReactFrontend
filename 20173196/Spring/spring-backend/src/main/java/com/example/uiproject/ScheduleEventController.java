package com.example.uiproject;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import com.example.uiproject.Model.ScheduleEvent;
import com.example.uiproject.Model.ScheduleEvent.*;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/events")
@RequiredArgsConstructor

public class ScheduleEventController{
    private final ScheduleEventRepository repo;
    private static final ZoneId KST = ZoneId.of("Asia/Seoul");
    private LocalDateTime toKst(Object val) {
        if(val == null) return null;
        if(val instanceof Number n){
            return Instant.ofEpochMilli(n.longValue()).atZone(KST).toLocalDateTime();
        }
        String s = val.toString().trim();
        if(s.isEmpty() || "null".equalsIgnoreCase(s)) return null;
        if(s.length() == 10 && s.charAt(4) == '-' && s.charAt(7) == '-'){
            return LocalDate.parse(s).atStartOfDay();
        }
        if(s.length() > 10 && s.charAt(10) == ' '){
            s = s.substring(0, 10) + 'T' + s.substring(11);
        }
        try { // +09:00 / Z가 붙은 ISO
            return OffsetDateTime.parse(s).atZoneSameInstant(KST).toLocalDateTime();
        } catch (DateTimeParseException e1) {
            try { // Zoned 형태
                return ZonedDateTime.parse(s).withZoneSameInstant(KST).toLocalDateTime();
            } catch (DateTimeParseException e2) { // 오프셋 없는 local
                return LocalDateTime.parse(s);
            }
        }
    }

    private Map<String, Object> toFullCalendar(ScheduleEvent e) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id",     e.getId());
        m.put("title",  e.getTitle());

        // FullCalendar는 ISO8601 문자열 또는 Date를 받습니다.
        // (Jackson이 LocalDateTime을 ISO로 변환하므로 그대로 넣어도 됨)
        m.put("start",  e.getStart());
        m.put("end",    e.getEnd());
        // 하루종일 여부: DB에 올데이 플래그가 없으면 파생 규칙으로 결정
        boolean allDay = false;
        if (e.getStart() != null && e.getEnd() != null) {
            // 종료가 자정이고, 시작~종료가 정확히 N일 경계면 올데이로 취급 (원하시는 규칙으로 조정)
            allDay = e.getStart().toLocalTime().equals(java.time.LocalTime.MIDNIGHT)
                && e.getEnd().toLocalTime().equals(java.time.LocalTime.MIDNIGHT);
        }
        m.put("allDay", allDay);

        // 색상
        if (e.getColor() != null) { m.put("color", e.getColor());
            m.put("backgroundColor", e.getColor());
            m.put("borderColor", e.getColor());
        }
        // 추가 속성은 extendedProps로 묶어서 보내는 게 깔끔합니다.
        Map<String, Object> ext = new LinkedHashMap<>();
        ext.put("type",     e.getType());      // HUMAN / ROBOT
        ext.put("category", norm(e.getCategory()));  // 업무/회의/개인 (사람 일정일 때)
        ext.put("memo",     e.getMemo());
        m.put("extendedProps", ext);

        return m;
    }

    private static final Map<String, String> HUMAN_COLOR = Map.of(
        "업무","#2e86de","회의","#e67e22","개인","#27ae60"
    );

    private static final String ROBOT_COLOR = "#8e44ad";

    private static String norm(String s) { return s == null ? "" : s.trim(); }

    private static String pickColor(EventType type, String category, String colorFromDb) {
        // DB 색이 들어있으면 그걸 쓰고 싶지 않다면 이 if는 제거하세요.
        if (colorFromDb != null && !colorFromDb.isBlank()) return colorFromDb;

        if (type == EventType.HUMAN) {
            return HUMAN_COLOR.getOrDefault(norm(category), "#2980b9");
        }
        return ROBOT_COLOR;
    }
    /* 
    private static String colorFor(EventType t, String category){
        return (t == EventType.HUMAN) ? HUMAN_COLOR.getOrDefault(category, "#2e86de") : "#8e44ad";
    }*/
    
    @GetMapping({"","/"})
    public List<Map<String, Object>> list(
        @RequestParam String start,                 // yyyy-MM-dd 또는 yyyy-MM-ddTHH:mm:ss
        @RequestParam String end,
        @RequestParam(required = false) String type,      // "HUMAN,ROBOT"
        @RequestParam(required = false) String category   // "업무,회의"
    ) {
        // 0) 문자열 → LocalDateTime 안전 변환
        LocalDateTime from = parseFlexible(start);
        LocalDateTime to   = parseFlexible(end);
        // 1) 허용 타입(HUMAN/ROBOT) // 타입 해석
        final Set<EventType> allowedTypes;
        if (type == null) {
            // 파라미터 자체가 없으면 = 전체 허용
            allowedTypes = EnumSet.allOf(EventType.class);
        } else if (type.isBlank()) {
            // 빈문자열이면 = 선택 0개 → 결과 0건
            return Collections.emptyList();
        } else {
            allowedTypes = Arrays.stream(type.split(","))
                    .map(String::trim)
                    .map(EventType::valueOf)
                    .collect(Collectors.toCollection(() -> EnumSet.noneOf(EventType.class)));
        }

        // 2) 허용 카테고리(사람 일정일 때만 반영) // category 해석: HUMAN이 선택된 경우에만 의미가 있음
        final Set<String> catsFilter; // null = 필터 없음
        if (!allowedTypes.contains(EventType.HUMAN)) {
        catsFilter = null; // 사람 일정 자체가 없으므로 카테고리 필터 무의미
        } else {
            if (category == null) {
                catsFilter = null; // 카테고리 필터 없음 (사람 일정 모두 표시)
            } else if (category.isBlank()) {
                catsFilter = Collections.emptySet(); // 사람 카테고리 선택 0개 → 사람 일정 0건
            } else {
                catsFilter = Arrays.stream(category.split(","))
                        .map(String::trim)
                        .filter(s -> !s.isEmpty())
                        .collect(Collectors.toSet());
            }
        }
        // 3) 달력에 보이는 구간과 겹치는 일정 조회
        // ─────────────────────────────────────────────────────────────
        // [A] 엔티티 필드명이 start / end 인 경우 (대부분 이거)
        //List<ScheduleEvent> rows = repo.findByEndGreaterThanEqualAndStartLessThanEqual(from, to);
            // [B] 엔티티 필드명이 startDt / endDt 인 경우엔 위 한 줄을 아래로 바꾸세요
            // List<ScheduleEvent> rows =
            //         repo.findByEndDtGreaterThanEqualAndStartDtLessThanEqual(from, to);
            // ─────────────────────────────────────────────────────────────
            // 4) 타입/카테고리 필터 → FullCalendar 포맷 변환
        return repo.findByEndGreaterThanEqualAndStartLessThanEqual(from, to).stream()
            .filter(e -> allowedTypes.contains(e.getType()))//타입 필터
            // 사람 일정이면 카테고리 필터 적용
            .filter(e -> {
                if (e.getType() != EventType.HUMAN) return true;     // 로봇은 통과
                if (catsFilter == null) return true;                 // 카테고리 필터 없음 → 통과
                return catsFilter.contains(Objects.toString(e.getCategory(), ""));
            })
            .map(this::toFullCalendar)
            .collect(Collectors.toList());
    }
    /** yyyy-MM-dd 또는 yyyy-MM-ddTHH:mm:ss 를 유연하게 파싱 */
    private static LocalDateTime parseFlexible(String s) {
        if (s == null || s.isBlank()) return null;
        // 1) 오프셋 포함: 2025-08-31T00:00:00+09:00 / 2025-08-31T00:00:00Z
        try {
            return OffsetDateTime.parse(s, DateTimeFormatter.ISO_OFFSET_DATE_TIME).toLocalDateTime();
        } 
        catch (DateTimeParseException ignore) {}
        // 2) 오프셋 없는 로컬: 2025-08-31T00:00:00
        try {
            return LocalDateTime.parse(s, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } 
        catch (DateTimeParseException ignore) {}
        // 3) 날짜만: 2025-08-31 → 00:00으로 보정
        try {
            return LocalDate.parse(s, DateTimeFormatter.ISO_LOCAL_DATE).atStartOfDay();
        } 
        catch (DateTimeParseException e) {
            // 그래도 안되면 원인 알 수 있게 예외 재던지기
            throw e;
        }
    }
    //일정 생성, 수정, 삭제
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Object> create(@RequestBody Map<String, Object> body) {
        ScheduleEvent e = new ScheduleEvent();
        e.setTitle((String) body.get("title"));
        e.setAllDay(Boolean.TRUE.equals(body.get("allDay")));

        //String type = (String) body.get("type");          // "HUMAN" / "ROBOT"
        e.setType(EventType.valueOf(Objects.toString(body.get("type"), "HUMAN")));
        e.setCategory(norm((String) body.get("category")));
        e.setColor(pickColor(e.getType(), e.getCategory(), (String) body.get("color")));
        e.setMemo(  (String) body.getOrDefault("memo", ""));

        e.setStart(parseFlexible((String) body.get("start")));
        String endStr = (String) body.get("end");
        e.setEnd(endStr == null
                ? (e.isAllDay() ? e.getStart().plusDays(1) : e.getStart())
                : parseFlexible(endStr));

        ScheduleEvent saved = repo.save(e);
        return Map.of("id", saved.getId());
    }
    @PutMapping(value = "/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public void update(@PathVariable Long id, @RequestBody Map<String, Object> body){
        var e = repo.findById(id).orElseThrow();
        var typeStr = Objects.toString(body.get("type"), e.getType().name());
        var t = EventType.valueOf(typeStr.toUpperCase());
        // 1) 바디 값 파싱
        e.setTitle(norm((String) body.get("title")));
        e.setCategory(norm((String) body.get("category")));
        e.setType(EventType.valueOf(Objects.toString(body.get("type"), e.getType().name())));
        e.setAllDay(Boolean.TRUE.equals(body.get("allDay")));
        e.setStart(toKst(body.get("start")));
        LocalDateTime end = toKst(body.get("end"));
        // 2) duration 보존 또는 보정
        if (end == null) {
            if (e.getEnd() != null) {
                // 기존 duration 유지
                var d = java.time.Duration.between(e.getStart(), e.getEnd());
                if (d.isNegative()) d = java.time.Duration.ZERO;
                end = e.getStart().plus(d);
            } else {
                // 시간 일정인데 종료가 없으면 기본 1시간 부여 (원하면 다른 기본값)
                end = e.isAllDay() ? e.getStart().plusDays(1) : e.getStart().plusHours(1);
            }
        }
        if(e.isAllDay() && !end.isAfter(e.getStart())) end = e.getStart().plusDays(1);
        e.setEnd(end);

        if(t == EventType.HUMAN){
            var cat = Objects.toString(body.get("category"), e.getCategory());
            if(!HUMAN_COLOR.containsKey(cat)) throw new IllegalArgumentException("Category : 업무/회의/개인");
            e.setCategory(cat);
        }
        else{
            e.setCategory(null);
        }
        // 3) 엔티티 반영
        String colorReq = (String) body.get("color");
        // 사람 일정은 항상 맵색으로 맞추고 싶으면 colorReq 무시
        // colorReq = null;
        e.setColor(pickColor(e.getType(), e.getCategory(), colorReq));
        /*var color = Objects.toString(body.get("color"), null);
        e.setColor(color != null ? color : colorFor(t, e.getCategory()));*/
        e.setMemo(Objects.toString(body.get("memo"), e.getMemo()));
        repo.save(e);
    }
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) {repo.deleteById(id);}
}