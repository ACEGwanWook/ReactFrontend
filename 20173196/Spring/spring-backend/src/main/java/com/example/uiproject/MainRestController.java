package com.example.uiproject;

import com.example.uiproject.Model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * MainRestController.java
 *
 * 기존 MainController(JSP/MVC)를 REST API로 전환.
 * DAO/DTO/SQL 은 원본 그대로 재사용.
 * React 프론트엔드(react-frontend)와 통신합니다.
 */
@RestController
@RequestMapping("/api")
@lombok.extern.slf4j.Slf4j
public class MainRestController {

    @Autowired private CodeDAO       codeDAO;
    @Autowired private UserDAO       userDAO;
    @Autowired private RobotDAO      robotDAO;
    @Autowired private RobotErrDAO   roboterrDAO;
    @Autowired private WorkOrderDAO  workorderDAO;
    @Autowired private CadCellDAO    cadcellDAO;
    @Autowired private MainPageDAO   mainpageDAO;
    @Autowired private WeldingDAO    weldingDAO;
    @Autowired private PictGapDimDAO pictgapdimDAO;
    @Autowired private AbnPictDAO    abnpictDAO;
    @Autowired private PSChartDAO    psChartDAO;

    // ════════════════════════════════════════════════
    //  메인 페이지 (캘린더 페이지 초기 데이터)
    // ════════════════════════════════════════════════
    @GetMapping("/main")
    public Map<String, Object> getMainData() {
        return Map.of(
            "getProcess",   mainpageDAO.getProcess(),
            "getTodayWeld", mainpageDAO.getTodayWeld(),
            "getRobotKPI",  mainpageDAO.getRobotKPI(),
            "getRobot",     robotDAO.getRobot(),
            "userList",     userDAO.getUser(),
            "WorkOrder",    workorderDAO.getWorkOrder()
        );
    }

    // ════════════════════════════════════════════════
    //  1-1. 공통코드관리
    // ════════════════════════════════════════════════
    /** 그룹 목록 + 각 그룹의 코드 개수 */
    @GetMapping("/codes/groups")
    public List<GroupCountDTO> getGroupCounts() {
        return codeDAO.getGroupCounts();
    }

    /** 그룹명으로 코드 상세 목록 조회 */
    @GetMapping("/codes")
    public List<CodeDTO> getCodes(@RequestParam String group) {
        return codeDAO.getCodesByGroup(group);
    }

    /** 코드 등록 */
    @PostMapping("/codes")
    public ResponseEntity<String> insertCode(@RequestBody CodeDTO dto) {
        if (codeDAO.isCodeExists(dto.getCode())) {
            return ResponseEntity.badRequest().body("⚠ 해당 코드가 이미 존재합니다.");
        }
        codeDAO.insertCode(dto);
        return ResponseEntity.ok("✅ 코드가 등록되었습니다.");
    }

    /** 코드 수정 */
    @PutMapping("/codes")
    public ResponseEntity<String> updateCode(@RequestBody CodeDTO dto) {
        codeDAO.updateCode(dto);
        return ResponseEntity.ok("✅ 코드가 수정되었습니다.");
    }

