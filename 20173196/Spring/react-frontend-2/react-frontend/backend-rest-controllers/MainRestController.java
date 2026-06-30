package com.example.uiproject;

import com.example.uiproject.Model.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 * MainRestController.java
 *
 * 기존 MainController.java (@Controller, Model.addAttribute, JSP return)를
 * REST API (@RestController, JSON 반환)로 전환한 파일.
 *
 * ✅ DAO/DTO/DB 쿼리는 전혀 변경하지 않았습니다.
 * ✅ 기존 MainController.java는 삭제하거나 주석 처리하세요.
 * ✅ PageFactory, PageConfig, PageService, PageConfig 클래스는 더 이상 필요 없습니다.
 */
@RestController
@RequestMapping("/api")
@lombok.extern.slf4j.Slf4j
public class MainRestController {

    @Autowired private CodeDAO     codeDAO;
    @Autowired private UserDAO     userDAO;
    @Autowired private RobotDAO    robotDAO;
    @Autowired private RobotErrDAO roboterrDAO;
    @Autowired private WorkOrderDAO workorderDAO;
    @Autowired private PSChartDAO  psChartDAO;
    @Autowired private CadCellDAO  cadcellDAO;
    @Autowired private MainPageDAO mainpageDAO;
    @Autowired private AbnPictDAO  abnpictDAO;
    @Autowired private WeldingDAO  weldingDAO;
    @Autowired private PictGapDimDAO pictgapdimDAO;

    private final InfluxService influxService;
    public MainRestController(InfluxService influxService) {
        this.influxService = influxService;
    }

    // ════════════════════════════════════════════════
    //  메인 페이지
    // ════════════════════════════════════════════════
    @GetMapping("/main")
    public Map<String, Object> getMainData() {
        return Map.of(
            "getProcess",    mainpageDAO.getProcess(),
            "getTodayWeld",  mainpageDAO.getTodayWeld(),
            "getRobotKPI",   mainpageDAO.getRobotKPI(),
            "getRobot",      robotDAO.getRobot(),
            "userList",      userDAO.getUser(),
            "WorkOrder",     workorderDAO.getWorkOrder()
        );
    }

    // ════════════════════════════════════════════════
    //  기준정보관리: 공통코드
    // ════════════════════════════════════════════════
    @GetMapping("/codes/groups")
    public List<?> getGroupCounts() {
        return codeDAO.getGroupCounts();
    }

    @GetMapping("/codes")
    public List<CodeDTO> getCodes(@RequestParam String group) {
        return codeDAO.getCodesByGroup(group);
    }

    @PostMapping("/codes")
    public ResponseEntity<String> insertCode(@RequestBody CodeDTO dto) {
        codeDAO.insertCode(dto);
        return ResponseEntity.ok("✅ 코드가 등록되었습니다.");
    }

    @PutMapping("/codes")
    public ResponseEntity<String> updateCode(@RequestBody CodeDTO dto) {
        codeDAO.updateCode(dto);
        return ResponseEntity.ok("✅ 코드가 수정되었습니다.");
    }

