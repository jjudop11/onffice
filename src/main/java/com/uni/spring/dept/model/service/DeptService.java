package com.uni.spring.dept.model.service;

import java.util.ArrayList;

import com.uni.spring.dept.model.dto.Dept;

public interface DeptService {

	ArrayList<Dept> selectDeptList(int cNo);

	ArrayList<Dept> deletejd(Dept dept);

	ArrayList<Dept> insertjd(Dept dept);

}
