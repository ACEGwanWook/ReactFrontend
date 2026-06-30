package com.example.uiproject.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;
@Repository
public class UserDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;
    public List<UserDTO> getUser() {
        String sql = "SELECT * from user_tbl";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            UserDTO dto = new UserDTO();
            dto.setEmployeeNumber(rs.getString("EmployeeNumber"));
            dto.setUserName(rs.getString("UserName"));
            dto.setGroupName(rs.getString("CompanyName"));
            dto.setDepartName(rs.getString("DepartName"));
            dto.setSectionName(rs.getString("SectionName"));
            dto.setTeamName(rs.getString("TeamName"));
            dto.setClassName(rs.getString("ClassName"));
            dto.setPosition(rs.getString("Position"));
            dto.setGrade(rs.getString("JobGrade"));
            dto.setEmail(rs.getString("Email"));
            dto.setPhoneNumber(rs.getString("PhoneNumber"));
            dto.setPasswordHash(rs.getString("PasswordHash"));
            dto.setHireDate(rs.getString("HireDate"));
            dto.setAccessLevel(rs.getString("AccessLevel"));
            return dto;
        });
    }

    /*private String buildDebugSql(String sql, Object[] params) {
        for (Object param : params) {
            String value = param == null ? "NULL" : "'" + param.toString() + "'";
            sql = sql.replaceFirst("\\?", value);
        }
        return sql;
    }*/

    public List<UserDTO> selectUser(UserDTO dto){
        String sql = "select * from user_tbl where EmployeeNumber like ? and UserName like ? and CompanyName like ? and DepartName like ?" +
                " and SectionName like ? and TeamName like ? and HireDate like ? and Position like ? and JobGrade like ?";
        return jdbcTemplate.query(sql,new Object[]{
                "%" + dto.getEmployeeNumber() + "%",
                "%" + dto.getUserName() + "%",
                "%" + dto.getGroupName() + "%",
                "%" + dto.getDepartName() + "%",
                "%" + dto.getSectionName() + "%",
                "%" + dto.getTeamName() + "%",
                "%" + dto.getHireDate() + "%",
                "%" + dto.getPosition() + "%",
                "%" + dto.getGrade() + "%"
        },(rs, rowNum)->{
            UserDTO user = new UserDTO();
            user.setEmployeeNumber(rs.getString("EmployeeNumber"));
            user.setUserName(rs.getString("UserName"));
            user.setGroupName(rs.getString("CompanyName"));
            user.setDepartName(rs.getString("DepartName"));
            user.setSectionName(rs.getString("SectionName"));
            user.setTeamName(rs.getString("TeamName"));
            user.setHireDate(rs.getString("HireDate"));
            user.setPosition(rs.getString("Position"));
            user.setGrade(rs.getString("JobGrade"));
            return user;
        });
    }

    public void insertUser(UserDTO dto){
        String sql = "insert into user_tbl values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        jdbcTemplate.update(sql,dto.getEmployeeNumber(), dto.getUserName(), dto.getGroupName(), dto.getDepartName(),dto.getSectionName(),
                dto.getTeamName(), "NA",dto.getHireDate(),dto.getPosition(), dto.getGrade(), "NA","NA","NA","Level1");
    }

    public void updateUser(UserDTO dto){
        String sql = "update user_tbl set EmployeeNumber = ?, UserName = ?, CompanyName = ?, DepartName = ?, SectionName = ?, TeamName = ?," +
                " Position = ?, JobGrade = ?, HireDate = ? where EmployeeNumber = ?";
        jdbcTemplate.update(sql,dto.getEmployeeNumber(),dto.getUserName(),dto.getGroupName(),dto.getDepartName(),dto.getSectionName(),
                dto.getTeamName(),dto.getPosition(),dto.getGrade(),dto.getHireDate(), dto.getEmployeeNumber());
    }

    public void deleteUser(String EmployeeNumber){
        String sql = "delete from user_tbl where EmployeeNumber = ?";
        jdbcTemplate.update(sql,EmployeeNumber);
    }

    public boolean isUserExists(String EmployeeNumber){
        String sql = "select count(*) from user_tbl where EmployeeNumber = ?";
        int count = jdbcTemplate.queryForObject(sql,Integer.class,EmployeeNumber);
        return count > 0;
    }
}
