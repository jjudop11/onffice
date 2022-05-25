package com.uni.spring.dept.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.dept.model.dto.Dept;

@Repository
public class DeptDao {

	public ArrayList<Dept> selectDeptList(SqlSessionTemplate sqlsession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("DeptMapper.selectDeptList", cNo);
	}

}