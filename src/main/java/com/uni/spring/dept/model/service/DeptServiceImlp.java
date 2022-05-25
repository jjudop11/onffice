package com.uni.spring.dept.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.dept.model.dao.DeptDao;
import com.uni.spring.dept.model.dto.Dept;

@Service
public class DeptServiceImlp implements DeptService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private DeptDao deptDao;
	@Override
	public ArrayList<Dept> selectDeptList(int cNo) {
		
		return deptDao.selectDeptList(sqlsession, cNo);
	}

}
