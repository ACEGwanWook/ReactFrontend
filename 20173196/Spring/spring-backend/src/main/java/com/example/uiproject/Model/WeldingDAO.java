package com.example.uiproject.Model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class WeldingDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private DataSource dataSource;

    // ──────────────────────────────────────────
    // daily_summary 관련
    // ──────────────────────────────────────────

    /** 일일 요약 전체 조회 */
    public List<WeldingDTO> getSummaryAll() {
        String sql = "SELECT * FROM daily_summary";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setId(rs.getInt("id"));
            dto.setWork_date(rs.getString("work_date"));
            dto.setOperation_time(rs.getString("operation_time"));
            dto.setArc_time(rs.getString("arc_time"));
            dto.setArc_rate(rs.getDouble("arc_rate"));
            dto.setWeld_length(rs.getDouble("weld_length"));
            dto.setVessel_no(rs.getString("vessel_no"));
            dto.setBlock(rs.getString("block"));
            dto.setAssy(rs.getString("assy"));
            dto.setWorker(rs.getString("worker"));
            return dto;
        });
    }

    /* 일일요약, 전체 */

    /** 특정 날짜 요약 조회 */
    public List<WeldingDTO> getSummaryByDate(String workDate) {
        String sql = "SELECT * FROM daily_summary WHERE work_date = ?";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setId(rs.getInt("id"));
            dto.setWork_date(rs.getString("work_date"));
            dto.setOperation_time(rs.getString("operation_time"));
            dto.setArc_time(rs.getString("arc_time"));
            dto.setArc_rate(rs.getDouble("arc_rate"));
            dto.setWeld_length(rs.getDouble("weld_length"));
            dto.setVessel_no(rs.getString("vessel_no"));
            dto.setBlock(rs.getString("block"));
            dto.setAssy(rs.getString("assy"));
            dto.setWorker(rs.getString("worker"));
            return dto;
        }, workDate);
    }

    /** 작업자별 요약 조회 */
    public List<WeldingDTO> getSummaryByWorker(String worker) {
        String sql = "SELECT * FROM daily_summary WHERE worker = ?";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setId(rs.getInt("id"));
            dto.setWork_date(rs.getString("work_date"));
            dto.setOperation_time(rs.getString("operation_time"));
            dto.setArc_time(rs.getString("arc_time"));
            dto.setArc_rate(rs.getDouble("arc_rate"));
            dto.setWeld_length(rs.getDouble("weld_length"));
            dto.setVessel_no(rs.getString("vessel_no"));
            dto.setBlock(rs.getString("block"));
            dto.setAssy(rs.getString("assy"));
            dto.setWorker(rs.getString("worker"));
            return dto;
        }, worker);
    }

    public List<WeldingDTO> getOperatingRate(){
        String sql = """
            WITH RawTimeCalculation AS (
            -- 1단계: welding_records의 시작/종료 시간을 초(Sec) 단위 절대값으로 변환
            SELECT 
                wr.summary_id,
                -- 시작 시간 변환
                TIME_TO_SEC(SUBSTRING_INDEX(wr.time_start, ' ', -1)) + 
                CASE 
                    WHEN LEFT(wr.time_start, 2) = '오후' AND SUBSTRING_INDEX(wr.time_start, ' ', -1) NOT LIKE '12:%' THEN 43200
                    WHEN LEFT(wr.time_start, 2) = '오전' AND SUBSTRING_INDEX(wr.time_start, ' ', -1) LIKE '12:%' THEN -43200
                    ELSE 0 
                END AS start_sec,
                -- 종료 시간 변환
                TIME_TO_SEC(SUBSTRING_INDEX(wr.time_end, ' ', -1)) + 
                CASE 
                    WHEN LEFT(wr.time_end, 2) = '오후' AND SUBSTRING_INDEX(wr.time_end, ' ', -1) NOT LIKE '12:%' THEN 43200
                    WHEN LEFT(wr.time_end, 2) = '오전' AND SUBSTRING_INDEX(wr.time_end, ' ', -1) LIKE '12:%' THEN -43200
                    ELSE 0 
                END AS end_sec,
                -- daily_summary의 기준 가동 시간
                ds.operation_time
            FROM hmd_weld_robot_v2.welding_records wr
            JOIN hmd_weld_robot_v2.daily_summary ds ON wr.summary_id = ds.id
            WHERE wr.summary_id = 1 -- 🔹 조회할 타겟 ID 바인딩
            ),
            DurationSum AS (
                -- 2단계: 각 레코드별 가동 시간(종료-시작) 계산 및 자정 처리
                SELECT 
                    CASE 
                        WHEN end_sec < start_sec THEN (end_sec + 86400) - start_sec
                        ELSE end_sec - start_sec 
                    END AS record_duration_sec,
                    operation_time
                FROM RawTimeCalculation
            )
            -- 3단계: (가동시간 총합 / 기준시간 초환산) * 100
            SELECT 
                ROUND((SUM(record_duration_sec) / TIME_TO_SEC(MAX(operation_time))) * 100.0, 1) AS operating_rate_pct
            FROM DurationSum""";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setWorktime(rs.getString("operating_rate_pct"));
            return dto;
        });
    }

    public List<WeldingDTO> getRecordsDaily(){
        String sql = """
        WITH StringSplit AS (
        -- 1단계: time_start와 time_end의 '오전/오후' 및 '시간' 텍스트를 각각 분리
        SELECT 
            LEFT(time_start, 2) AS start_ampm, SUBSTRING_INDEX(time_start, ' ', -1) AS start_time, LEFT(time_end, 2) AS end_ampm, 
            SUBSTRING_INDEX(time_end, ' ', -1) AS end_time, arc_time, weld_length
        FROM hmd_weld_robot_v2.welding_records
        ),
        TimeConversion AS (
            -- 2단계: 텍스트 시간을 0시(자정) 기준의 '초(Seconds)' 단위 절대값으로 변환
            SELECT 
                start_ampm AS am_pm, CAST(SUBSTRING_INDEX(start_time, ':', 1) AS UNSIGNED) AS hour_num, 
                -- time_start 초 환산 (오후면 12시간=43200초를 더함. 단 12시는 예외처리)
                TIME_TO_SEC(start_time) 
                + CASE 
                    WHEN start_ampm = '오후' AND SUBSTRING_INDEX(start_time, ':', 1) != '12' THEN 43200
                    WHEN start_ampm = '오전' AND SUBSTRING_INDEX(start_time, ':', 1) = '12' THEN -43200
                    ELSE 0 END AS start_sec,
                -- time_end 초 환산
                TIME_TO_SEC(end_time) 
                + CASE 
                    WHEN end_ampm = '오후' AND SUBSTRING_INDEX(end_time, ':', 1) != '12' THEN 43200
                    WHEN end_ampm = '오전' AND SUBSTRING_INDEX(end_time, ':', 1) = '12' THEN -43200
                    ELSE 0 END AS end_sec,
                arc_time, weld_length FROM StringSplit
        ),
        HourlyData AS (
            -- 3단계: 시간대 그룹핑 기준(work_hour) 생성 및 가동 시간(operation_sec) 계산
            SELECT 
                CASE 
                    WHEN am_pm = '오후' AND hour_num < 12 THEN hour_num + 12 WHEN am_pm = '오전' AND hour_num = 12 THEN 0 ELSE hour_num 
                END AS work_hour,
                -- time_end - time_start 계산 
                -- (만약 종료 시간이 시작 시간보다 작다면, 자정을 넘긴 것이므로 24시간=86400초를 더해줌)
                CASE 
                    WHEN end_sec < start_sec THEN end_sec + 86400 - start_sec ELSE end_sec - start_sec 
                END AS operation_sec, arc_time, weld_length FROM TimeConversion
        )
        -- 4단계: 최종 시간대별 그룹핑 및 분/미터 단위 환산
        SELECT 
            CONCAT(work_hour, '시') AS work_time_label,
            -- [가동 시간(Operation Time)]: 초로 계산된 (time_end - time_start)를 분으로 환산
            ROUND(SUM(operation_sec) / 60.0, 2) AS total_op_time_min,
            -- [아크 시간(Arc Time)]: arc_time을 분으로 환산
            ROUND(SUM(TIME_TO_SEC(arc_time)) / 60.0, 2) AS total_arc_time_min, 
            -- [용접 길이(Weld Length)]: 원시 데이터를 미터(m)로 환산
            ROUND(SUM(weld_length) / 1000.0, 2) AS total_weld_length_m
            FROM HourlyData GROUP BY work_hour ORDER BY work_hour""";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setWorktime(rs.getString("work_time_label"));
            dto.setOperation_time_rec(rs.getString("total_op_time_min"));
            dto.setArc_time_rec(rs.getString("total_arc_time_min"));
            dto.setWeld_length_rec(rs.getDouble("total_weld_length_m"));
            return dto;
        });
    }

    // ──────────────────────────────────────────
    // welding_records 관련
    // ──────────────────────────────────────────

    /** 용접 상세 기록 전체 조회 */
    public List<WeldingDTO> getRecordsAll() {
        String sql = "SELECT * FROM welding_records";
        return jdbcTemplate.query(sql, (rs, num) -> mapRecord(rs));
    }

    /** summary_id 기준 상세 기록 조회 */
    public List<WeldingDTO> getRecordsBySummaryId(int summaryId) {
        String sql = "SELECT * FROM welding_records WHERE summary_id = ?";
        return jdbcTemplate.query(sql, (rs, num) -> mapRecord(rs), summaryId);
    }

    /** 셀형상별 상세 기록 조회 */
    public List<WeldingDTO> getRecordsByCellShape(String cellShape) {
        String sql = "SELECT * FROM welding_records WHERE cell_shape = ?";
        return jdbcTemplate.query(sql, (rs, num) -> mapRecord(rs), cellShape);
    }

    /** 해당구간별 상세 기록 조회 */
    public List<WeldingDTO> getRecordsBySection(String section) {
        String sql = "SELECT * FROM welding_records WHERE section = ?";
        return jdbcTemplate.query(sql, (rs, num) -> mapRecord(rs), section);
    }

    

    // ──────────────────────────────────────────
    // 집계 통계 쿼리
    // ──────────────────────────────────────────

    /** 셀형상별 평균 출력전류 / 출력전압 조회 */
    public List<WeldingDTO> getAvgByCellShape() {
        String sql = "SELECT cell_shape," +
                     " AVG(out_current) AS out_current," +
                     " AVG(out_voltage) AS out_voltage" +
                     " FROM welding_records" +
                     " GROUP BY cell_shape";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setCell_shape(rs.getString("cell_shape"));
            dto.setOut_current(rs.getDouble("out_current"));
            dto.setOut_voltage(rs.getDouble("out_voltage"));
            return dto;
        });
    }

    /** 해당구간별 총 용접장 집계 */
    public List<WeldingDTO> getTotalWeldLengthBySection() {
        String sql = "SELECT section," +
                     " SUM(weld_length) AS weld_length_rec" +
                     " FROM welding_records" +
                     " GROUP BY section";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setSection(rs.getString("section"));
            dto.setWeld_length_rec(rs.getDouble("weld_length_rec"));
            return dto;
        });
    }

    /** daily_summary + welding_records JOIN 전체 조회 */
    public List<WeldingDTO> getJoinAll() {
        String sql = "select * from daily_summary, welding_records";
        return jdbcTemplate.query(sql, (rs, num) -> {
            WeldingDTO dto = new WeldingDTO();
            dto.setId(rs.getInt("id"));
            dto.setWork_date(rs.getString("work_date"));
            dto.setVessel_no(rs.getString("vessel_no"));
            dto.setBlock(rs.getString("block"));
            dto.setAssy(rs.getString("assy"));
            dto.setWorker(rs.getString("worker"));
            return dto;
        });
    }

    // ──────────────────────────────────────────
    // 내부 공통 매핑 메서드
    // ──────────────────────────────────────────

    private WeldingDTO mapRecord(java.sql.ResultSet rs) throws java.sql.SQLException {
        WeldingDTO dto = new WeldingDTO();
        dto.setRecord_id(rs.getInt("id"));
        dto.setSummary_id(rs.getInt("summary_id"));
        dto.setTime_start(rs.getString("time_start"));
        dto.setTime_end(rs.getString("time_end"));
        dto.setArc_time_rec(rs.getString("arc_time"));
        dto.setWeld_length_rec(rs.getDouble("weld_length"));
        dto.setSet_current(rs.getDouble("set_current"));
        dto.setOut_current(rs.getDouble("out_current"));
        dto.setSet_voltage(rs.getDouble("set_voltage"));
        dto.setOut_voltage(rs.getDouble("out_voltage"));
        dto.setCell_shape(rs.getString("cell_shape"));
        dto.setSection(rs.getString("section"));
        dto.setLeg_length(rs.getInt("leg_length"));
        dto.setTotal_pass(rs.getInt("total_pass"));
        dto.setCurrent_pass(rs.getObject("current_pass") != null
                ? rs.getInt("current_pass") : null);
        return dto;
    }
}
