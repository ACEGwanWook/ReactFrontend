package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class WorkOrderDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    public List<WorkOrderDTO> getWorkOrder(){
        String sql = "select * from work_order_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            WorkOrderDTO dto = new WorkOrderDTO();
            dto.setOrderNum(rs.getString("ProdActID"));
            dto.setOrderDate(rs.getString("OrderDate"));
            dto.setWorkLine(rs.getString("ProjNo"));
            dto.setWorkBlock(rs.getString("BlockName"));
            dto.setAssyName(rs.getString("AssyName"));
            dto.setEquipNum(rs.getString("RobotNo"));
            dto.setWorkAdmin(rs.getString("EmployeeNumber"));
            dto.setWorkDetail(rs.getString("WorkDetail"));
            dto.setPerformanceNum(rs.getString("ProdActNo"));
            dto.setFinish(rs.getString("FinishStatus"));
            dto.setWorkNum(rs.getString("WorkNum"));
            dto.setWorkStart(rs.getString("StartDateTime"));
            dto.setWorkEnd(rs.getString("FinishDateTime"));
            dto.setAiact(rs.getString("AIAct"));
            return dto;
        });
    }

    public List<WorkOrderDTO> getWorkOrderbyNum(String OrderNum){
        String sql = "select * from work_order_tbl where ProdActID = ?";
        return jdbcTemplate.query(sql, new Object[]{OrderNum}, (rs, rowNum) -> {
            WorkOrderDTO dto = new WorkOrderDTO();
            dto.setOrderNum(rs.getString("ProdActID"));
            dto.setOrderDate(rs.getString("OrderDate"));
            dto.setWorkLine(rs.getString("ProjNo"));
            dto.setWorkBlock(rs.getString("BlockName"));
            dto.setAssyName(rs.getString("AssyName"));
            dto.setEquipNum(rs.getString("RobotNo"));
            dto.setWorkAdmin(rs.getString("EmployeeNumber"));
            dto.setWorkDetail(rs.getString("WorkDetail"));
            dto.setPerformanceNum(rs.getString("ProdActNo"));
            dto.setFinish(rs.getString("FinishStatus"));
            dto.setWorkNum(rs.getString("WorkNum"));
            dto.setWorkStart(rs.getString("StartDateTime"));
            dto.setWorkEnd(rs.getString("FinishDateTime"));
            dto.setAiact(rs.getString("AIAct"));
            return dto;
        });
    }

    public List<WorkOrderDTO> getProjNo(){
        String sql = "select distinct ProjNo from work_order_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            WorkOrderDTO dto = new WorkOrderDTO();
            dto.setWorkLine(rs.getString("ProjNo"));
            return dto;
        });
    }

    /* 도면 데이터 검색 */
    private static final RowMapper<WorkOrderDTO> WORK_ORDER_MAPPER = (rs, i) -> {
        WorkOrderDTO dto = new WorkOrderDTO();
        dto.setOrderNum(rs.getString("ProdActID"));
        dto.setOrderDate(rs.getString("OrderDate"));
        dto.setWorkLine(rs.getString("ProjNo"));
        dto.setWorkBlock(rs.getString("BlockName"));
        dto.setAssyName(rs.getString("AssyName"));
        dto.setEquipNum(rs.getString("RobotNo"));
        dto.setWorkAdmin(rs.getString("EmployeeNumber"));
        dto.setWorkDetail(rs.getString("WorkDetail"));
        dto.setPerformanceNum(rs.getString("ProdActNo"));
        dto.setFinish(rs.getString("FinishStatus"));
        dto.setWorkNum(rs.getString("WorkNum"));
        dto.setWorkStart(rs.getString("StartDateTime"));
        dto.setWorkEnd(rs.getString("FinishDateTime"));
        dto.setAiact(rs.getString("AIAct"));
        return dto;
    };
    public List<WorkOrderDTO> getWorkOrderSearch(String OrderDate, String ProdActID){
        StringBuilder sql = 
        new StringBuilder("select * from work_order_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (OrderDate != null && !OrderDate.isBlank()) {
            sql.append(" AND OrderDate LIKE ?");
            args.add("%" + OrderDate + "%");
        }
        if (ProdActID != null && !ProdActID.isBlank()) {
            sql.append(" AND ProdActID LIKE ?");
            args.add("%" + ProdActID + "%");
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), WORK_ORDER_MAPPER);
    }
    /* 5-2 */
    public List<WorkOrderDTO> getWorkOrderSearchByDate(String StartDate, String EndDate, String EquipNum, String Finish){
        StringBuilder sql = 
        new StringBuilder("select * from work_order_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (StartDate != null && EndDate != null && !StartDate.isBlank() && !EndDate.isBlank()) {
            sql.append(" AND OrderDate BETWEEN ? AND ?");
            args.add(StartDate);   // "YYYY-MM-DD"
            args.add(EndDate);     // "YYYY-MM-DD"
        } else if (StartDate != null && !StartDate.isBlank()) {
            sql.append(" AND OrderDate >= ?");
            args.add(StartDate);
        } else if (EndDate != null && !EndDate.isBlank()) {
            sql.append(" AND OrderDate <= ?");
            args.add(EndDate);
        }
        if (EquipNum != null && !EquipNum.isBlank()) {
            sql.append(" AND RobotNo LIKE ?");
            args.add("%" + EquipNum + "%");
        }
        if (Finish != null && !Finish.isBlank()) {
            sql.append(" AND FinishStatus = ?");
            args.add(Finish);
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), WORK_ORDER_MAPPER);
    }
    /* 5-1 */
    public List<WorkOrderDTO> getWorkOrderSearch(String OrderDate, String ProdActID, String EquipNum, String ProjNo, String BlockName, String AssyName, 
        String EmployeeNumber, String AIAct, String ProdActNo, String FinishDateTime, String FinishStatus){
        StringBuilder sql = 
        new StringBuilder("select * from work_order_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (OrderDate != null && !OrderDate.isBlank()) {
            sql.append(" AND OrderDate LIKE ?");
            args.add("%" + OrderDate + "%");
        }
        if (ProdActID != null && !ProdActID.isBlank()) {
            sql.append(" AND ProdActID LIKE ?");
            args.add(ProdActID);
        }
        if (EquipNum != null && !EquipNum.isBlank()) {
            sql.append(" AND RobotNo = ?");
            args.add(EquipNum);
        }
        if (ProjNo != null && !ProjNo.isBlank()) {
            sql.append(" AND ProjNo = ?");
            args.add(ProjNo);
        }
        if (BlockName != null && !BlockName.isBlank()) {
            sql.append(" AND BlockName = ?");
            args.add(BlockName);
        }
        if (AssyName != null && !AssyName.isBlank()) {
            sql.append(" AND AssyName = ?");
            args.add(AssyName);
        }
        if (EmployeeNumber != null && !EmployeeNumber.isBlank()) {
            sql.append(" AND EmployeeNumber LIKE ?");
            args.add(EmployeeNumber);
        }
        if (AIAct != null && !AIAct.isBlank()) {
            sql.append(" AND AIAct LIKE ?");
            args.add(AIAct);
        }
        if (ProdActNo != null && !ProdActNo.isBlank()) {
            sql.append(" AND ProdActNo LIKE ?");
            args.add(ProdActNo);
        }
        if (FinishDateTime != null && !FinishDateTime.isBlank()) {
            sql.append(" AND FinishDateTime LIKE ?");
            args.add(FinishDateTime);
        }
        if (FinishStatus != null && !FinishStatus.isBlank()) {
            sql.append(" AND FinishStatus LIKE ?");
            args.add(FinishStatus);
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), WORK_ORDER_MAPPER);
    }
    public void updateWorkOrder(WorkOrderDTO dto){
        String sql = "update work_order_tbl set OrderDate = ?, WorkNum = ?, StartDateTime = ?, FinishDateTime = ? where ProdActID = ?";
        jdbcTemplate.update(sql,dto.getOrderDate(),dto.getWorkNum(),dto.getWorkStart(),dto.getWorkEnd(),dto.getOrderNum());        
    }
    /* 5-1 */
    public void updateWorkOrderOverride(WorkOrderDTO dto){
        String sql = "update work_order_tbl set OrderDate = ?, RobotNo = ?, ProjNo = ?, BlockName = ?," +
        " AssyName = ?, EmployeeNumber = ?, AIAct = ?, ProdActNo = ?, FinishDateTime = ?, FinishStatus = ? where ProdActID = ?";
        System.out.println(dto.getAiact());
        jdbcTemplate.update(sql,dto.getOrderDate(),dto.getEquipNum(),dto.getWorkLine(),dto.getWorkBlock(), dto.getAssyName(),
        dto.getWorkAdmin(),dto.getAiact(),dto.getPerformanceNum(),dto.getWorkEnd(), dto.getFinish(),dto.getOrderNum());       
    }
    /* 워크오더 등록 */
    public void insertWorkOrder(WorkOrderDTO dto){
        String sql = "insert into work_order_tbl(ProdActID, OrderDate, ProjNo, BlockName, AssyName, ProdActNo, RobotNo, " +
        "EmployeeNumber, AIAct, StartDateTime, FinishDateTime, FinishStatus) values(?,?,?,?,?,?,?,?,?,?,?,?)";
        jdbcTemplate.update(sql,dto.getOrderNum(),dto.getOrderDate(),dto.getWorkLine(),dto.getWorkBlock(),dto.getAssyName(),
        dto.getPerformanceNum(),dto.getEquipNum(),dto.getWorkAdmin(),dto.getAiact(),dto.getWorkStart(),dto.getWorkEnd(),dto.getFinish());
    }

    public void deleteWorkOrder(String ProdActID){
        String sql = "delete from work_order_tbl where ProdActID = ?";
        jdbcTemplate.update(sql,ProdActID);
    }
}
