package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class RobotDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    public List<RobotDTO> getRobot(){
        String sql = "select * from robot_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            RobotDTO dto = new RobotDTO();
            dto.setRobotNo(rs.getString("RobotNo"));
            dto.setRobotName(rs.getString("RobotName"));
            dto.setMaker(rs.getString("Maker"));
            dto.setModelName(rs.getString("ModelName"));
            dto.setSerialName(rs.getString("SerialNo"));
            dto.setWeight(rs.getString("Weight"));
            dto.setIntroDate(rs.getString("PurchDate"));
            dto.setInspectDate(rs.getString("InspectDate"));
            dto.setInspectCycle(rs.getString("MaintPeriod"));
            dto.setRobotType(rs.getString("RobotType"));
            return dto;
        });
    }

    public List<RobotDTO> selectRobot(RobotDTO dto){
        String sql = "select * from robot_tbl where RobotNo like ? and RobotName like ? and Maker like ? and ModelName like ?" +
                " and SerialNo like ? and Weight like ? and PurchDate like ? and InspectDate like ? and MaintPeriod like ? and RobotType like ?";
        return jdbcTemplate.query(sql,new Object[]{
                "%" + dto.getRobotNo() + "%",
                "%" + dto.getRobotName() + "%",
                "%" + dto.getMaker() + "%",
                "%" + dto.getModelName() + "%",
                "%" + dto.getSerialName() + "%",
                "%" + dto.getWeight() + "%",
                "%" + dto.getIntroDate() + "%",
                "%" + dto.getInspectDate() + "%",
                "%" + dto.getInspectCycle() + "%",
                "%" + dto.getRobotType() + "%"
        },(rs, rowNum)->{
            RobotDTO user = new RobotDTO();
            user.setRobotNo(rs.getString("RobotNo"));
            user.setRobotName(rs.getString("RobotName"));
            user.setMaker(rs.getString("Maker"));
            user.setModelName(rs.getString("ModelName"));
            user.setSerialName(rs.getString("SerialNo"));
            user.setWeight(rs.getString("Weight"));
            user.setIntroDate(rs.getString("PurchDate"));
            user.setInspectDate(rs.getString("InspectDate"));
            user.setInspectCycle(rs.getString("MaintPeriod"));
            user.setRobotType(rs.getString("RobotType"));
            return user;
        });
    }

    public void insertRobot(RobotDTO dto){
        String sql = "insert into robot_tbl(RobotNo, RobotName, Maker, ModelName, SerialNo, Weight, PurchDate, InspectDate, MaintPeriod, RobotType) values(?,?,?,?,?,?,?,?,?,?)";
        jdbcTemplate.update(sql,dto.getRobotNo(),dto.getRobotName(),dto.getMaker(),dto.getModelName(),dto.getSerialName(),dto.getWeight(),
                dto.getIntroDate(),dto.getInspectDate(),dto.getInspectCycle(),dto.getRobotType());
    }

    public void updateRobot(RobotDTO dto){
        String sql = "update robot_tbl set RobotNo = ?, RobotName = ?, Maker = ?, ModelName = ?, SerialNo = ?, Weight = ?," +
                "PurchDate = ?, InspectDate = ?, MaintPeriod = ?, RobotType = ? where RobotNo = ?";
        jdbcTemplate.update(sql,dto.getRobotNo(),dto.getRobotName(),dto.getMaker(),dto.getModelName(),dto.getSerialName(),dto.getWeight(),
                dto.getIntroDate(),dto.getInspectDate(),dto.getInspectCycle(),dto.getRobotType(),dto.getRobotNo());

    }

    public void deleteRobot(RobotDTO dto){
        String sql = "delete from robot_tbl where RobotNo = ?";
        jdbcTemplate.update(sql,dto.getRobotNo());
    }
}
