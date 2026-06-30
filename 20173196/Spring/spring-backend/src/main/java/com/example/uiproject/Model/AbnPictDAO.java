package com.example.uiproject.Model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class AbnPictDAO{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    
    public List<AbnPictDTO> getAbnPict(){
        String sql = "SELECT * FROM abn_pict_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            AbnPictDTO dto = new AbnPictDTO();
            dto.setErrNum(rs.getString("ErrNum"));
            dto.setErrDate(rs.getString("ErrDate"));
            dto.setProjNo(rs.getString("ProjNo"));
            dto.setBlockName(rs.getString("BlockName"));
            dto.setRobotNo(rs.getString("RobotNo"));
            dto.setErrInfo(rs.getString("ErrInfo"));
            dto.setLocationMM(rs.getString("LocationMM"));
            dto.setLocationX(rs.getString("LocationX"));
            dto.setLocationY(rs.getString("LocationY"));
            dto.setAction(rs.getString("Action"));
            dto.setAssy(rs.getString("Assy"));
            dto.setCellNum(rs.getString("CellNum"));
            return dto;
        });
    }

    public List<AbnPictDTO> getCount(){
        String sql = "SELECT COUNT(*) as count FROM abn_pict_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            AbnPictDTO dto = new AbnPictDTO();
            dto.setCount(rs.getInt("count"));
            return dto;
        });
    }

    public List<AbnPictDTO> getErrInfo(){
        String sql = "SELECT distinct ErrInfo FROM abn_pict_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            AbnPictDTO dto = new AbnPictDTO();
            dto.setErrInfo(rs.getString("ErrInfo"));
            return dto;
        });
    }

    public List<AbnPictDTO> getAction(){
        String sql = "SELECT distinct Action FROM abn_pict_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            AbnPictDTO dto = new AbnPictDTO();
            dto.setAction(rs.getString("Action"));
            return dto;
        });
    }

    /* 불량 데이터 검색 */
    private static final RowMapper<AbnPictDTO> CAD_CELL_MAPPER = (rs, i) -> {
        AbnPictDTO dto = new AbnPictDTO();
        dto.setErrNum(rs.getString("ErrNum"));
        dto.setErrDate(rs.getString("ErrDate"));
        dto.setProjNo(rs.getString("ProjNo"));
        dto.setBlockName(rs.getString("BlockName"));
        dto.setRobotNo(rs.getString("RobotNo"));
        dto.setErrInfo(rs.getString("ErrInfo"));
        dto.setLocationMM(rs.getString("LocationMM"));
        dto.setLocationX(rs.getString("LocationX"));
        dto.setLocationY(rs.getString("LocationY"));
        dto.setAction(rs.getString("Action"));
        dto.setCount(rs.getInt("count"));
        dto.setAssy(rs.getString("Assy"));
        dto.setCellNum(rs.getString("CellNum"));
        return dto;
    };
    public List<AbnPictDTO> getAbnSearch(String ErrDate, String ProjNo, String RobotNo, String ErrInfo, String Action){
        StringBuilder sql = 
        new StringBuilder("select t.*, COUNT(*) OVER () AS count FROM abn_pict_tbl AS t WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (ErrDate != null && !ErrDate.isBlank()) {
            sql.append(" AND ErrDate LIKE ?");
            args.add("%" + ErrDate + "%");
        }
        if (ProjNo != null && !ProjNo.isBlank()) {
            sql.append(" AND ProjNo LIKE ?");
            args.add("%" + ProjNo + "%");
        }
        if (RobotNo != null && !RobotNo.isBlank()) {
            sql.append(" AND RobotNo LIKE ?");
            args.add("%" + RobotNo + "%");
        }
        if (ErrInfo != null && !ErrInfo.isBlank()) {
            sql.append(" AND ErrInfo LIKE ?");
            args.add("%" + ErrInfo + "%");
        }
        if (Action != null && !Action.isBlank()) {
            sql.append(" AND Action LIKE ?");
            args.add("%" + Action + "%");
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), CAD_CELL_MAPPER);
    }
    public void updateAbnPict(AbnPictDTO dto){
        String sql = "update abn_pict_tbl set ErrDate = ?, ProjNo = ?, RobotNo = ?, ErrInfo = ?, Action = ? where ErrNum = ?";
        jdbcTemplate.update(sql, dto.getErrDate(), dto.getProjNo(), dto.getRobotNo(), dto.getErrInfo(), dto.getAction(), dto.getErrNum());
    }
}