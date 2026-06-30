package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class PSChartDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    public List<PSChartDTO> getPSChart(){
        String sql = "select * from ps_chart";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            PSChartDTO dto = new PSChartDTO();
            dto.setMonth(rs.getInt("Month"));
            dto.setWorkTimes(rs.getInt("WorkTimes"));
            dto.setCuttingAmount(rs.getInt("CuttingAmount"));
            dto.setDefensiveCount(rs.getInt("DefensiveCount"));
            dto.setToolChance(rs.getInt("ToolChance"));
            return dto;
        });
    }
}