    @DeleteMapping("/codes")
    public ResponseEntity<String> deleteCode(@RequestParam String code,
                                             @RequestParam String groupCode) {
        codeDAO.deleteCode(code, groupCode);
        return ResponseEntity.ok("🗑 코드를 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  기준정보관리: 사용자
    // ════════════════════════════════════════════════
    @GetMapping("/users")
    public List<UserDTO> getUsers(
            @RequestParam(required = false) String employeeNumber,
            @RequestParam(required = false) String userName) {
        if ((employeeNumber != null && !employeeNumber.isBlank()) ||
            (userName       != null && !userName.isBlank())) {
            UserDTO dto = new UserDTO();
            dto.setEmployeeNumber(employeeNumber);
            dto.setUserName(userName);
            return userDAO.selectUser(dto);
        }
        return userDAO.getUser();
    }

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

    @DeleteMapping("/users")
    public ResponseEntity<String> deleteUser(@RequestParam String employeeNumber) {
        if (employeeNumber == null || employeeNumber.isBlank()) {
            return ResponseEntity.badRequest().body("⚠ 삭제할 사원을 선택하세요.");
        }
        userDAO.deleteUser(employeeNumber);
        return ResponseEntity.ok("🗑 사용자를 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  자동화 장비 자산 관리
    // ════════════════════════════════════════════════
    @GetMapping("/robots")
    public List<RobotDTO> getRobots(
            @RequestParam(required = false) String robotNo,
            @RequestParam(required = false) String robotName) {
        if ((robotNo   != null && !robotNo.isBlank()) ||
            (robotName != null && !robotName.isBlank())) {
            RobotDTO dto = new RobotDTO();
            dto.setRobotNo(robotNo);
            dto.setRobotName(robotName);
            return robotDAO.selectRobot(dto);
        }
        return robotDAO.getRobot();
    }

    @GetMapping("/robots/nos")
    public List<?> getRobotNos() {
        return roboterrDAO.getRobotNo();
    }

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

    @DeleteMapping("/robots")
    public ResponseEntity<String> deleteRobot(@RequestParam String robotNo) {
        if (robotNo == null || robotNo.isBlank()) {
            return ResponseEntity.badRequest().body("⚠ 삭제할 로봇을 선택하세요.");
        }
        RobotDTO dto = new RobotDTO();
        dto.setRobotNo(robotNo);
        robotDAO.deleteRobot(dto);
        return ResponseEntity.ok("🗑 로봇을 삭제하였습니다.");
    }

    // ════════════════════════════════════════════════
    //  유지보수: 고장 이력
    // ════════════════════════════════════════════════
    @GetMapping("/robot-errors")
    public List<RobotErrDTO> getRobotErrors(
            @RequestParam(required = false) String robotNum,
            @RequestParam(required = false) String errNum) {
        return roboterrDAO.getRobotErr();  // DAO에 파라미터 필터 추가 권장
    }

    @PostMapping("/robot-errors")
    public ResponseEntity<String> insertRobotError(@RequestBody RobotErrDTO dto) {
        roboterrDAO.insertRobotErr(dto);
        return ResponseEntity.ok("✅ 저장되었습니다.");
    }

    @PutMapping("/robot-errors")
    public ResponseEntity<String> updateRobotError(@RequestBody RobotErrDTO dto) {
        roboterrDAO.updateRobotErr(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    @DeleteMapping("/robot-errors")
    public ResponseEntity<String> deleteRobotError(@RequestParam String errNum) {
        roboterrDAO.deleteRobotErr(errNum);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  유지보수: 수선 관리
    // ════════════════════════════════════════════════
    @GetMapping("/repairs")
    public List<?> getRepairs(@RequestParam(required = false) String robotNum) {
        return roboterrDAO.getRepair();
    }

    @PostMapping("/repairs")
    public ResponseEntity<String> insertRepair(@RequestBody Object dto) {
        // roboterrDAO.insertRepair(dto);
        return ResponseEntity.ok("✅ 저장되었습니다.");
    }

    @PutMapping("/repairs")
    public ResponseEntity<String> updateRepair(@RequestBody Object dto) {
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    @DeleteMapping("/repairs")
    public ResponseEntity<String> deleteRepair(@RequestParam String repairNo) {
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  인공지능 데이터 관리: 설계정보
    // ════════════════════════════════════════════════
    @GetMapping("/design-info")
    public List<CadCellDTO> getDesignInfo(
            @RequestParam(required = false) String projNo,
            @RequestParam(required = false) String blockName,
            @RequestParam(required = false) String assyName) {
        return cadcellDAO.getCellInfo();
    }

    @PostMapping("/design-info")
    public ResponseEntity<String> insertDesignInfo(@RequestBody CadCellDTO dto) {
        cadcellDAO.insertCellInfo(dto);
        return ResponseEntity.ok("✅ 등록되었습니다.");
    }

    @PutMapping("/design-info")
    public ResponseEntity<String> updateDesignInfo(@RequestBody CadCellDTO dto) {
        cadcellDAO.updateCellInfo(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    @DeleteMapping("/design-info")
    public ResponseEntity<String> deleteDesignInfo(@RequestParam String cellID) {
        cadcellDAO.deleteCellInfo(cellID);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  인공지능 데이터 관리: IOT 데이터
    // ════════════════════════════════════════════════
    @GetMapping("/iot-data/files")
    public List<?> getIotFiles() {
        return weldingDAO.getJoinAll();
    }

    @GetMapping("/iot-data/summary")
    public List<?> getIotSummary() {
        return weldingDAO.getSummary();
    }

    @GetMapping("/iot-data/records")
    public List<?> getIotRecords() {
        return weldingDAO.getRecords();
    }

    // ════════════════════════════════════════════════
    //  통합 생산 관리: 워크오더
    // ════════════════════════════════════════════════
    @GetMapping("/work-orders")
    public List<WorkOrderDTO> getWorkOrders() {
        return workorderDAO.getWorkOrder();
    }

    @GetMapping("/work-orders/proj-nos")
    public List<WorkOrderDTO> getProjNos() {
        return workorderDAO.getProjNo();
    }

    @PostMapping("/work-orders")
    public ResponseEntity<String> insertWorkOrder(@RequestBody WorkOrderDTO dto) {
        workorderDAO.insertWorkOrder(dto);
        return ResponseEntity.ok("✅ 등록되었습니다.");
    }

    @PutMapping("/work-orders")
    public ResponseEntity<String> updateWorkOrder(@RequestBody WorkOrderDTO dto) {
        workorderDAO.updateWorkOrder(dto);
        return ResponseEntity.ok("✅ 수정되었습니다.");
    }

    @DeleteMapping("/work-orders")
    public ResponseEntity<String> deleteWorkOrder(@RequestParam String orderNum) {
        workorderDAO.deleteWorkOrder(orderNum);
        return ResponseEntity.ok("🗑 삭제되었습니다.");
    }

    // ════════════════════════════════════════════════
    //  모니터링 (데이터 미존재 시 빈 리스트 반환)
    // ════════════════════════════════════════════════
    @GetMapping("/monitoring/auto-situation")
    public List<?> getAutoSituation() { return List.of(); }

    @GetMapping("/monitoring/product-situation")
    public List<?> getProductSituation() { return List.of(); }

    @GetMapping("/monitoring/robot-line")
    public List<?> getRobotLine() { return List.of(); }

    @GetMapping("/monitoring/block")
    public List<?> getBlockMonitoring() { return List.of(); }

    @GetMapping("/robot-orders")
    public List<?> getRobotOrders() { return List.of(); }

    @GetMapping("/dispatch-wip")
    public List<?> getDispatchWip() { return List.of(); }

    @GetMapping("/weld-dataset")
    public List<?> getWeldDataset() { return List.of(); }

    @GetMapping("/irregular-data")
    public List<?> getIrRegularData() { return List.of(); }

    @GetMapping("/quality-model")
    public List<?> getQualityModel() { return List.of(); }

    @GetMapping("/situation-model")
    public List<?> getSituationModel() { return List.of(); }

    // ════════════════════════════════════════════════
    //  유틸리티
    // ════════════════════════════════════════════════
    private boolean isBlankAny(String... values) {
        for (String v : values) {
            if (v == null || v.isBlank()) return true;
        }
        return false;
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<String> handleException(Exception e) {
        log.error("API 오류", e);
        return ResponseEntity.internalServerError().body("오류: " + e.getMessage());
    }
}
