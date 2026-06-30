package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class RobotErrDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    public List<RobotErrDTO> getRobotErr(){
        String sql = "SELECT * from breakdn_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotErrDTO dto = new RobotErrDTO();
            dto.setRobotNum(rs.getString("RobotNo"));
            dto.setErrorNum(rs.getString("BreakdnNo"));
            dto.setErrorReason(rs.getString("BreakdnReason"));
            dto.setErrorDetail(rs.getString("BreakdnDesc"));
            dto.setErrorDate(rs.getString("BreakdnDate"));
            dto.setFile(rs.getString("File"));
            return dto;
        });
    }
    /* 에러 검색 */
    private static final RowMapper<RobotErrDTO> ROBOT_ERR_MAPPER = (rs, i) -> {
        RobotErrDTO dto = new RobotErrDTO();
        dto.setErrorNum   (rs.getString("BreakdnNo"));
        dto.setRobotNum   (rs.getString("RobotNo"));
        dto.setErrorDate  (rs.getString("BreakdnDate"));   // DATE/TIMESTAMP면 getTimestamp() 등으로
        dto.setErrorReason(rs.getString("BreakdnReason"));
        dto.setErrorDetail(rs.getString("BreakdnDesc"));
        dto.setFile       (rs.getString("File"));
        return dto;
    };

    public List<RobotErrDTO> getRoborErrSearch(String robotNo, String breakdnNo,
                                            String reason, String detail) {
        StringBuilder sql = new StringBuilder("SELECT * FROM breakdn_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();

        if (robotNo != null && !robotNo.isBlank()) {
            sql.append(" AND RobotNo LIKE ?");
            args.add("%" + robotNo + "%");
        }
        if (breakdnNo != null && !breakdnNo.isBlank()) {
            sql.append(" AND BreakdnNo LIKE ?");
            args.add("%" + breakdnNo + "%");
        }
        if (reason != null && !reason.isBlank()) {
            sql.append(" AND BreakdnReason LIKE ?");
            args.add("%" + reason + "%");
        }
        if (detail != null && !detail.isBlank()) {
            sql.append(" AND BreakdnDesc LIKE ?");
            args.add("%" + detail + "%");
        }

        return jdbcTemplate.query(sql.toString(), args.toArray(), ROBOT_ERR_MAPPER);
    }
    
    public List<RobotErrDTO> getRepair(){
        String sql = "select * from repair_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotErrDTO dto = new RobotErrDTO();
            dto.setReceiveNum(rs.getString("RepairNo"));
            dto.setErrorNum(rs.getString("BreakdnNo"));
            dto.setRobotNum(rs.getString("RobotNo"));
            dto.setReceiveDate(rs.getString("RepairDateTime"));
            dto.setReceivePart(rs.getString("RepairPart"));
            dto.setReceiveCost(rs.getString("RepairCost"));
            dto.setReceiveDetail(rs.getString("RepairDesc"));
            dto.setFile(rs.getString("File"));
            return dto;
        });
    }
    /* 수선 검색 */
    private static final RowMapper<RobotErrDTO> RECEIVE_MAPPER = (rs, i) -> {
        RobotErrDTO dto = new RobotErrDTO();
        dto.setRobotNum   (rs.getString("RobotNo"));
        dto.setErrorNum   (rs.getString("BreakdnNo"));
        dto.setReceiveNum (rs.getString("RepairNo"));
        dto.setReceiveDate  (rs.getString("RepairDateTime"));   // DATE/TIMESTAMP면 getTimestamp() 등으로
        dto.setReceivePart(rs.getString("RepairPart"));
        dto.setReceiveCost(rs.getString("RepairCost"));
        dto.setReceiveDetail(rs.getString("RepairDesc"));
        dto.setFile(rs.getString("File"));
        return dto;
    };

    public List<RobotErrDTO> getRepairSearch(String robotNo, String breakdnNo,
                                            String repairno, String detail, String part,
                                            String cost, String desc) {
        StringBuilder sql = new StringBuilder("SELECT * FROM repair_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();

        if (robotNo != null && !robotNo.isBlank()) {
            sql.append(" AND RobotNo LIKE ?");
            args.add("%" + robotNo + "%");
        }
        if (breakdnNo != null && !breakdnNo.isBlank()) {
            sql.append(" AND BreakdnNo LIKE ?");
            args.add("%" + breakdnNo + "%");
        }
        if (repairno != null && !repairno.isBlank()) {
            sql.append(" AND RepairNo LIKE ?");
            args.add("%" + repairno + "%");
        }
        if (part != null && !part.isBlank()) {
            sql.append(" AND RepairPart LIKE ?");
            args.add("%" + part + "%");
        }
        if (detail != null && !detail.isBlank()) {
            sql.append(" AND RepairDateTime LIKE ?");
            args.add("%" + detail + "%");
        }
        if (cost != null && !cost.isBlank()) {
            sql.append(" AND RepairCost LIKE ?");
            args.add(cost);
        }
        if (desc != null && !desc.isBlank()) {
            sql.append(" AND RepairDesc LIKE ?");
            args.add(desc);
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), RECEIVE_MAPPER);
    }

    public List<RobotErrDTO> getRobotNo(){
        String sql = "select distinct RobotNo from breakdn_tbl order by RobotNo";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotErrDTO dto = new RobotErrDTO();
            dto.setRobotNum(rs.getString("RobotNo"));
            return dto;
        });
    }

    public List<RobotErrDTO> getErrorReason(){
        String sql = "select distinct BreakdnReason from breakdn_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotErrDTO dto = new RobotErrDTO();
            dto.setErrorReason(rs.getString("BreakdnReason"));
            return dto;
        });
    }

    public List<RobotErrDTO> getRepairPart(){
        String sql = "select distinct RepairPart from repair_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotErrDTO dto = new RobotErrDTO();
            dto.setReceivePart(rs.getString("RepairPart"));
            return dto;
        });
    }

    public int insertError(RobotErrDTO dto){
        String sql = "insert into breakdn_tbl values(?,?,?,?,?,20173196)";
        return jdbcTemplate.update(sql,dto.getErrorNum(),dto.getRobotNum(),dto.getErrorDate(),dto.getErrorReason(),dto.getErrorDetail());
    }

    public int insertRepair(RobotErrDTO dto){
        String sql = "insert into repair_tbl values(?,?,?,?,?,?,?)";
        return jdbcTemplate.update(sql,dto.getReceiveNum(), dto.getErrorNum(), dto.getRobotNum(), dto.getReceiveDate(),
        dto.getReceivePart(), dto.getReceiveCost(), dto.getReceiveDetail());
    }

    public void updateError(RobotErrDTO dto){
        String sql = "update breakdn_tbl set RobotNo = ?, BreakdnReason = ?, BreakdnDesc = ? where BreakdnNo = ?";
        jdbcTemplate.update(sql,dto.getRobotNum(),dto.getErrorReason(),dto.getErrorDetail(),dto.getErrorNum());
    }

    public void updateRepair(RobotErrDTO dto){
        String sql = "update repair_tbl set RepairDateTime = ?, RepairPart = ?, RepairCost = ?, RepairDesc = ? where RepairNo = ?";
        jdbcTemplate.update(sql,dto.getReceiveDate(),dto.getReceivePart(),dto.getReceiveCost(),dto.getReceiveDetail(),dto.getReceiveNum());
    }

    public void deleteError(String errorNum){
        String sql = "delete from breakdn_tbl where BreakdnNo = ?";
        jdbcTemplate.update(sql,errorNum);
    }

    public void deleteReceive(String repairNum){
        String sql = "delete from repair_tbl where RepairNo = ?";
        jdbcTemplate.update(sql,repairNum);
    }
}
