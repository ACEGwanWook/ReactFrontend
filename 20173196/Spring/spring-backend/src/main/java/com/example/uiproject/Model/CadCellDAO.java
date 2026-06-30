package com.example.uiproject.Model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class CadCellDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    
    public List<CadCellDTO> getCellInfo(){
        String sql = "select * from cad_cell_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            CadCellDTO dto = new CadCellDTO();
            dto.setCellID(rs.getString("CellID"));
            dto.setProjNo(rs.getString("ProjNo"));
            dto.setCellType(rs.getString("CellType"));
            dto.setCellNo(rs.getString("CellNo"));
            dto.setCellData(rs.getString("CellDataLW"));
            dto.setAssyName(rs.getString("AssyName"));
            dto.setBlockName(rs.getString("BlockName"));
            dto.setCellDataDateTime(rs.getString("CellDataDateTime"));
            dto.setCellDataFolder(rs.getString("CellDataFileFolder"));
            dto.setCellDataFileName(rs.getString("CellDataFileName"));
            return dto;
        });
    }
    /* 도면 데이터 검색 */
    private static final RowMapper<CadCellDTO> CAD_CELL_MAPPER = (rs, i) -> {
        CadCellDTO dto = new CadCellDTO();
        dto.setCellID(rs.getString("CellID"));
        dto.setProjNo(rs.getString("ProjNo"));
        dto.setCellType(rs.getString("CellType"));
        dto.setCellNo(rs.getString("CellNo"));
        dto.setCellData(rs.getString("CellDataLW"));
        dto.setAssyName(rs.getString("AssyName"));
        dto.setBlockName(rs.getString("BlockName"));
        dto.setCellDataDateTime(rs.getString("CellDataDateTime"));
        dto.setCellDataFolder(rs.getString("CellDataFileFolder"));
        dto.setCellDataFileName(rs.getString("CellDataFileName"));
        return dto;
    };
    public List<CadCellDTO> getCellSearch(String ProjNo, String AssyName, String BlockName){
        StringBuilder sql = 
        new StringBuilder("select * from cad_cell_tbl WHERE 1=1");
        List<Object> args = new ArrayList<>();
        if (ProjNo != null && !ProjNo.isBlank()) {
            sql.append(" AND ProjNo LIKE ?");
            args.add("%" + ProjNo + "%");
        }
        if (AssyName != null && !AssyName.isBlank()) {
            sql.append(" AND AssyName LIKE ?");
            args.add("%" + AssyName + "%");
        }
        if (BlockName != null && !BlockName.isBlank()) {
            sql.append(" AND BlockName LIKE ?");
            args.add("%" + BlockName + "%");
        }
        return jdbcTemplate.query(sql.toString(), args.toArray(), CAD_CELL_MAPPER);
    }
    
    public void updateCellInfo(CadCellDTO dto){
        String sql = "update cad_cell_tbl set ProjNo = ?, BlockName = ?, AssyName = ?, CellDrawName = ?, CellDataFileName = ? where CellID = ?";
        jdbcTemplate.update(sql,dto.getProjNo(),dto.getBlockName(),dto.getAssyName(),
        "C"+dto.getProjNo()+"-"+dto.getBlockName()+"-"+dto.getAssyName()+".pdf",
        "C"+dto.getProjNo()+"-"+dto.getBlockName()+"-"+dto.getAssyName()+".csv",dto.getCellID());
    }

    public int InsertCellInfo(CadCellDTO dto){
        String cellNo = dto.getCellNo();
        if (cellNo == null || cellNo.isBlank()) {
            Integer max = jdbcTemplate.queryForObject("select coalesce(max(CellNo),0) from cad_cell_tbl", Integer.class);
            cellNo = String.valueOf(max + 1);
        }
        String sql = "insert into cad_cell_tbl(CellID, CellNo, ProjNo, BlockName, AssyName, CellDataDateTime, CellDrawName, CellDataFileName) values(?,?,?,?,?,now(),?,?)";
        return jdbcTemplate.update(sql,"C"+dto.getProjNo()+"-"+dto.getBlockName()+"-"+dto.getAssyName()+"_"+cellNo,cellNo,dto.getProjNo(),
        dto.getBlockName(),dto.getAssyName(),"C"+dto.getProjNo()+"-"+dto.getBlockName()+"-"+dto.getAssyName()+".pdf",
        "C"+dto.getProjNo()+"-"+dto.getBlockName()+"-"+dto.getAssyName()+".csv");
    }

    public void deleteCellInfo(String CellID){
        String sql = "delete from cad_cell_tbl where CellID = ?";
        jdbcTemplate.update(sql,CellID);
    }
}
