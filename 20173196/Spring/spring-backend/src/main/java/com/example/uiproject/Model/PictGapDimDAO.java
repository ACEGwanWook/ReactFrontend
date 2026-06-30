package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class PictGapDimDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource; 
    public List<PictGapDimDTO> getPictGapDim(){
        String sql = "select * from pict_gap_dim ORDER BY PictFileDateTime asc";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            PictGapDimDTO dto = new PictGapDimDTO();
            dto.setProjNo(rs.getString("ProjNo"));
            dto.setBlockName(rs.getString("BlockName"));
            dto.setAssyName(rs.getString("AssyName"));
            dto.setCellNo(rs.getString("CellNo"));
            dto.setCellType(rs.getString("CellType"));
            dto.setRobotNo(rs.getString("RobotNo"));
            dto.setQualityTagInfo(rs.getString("QualityTagInfo"));
            dto.setPictFileDateTime(rs.getString("PictFileDateTime"));
            dto.setTagUser(rs.getString("TagUser"));
            dto.setQualityErrorDesc(rs.getString("QualityErrorDesc"));
            dto.setGap(rs.getString("Gap"));
            return dto;
        });
    }
}
