package com.uni.spring.dept.model.service;

import java.util.ArrayList;

import com.uni.spring.dept.model.dto.Dept;

public interface DeptService {

	ArrayList<Dept> selectDeptList(int cNo);

	int deletejd(Dept dept);

	int insertjd(Dept dept);

	int updatejd(Dept dept);

}
