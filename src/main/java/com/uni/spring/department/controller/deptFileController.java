package com.uni.spring.department.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.uni.spring.department.service.deptFileService;

@Controller
public class deptFileController {
	
	@Autowired
	public deptFileService deptfileservice;
	
	@RequestMapping("deptView.do")
	public String mainview() {
		
		return "department/DepMainView";
	}

}
