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
	public ArrayList<Dept> deletejd(Dept dept) {
		
		int result = deptDao.deletejd(sqlsession, dept);
		
		if(result > 0) {
			return deptDao.selectDeptList(sqlsession, dept.getCNo());
		} else {
			throw new CommException("부서 삭제 실패했습니다");
		}
	}

	@Override
	public ArrayList<Dept> insertjd(Dept dept) {
		
		int result = deptDao.insertjd(sqlsession, dept);
		
		if(result > 0) {
			return deptDao.selectDeptList(sqlsession, dept.getCNo());
		} else {
			throw new CommException("부서 추가 실패했습니다");
		}	
	}

}