    /** 코드 삭제 — CodeDAO.deleteCode(String code) 는 파라미터 1개 */
    @DeleteMapping("/codes")
    public ResponseEntity<String> deleteCode(@RequestParam String code) {
        codeDAO.deleteCode(code);
        return ResponseEntity.ok("🗑 코드를 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  1-2. 사용자 관리
    // ════════════════════════════════════════════════
    /** 사용자 전체 조회 / 검색 */
    @GetMapping("/users")
    public List<UserDTO> getUsers(
            @RequestParam(required = false) String employeeNumber,
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String groupName,
            @RequestParam(required = false) String departName,
            @RequestParam(required = false) String sectionName,
            @RequestParam(required = false) String teamName,
            @RequestParam(required = false) String hireDate,
            @RequestParam(required = false) String position,
            @RequestParam(required = false) String grade) {
        if (hasValue(employeeNumber) || hasValue(userName) || hasValue(groupName)
                || hasValue(departName) || hasValue(sectionName) || hasValue(teamName)
                || hasValue(hireDate) || hasValue(position) || hasValue(grade)) {
            UserDTO dto = new UserDTO();
            dto.setEmployeeNumber(nvl(employeeNumber));
            dto.setUserName(nvl(userName));
            dto.setGroupName(nvl(groupName));
            dto.setDepartName(nvl(departName));
            dto.setSectionName(nvl(sectionName));
            dto.setTeamName(nvl(teamName));
            dto.setHireDate(nvl(hireDate));
            dto.setPosition(nvl(position));
            dto.setGrade(nvl(grade));
            return userDAO.selectUser(dto);
        }
        return userDAO.getUser();
    }

    /** 직책(Grade) 목록 */
    @GetMapping("/users/grades")
    public List<CodeDTO> getGrades() {
        return codeDAO.getGrade();
    }

    /** 사용자 등록 */
    @PostMapping("/users")
    public ResponseEntity<String> insertUser(@RequestBody UserDTO dto) {
        if (isBlankAny(dto.getEmployeeNumber(), dto.getUserName(), dto.getGroupName(),
                       dto.getDepartName(), dto.getSectionName(), dto.getTeamName(),
                       dto.getHireDate(), dto.getPosition(), dto.getGrade())) {
            return ResponseEntity.badRequest().body("⚠ 모든 정보를 한글자 이상 입력하세요.");
        }
        if (userDAO.isUserExists(dto.getEmployeeNumber())) {
            return ResponseEntity.badRequest().body("⚠ 해당 사번이 이미 존재합니다.");
        }
        userDAO.insertUser(dto);
        return ResponseEntity.ok("✅ 신입 사원이 등록되었습니다.");
    }

    /** 사용자 수정 */
    @PutMapping("/users")
    public ResponseEntity<String> updateUser(@RequestBody UserDTO dto) {
        if (isBlankAny(dto.getEmployeeNumber(), dto.getUserName(), dto.getGroupName(),
                       dto.getDepartName(), dto.getSectionName(), dto.getTeamName(),
                       dto.getHireDate(), dto.getPosition(), dto.getGrade())) {
            return ResponseEntity.badRequest().body("⚠ 모든 정보를 한글자 이상 입력하세요.");
        }
        userDAO.updateUser(dto);
        return ResponseEntity.ok("✅ 사용자가 수정되었습니다.");
    }

    /** 사용자 삭제 */
    @DeleteMapping("/users")
    public ResponseEntity<String> deleteUser(@RequestParam String employeeNumber) {
        if (!hasValue(employeeNumber)) {
            return ResponseEntity.badRequest().body("⚠ 삭제할 사원을 선택하세요.");
        }
        userDAO.deleteUser(employeeNumber);
        return ResponseEntity.ok("🗑 사용자를 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  2-1. 자동화 장비 자산 관리
    // ════════════════════════════════════════════════
    /** 로봇 전체 조회 / 검색 */
    @GetMapping("/robots")
    public List<RobotDTO> getRobots(
            @RequestParam(required = false) String robotNo,
            @RequestParam(required = false) String robotName,
            @RequestParam(required = false) String maker,
            @RequestParam(required = false) String modelName,
            @RequestParam(required = false) String serialName,
            @RequestParam(required = false) String weight,
            @RequestParam(required = false) String introDate,
            @RequestParam(required = false) String inspectDate,
            @RequestParam(required = false) String inspectCycle,
            @RequestParam(required = false) String robotType) {
        if (hasValue(robotNo) || hasValue(robotName) || hasValue(maker) || hasValue(modelName)
                || hasValue(serialName) || hasValue(weight) || hasValue(introDate)
                || hasValue(inspectDate) || hasValue(inspectCycle) || hasValue(robotType)) {
            RobotDTO dto = new RobotDTO();
            dto.setRobotNo(nvl(robotNo)); dto.setRobotName(nvl(robotName));
            dto.setMaker(nvl(maker)); dto.setModelName(nvl(modelName)); dto.setSerialName(nvl(serialName));
            dto.setWeight(nvl(weight)); dto.setIntroDate(nvl(introDate)); dto.setInspectDate(nvl(inspectDate));
            dto.setInspectCycle(nvl(inspectCycle)); dto.setRobotType(nvl(robotType));
            return robotDAO.selectRobot(dto);
        }
        return robotDAO.getRobot();
    }

    /** 로봇 번호 목록 (고장관리 selectbox용) */
    @GetMapping("/robots/nos")
    public List<RobotErrDTO> getRobotNos() {
        return roboterrDAO.getRobotNo();
    }

    /** 로봇 등록 */
    @PostMapping("/robots")
    public ResponseEntity<String> insertRobot(@RequestBody RobotDTO dto) {
        if (isBlankAny(dto.getRobotNo(), dto.getRobotName(), dto.getMaker(),
                       dto.getModelName(), dto.getSerialName(), dto.getWeight(),
                       dto.getIntroDate(), dto.getInspectDate(), dto.getInspectCycle())) {
            return ResponseEntity.badRequest().body("⚠ 모든 정보를 한글자 이상 입력하세요.");
        }
        robotDAO.insertRobot(dto);
        return ResponseEntity.ok("✅ 로봇이 등록되었습니다.");
    }

    /** 로봇 수정 */
    @PutMapping("/robots")
    public ResponseEntity<String> updateRobot(@RequestBody RobotDTO dto) {
        if (isBlankAny(dto.getRobotNo(), dto.getRobotName(), dto.getMaker(),
                       dto.getModelName(), dto.getSerialName(), dto.getWeight(),
                       dto.getIntroDate(), dto.getInspectDate(), dto.getInspectCycle())) {
            return ResponseEntity.badRequest().body("⚠ 모든 정보를 한글자 이상 입력하세요.");
        }
        robotDAO.updateRobot(dto);
        return ResponseEntity.ok("✅ 로봇이 수정되었습니다.");
    }

    /** 로봇 삭제 */
    @DeleteMapping("/robots")
    public ResponseEntity<String> deleteRobot(@RequestParam String robotNo) {
        if (!hasValue(robotNo)) {
            return ResponseEntity.badRequest().body("⚠ 삭제할 로봇을 선택하세요.");
        }
        RobotDTO dto = new RobotDTO();
        dto.setRobotNo(robotNo);
        robotDAO.deleteRobot(dto);
        return ResponseEntity.ok("🗑 로봇을 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  2-2. 고장 이력 관리 (errordiv)
    // ════════════════════════════════════════════════
    /** 고장 이력 조회 / 검색 */
    @GetMapping("/robot-errors")
    public List<RobotErrDTO> getRobotErrors(
            @RequestParam(required = false) String robotNum,
            @RequestParam(required = false) String errNum,
            @RequestParam(required = false) String reason,
            @RequestParam(required = false) String detail) {
        if (hasValue(robotNum) || hasValue(errNum) || hasValue(reason) || hasValue(detail)) {
            return roboterrDAO.getRoborErrSearch(robotNum, errNum, reason, detail);
        }
        return roboterrDAO.getRobotErr();
    }

    /** 고장사유 목록 */
    @GetMapping("/robot-errors/reasons")
    public List<RobotErrDTO> getErrorReasons() {
        return roboterrDAO.getErrorReason();
    }

    /** 고장 이력 등록 */
    @PostMapping("/robot-errors")
    public ResponseEntity<String> insertRobotError(@RequestBody RobotErrDTO dto) {
        roboterrDAO.insertError(dto);
        return ResponseEntity.ok("✅ 저장되었습니다.");
    }

    /** 고장 이력 수정 */

    @PutMapping("/robot-errors")
    public ResponseEntity<String> updateRobotError(@RequestBody RobotErrDTO dto) {
        roboterrDAO.updateError(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    /** 고장 이력 삭제 */
    @DeleteMapping("/robot-errors")
    public ResponseEntity<String> deleteRobotError(@RequestParam String errNum) {
        roboterrDAO.deleteError(errNum);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  2-2. 수선 관리 (receivediv)
    // ════════════════════════════════════════════════
    /** 수선 목록 조회 / 검색 */
    @GetMapping("/repairs")
    public List<RobotErrDTO> getRepairs(
            @RequestParam(required = false) String robotNum,
            @RequestParam(required = false) String repairNo,
            @RequestParam(required = false) String date,
            @RequestParam(required = false) String part,
            @RequestParam(required = false) String cost,
            @RequestParam(required = false) String desc) {
        if (hasValue(robotNum) || hasValue(repairNo) || hasValue(date) || hasValue(part)
                || hasValue(cost) || hasValue(desc)) {
            return roboterrDAO.getRepairSearch(robotNum, null, repairNo, date, part, cost, desc);
        }
        return roboterrDAO.getRepair();
    }

    /** 수선 부품 목록 */
    @GetMapping("/repairs/parts")
    public List<RobotErrDTO> getRepairParts() {
        return roboterrDAO.getRepairPart();
    }

    /** 수선 등록 */
    @PostMapping("/repairs")
    public ResponseEntity<String> insertRepair(@RequestBody RobotErrDTO dto) {
        roboterrDAO.insertRepair(dto);
        return ResponseEntity.ok("✅ 저장되었습니다.");
    }

    /** 수선 수정 */
    @PutMapping("/repairs")
    public ResponseEntity<String> updateRepair(@RequestBody RobotErrDTO dto) {
        roboterrDAO.updateRepair(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    /** 수선 삭제 */
    @DeleteMapping("/repairs")
    public ResponseEntity<String> deleteRepair(@RequestParam String repairNo) {
        roboterrDAO.deleteReceive(repairNo);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  3-1. 설계 정보 관리 (CadCell)
    // ════════════════════════════════════════════════
    /** 셀 정보 조회 / 검색 */
    @GetMapping("/design-info")
    public List<CadCellDTO> getDesignInfo(
            @RequestParam(required = false) String projNo,
            @RequestParam(required = false) String blockName,
            @RequestParam(required = false) String assyName) {
        if (hasValue(projNo) || hasValue(blockName) || hasValue(assyName)) {
            return cadcellDAO.getCellSearch(projNo, assyName, blockName);
        }
        return cadcellDAO.getCellInfo();
    }

    /** 셀 정보 등록 */
    @PostMapping("/design-info")
    public ResponseEntity<String> insertDesignInfo(@RequestBody CadCellDTO dto) {
        cadcellDAO.InsertCellInfo(dto);
        return ResponseEntity.ok("✅ 등록되었습니다.");
    }

    /** 셀 정보 수정 */
    @PutMapping("/design-info")
    public ResponseEntity<String> updateDesignInfo(@RequestBody CadCellDTO dto) {
        cadcellDAO.updateCellInfo(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    /** 셀 정보 삭제 */
    @DeleteMapping("/design-info")
    public ResponseEntity<String> deleteDesignInfo(@RequestParam String cellID) {
        cadcellDAO.deleteCellInfo(cellID);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  3-2. IOT 데이터 (Row Data)
    // ════════════════════════════════════════════════
    /** 파일 목록 (탭1) — daily_summary JOIN welding_records */
    @GetMapping("/iot-data/files")
    public List<WeldingDTO> getIotFiles() {
        return weldingDAO.getJoinAll();
    }

    /** 요약 (탭2 상단 카드) */
    @GetMapping("/iot-data/summary")
    public List<WeldingDTO> getIotSummary(@RequestParam(required = false) String workDate) {
        if (hasValue(workDate)) {
            return weldingDAO.getSummaryByDate(workDate);
        }
        return weldingDAO.getSummaryAll();
    }

    /** 용접 상세 기록 (탭2 테이블 + 탭3 차트) */
    @GetMapping("/iot-data/records")
    public List<WeldingDTO> getIotRecords() {
        return weldingDAO.getRecordsAll();
    }

    // ════════════════════════════════════════════════
    //  5-1. 워크오더
    // ════════════════════════════════════════════════
    /** 워크오더 전체 조회 / 검색 */
    @GetMapping("/work-orders")
    public List<WorkOrderDTO> getWorkOrders(
            @RequestParam(required = false) String orderDate,
            @RequestParam(required = false) String orderNum,
            @RequestParam(required = false) String equipNum,
            @RequestParam(required = false) String workLine,
            @RequestParam(required = false) String workBlock,
            @RequestParam(required = false) String assyName,
            @RequestParam(required = false) String workAdmin,
            @RequestParam(required = false) String aiact,
            @RequestParam(required = false) String performanceNum,
            @RequestParam(required = false) String workEnd,
            @RequestParam(required = false) String finish) {
        boolean finishFilter = hasValue(finish) && !"전체".equals(finish);
        if (hasValue(orderDate) || hasValue(orderNum) || hasValue(equipNum) || hasValue(workLine)
                || hasValue(workBlock) || hasValue(assyName) || hasValue(workAdmin) || hasValue(aiact)
                || hasValue(performanceNum) || hasValue(workEnd) || finishFilter) {
            return workorderDAO.getWorkOrderSearch(orderDate, orderNum, equipNum, workLine, workBlock, assyName,
                    workAdmin, aiact, performanceNum, workEnd, finishFilter ? finish : "");
        }
        return workorderDAO.getWorkOrder();
    }

    /** 호선 번호 목록 (selectbox용) */
    @GetMapping("/work-orders/proj-nos")
    public List<WorkOrderDTO> getProjNos() {
        return workorderDAO.getProjNo();
    }

    /** 워크오더 등록 */
    @PostMapping("/work-orders")
    public ResponseEntity<String> insertWorkOrder(@RequestBody WorkOrderDTO dto) {
        workorderDAO.insertWorkOrder(dto);
        return ResponseEntity.ok("✅ 등록되었습니다.");
    }

    /** 워크오더 수정 */
    @PutMapping("/work-orders")
    public ResponseEntity<String> updateWorkOrder(@RequestBody WorkOrderDTO dto) {
        workorderDAO.updateWorkOrderOverride(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    /** 워크오더 삭제 */
    @DeleteMapping("/work-orders")
    public ResponseEntity<String> deleteWorkOrder(@RequestParam String orderNum) {
        workorderDAO.deleteWorkOrder(orderNum);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  모니터링 / 기타 (DB 연결 후 DAO 추가 예정)
    // ════════════════════════════════════════════════
    @GetMapping("/monitoring/auto-situation")
    public List<?> getAutoSituation() { return List.of(); }

    @GetMapping("/monitoring/product-situation")
    public List<PSChartDTO> getProductSituation() {
        return psChartDAO.getPSChart();
    }

    @GetMapping("/monitoring/robot-line")
    public List<?> getRobotLine() { return List.of(); }

    @GetMapping("/monitoring/block")
    public List<?> getBlockMonitoring() { return List.of(); }

    @GetMapping("/robot-orders")
    public List<WorkOrderDTO> getRobotOrders(
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            @RequestParam(required = false) String equipNum,
            @RequestParam(required = false) String finish) {
        if (hasValue(startDate) || hasValue(endDate) || hasValue(equipNum) || hasValue(finish)) {
            return workorderDAO.getWorkOrderSearchByDate(startDate, endDate, equipNum, finish);
        }
        return workorderDAO.getWorkOrder();
    }

    @GetMapping("/dispatch-wip")
    public List<?> getDispatchWip() { return List.of(); }

    @GetMapping("/weld-dataset")
    public List<?> getWeldDataset() { return List.of(); }

    // ── 비정형 데이터 (AbnPict) ──────────────────────────────
    @GetMapping("/irregular-data")
    public List<AbnPictDTO> getIrRegularData(
            @RequestParam(required = false) String errDate,
            @RequestParam(required = false) String projNo,
            @RequestParam(required = false) String robotNo,
            @RequestParam(required = false) String errInfo,
            @RequestParam(required = false) String action) {
        if (hasValue(errDate) || hasValue(projNo) || hasValue(robotNo)
                || (hasValue(errInfo) && !"전체".equals(errInfo))
                || (hasValue(action)  && !"전체".equals(action))) {
            return abnpictDAO.getAbnSearch(
                nvl(errDate), nvl(projNo), nvl(robotNo),
                "전체".equals(errInfo) ? "" : nvl(errInfo),
                "전체".equals(action)  ? "" : nvl(action));
        }
        return abnpictDAO.getAbnPict();
    }

    @GetMapping("/irregular-data/err-info")
    public List<AbnPictDTO> getErrInfo() { return abnpictDAO.getErrInfo(); }

    @GetMapping("/irregular-data/actions")
    public List<AbnPictDTO> getActions() { return abnpictDAO.getAction(); }

    @PutMapping("/irregular-data")
    public ResponseEntity<String> updateAbnPict(@RequestBody AbnPictDTO dto) {
        abnpictDAO.updateAbnPict(dto);
        return ResponseEntity.ok("✅ 저장되었습니다.");
    }

    @GetMapping("/quality-model")
    public List<PictGapDimDTO> getSituation() {
        return pictgapdimDAO.getPictGapDim();
    }

    @GetMapping("/situation-model")
    public List<PictGapDimDTO> getSituationModel() {
        return pictgapdimDAO.getPictGapDim();
    }

    // ════════════════════════════════════════════════
    //  공통 예외 처리
    // ════════════════════════════════════════════════
    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        log.error("API 오류", e);
        return ResponseEntity.internalServerError().body("오류: " + e.getMessage());
    }

    // ── 유틸리티 ────────────────────────────────────
    private boolean hasValue(String s) { return s != null && !s.isBlank(); }
    private String  nvl(String s)      { return s == null ? "" : s; }
    private boolean isBlankAny(String... values) {
        for (String v : values) if (!hasValue(v)) return true;
        return false;
    }
}
