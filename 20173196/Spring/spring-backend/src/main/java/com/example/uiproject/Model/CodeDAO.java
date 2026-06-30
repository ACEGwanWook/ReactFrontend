package com.example.uiproject.Model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.util.*;

@Repository
public class CodeDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private DataSource dataSource;

    public List<GroupCountDTO> getGroupCounts() {
        String sql = "SELECT GroupName, GroupCode, COUNT(*) as count FROM code_tbl GROUP BY GroupName, GroupCode";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            GroupCountDTO dto = new GroupCountDTO();
            dto.setGroupName(rs.getString("GroupName"));
            dto.setGroupCode(rs.getString("GroupCode"));
            dto.setCount(rs.getInt("count"));
            return dto;
        });
    }
    public List<CodeDTO> getCodesByGroup(String groupName){
        String sql = "select * from code_tbl where GroupName = ?";

        return jdbcTemplate.query(sql, new Object[]{groupName},(rs, rowNum)->{
            CodeDTO dto = new CodeDTO();
            dto.setCode(rs.getString("CodeID"));
            dto.setCodeName(rs.getString("CodeName"));
            dto.setEtc1(rs.getString("Remarks1"));
            dto.setEtc2(rs.getString("Remarks2"));
            dto.setUseYn(rs.getString("CodeType"));
            dto.setGroupCode(rs.getString("GroupCode"));
            dto.setGroupName(rs.getString("GroupName"));
            return dto;
        });
    }
    public List<CodeDTO> getGrade(){
        String sql = "SELECT CodeName FROM code_tbl where GroupName = '직급코드' order by (Remarks2 + 0)";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            CodeDTO dto = new CodeDTO();
            dto.setEtc1(rs.getString("CodeName"));
            return dto;
        });
    }

    public void insertCode(CodeDTO dto){
        String sql = "insert into code_tbl values(?,?,?,?,?,?,?)";
        jdbcTemplate.update(sql,dto.getCode(),dto.getUseYn(),dto.getGroupName(),dto.getGroupCode(),dto.getCodeName(),dto.getEtc1(),dto.getEtc2());
    }

    public void updateCode(CodeDTO dto){
        String sql = "update code_tbl set CodeID = ?, CodeName = ?, Remarks1 = ?, Remarks2 = ?, `CodeType` = ? where CodeID = ?";
        jdbcTemplate.update(sql,dto.getCode(),dto.getCodeName(),dto.getEtc1(),dto.getEtc2(),dto.getUseYn(),dto.getCode());
    }

    public void deleteCode(String code){
        String sql = "delete from code_tbl where CodeID = ?";
        jdbcTemplate.update(sql,code);
    }

    public boolean isCodeExists(String code){
        String sql = "select count(*) from code_tbl where CodeID = ?";
        int count = jdbcTemplate.queryForObject(sql,Integer.class,code);
        return count > 0;
    }
}
