package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class MainPageDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;

    public List<PrecedingProcessDTO> getProcess() {
        String sql = "SELECT * from preceding_process";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            PrecedingProcessDTO dto = new PrecedingProcessDTO();
            dto.setDivision(rs.getString("division"));
            dto.setPerformance(rs.getInt("performance"));
            dto.setExpectation(rs.getInt("expectation"));
            dto.setDiff(rs.getInt("diff"));
            dto.setUnproperfom(rs.getInt("unproperfom"));
            dto.setUnproexpect(rs.getInt("unproexpect"));
            dto.setUnprodiff(rs.getInt("unprodiff"));
            return dto;
        });
    }

    public List<TodayWeldDTO> getTodayWeld() {
        String sql = "SELECT * from today_weld";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            TodayWeldDTO dto = new TodayWeldDTO();
            dto.setProcess(rs.getString("process"));
            dto.setPerformance(rs.getString("performance"));
            dto.setExpectation(rs.getString("expectation"));
            dto.setProgress(rs.getString("progress"));
            dto.setError(rs.getString("Error"));
            dto.setErrorrate(rs.getString("errorrate"));
            return dto;
        });
    }

    public List<RobotKPIDTO> getRobotKPI() {
        String sql = "SELECT * from robot_kpi";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotKPIDTO dto = new RobotKPIDTO();
            dto.setRobot(rs.getString("robot"));
            dto.setRobotcount(rs.getInt("robotcount"));
            dto.setOperate(rs.getInt("operate"));
            dto.setWait(rs.getInt("wait"));
            dto.setError(rs.getInt("error"));
            dto.setOperationrate(rs.getInt("operationrate"));
            dto.setControlrate(rs.getInt("controlrate"));
            dto.setProductivity(rs.getInt("productivity"));
            dto.setAccuracy(rs.getInt("accuracy"));
            return dto;
        });
    }
}
