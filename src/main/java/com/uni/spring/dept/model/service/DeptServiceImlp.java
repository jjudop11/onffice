package com.uni.spring.dept.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.exception.CommException;
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

	@Override
	public int deletejd(Dept dept) {
		
		return deptDao.deletejd(sqlsession, dept);

	}

	@Override
	public int insertjd(Dept dept) {
		
		return deptDao.insertjd(sqlsession, dept);

	}

	@Override
	public int updatejd(Dept dept) {
		// TODO Auto-generated method stub
		return deptDao.updatejd(sqlsession, dept);
	}

}
