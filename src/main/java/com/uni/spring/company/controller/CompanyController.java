package com.uni.spring.company.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.uni.spring.company.model.dto.Company;
import com.uni.spring.company.model.service.CompanyService;
import com.uni.spring.member.model.service.MemberService;


@Controller
public class CompanyController {
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private MemberService memberservice;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@GetMapping("/enrollForm")
	public String enrollForm() {	
		return "company/enrollForm"; 
	}
	
	@PostMapping("/insertCompany.do")
	public String insertMember(@ModelAttribute Company c, HttpSession session) {
	
		String encPwd = bCryptPasswordEncoder.encode(c.getCPwd());
		c.setCPwd(encPwd);
		companyService.insertCompany(c);
		//memberservice.insertCMember(c);
		session.setAttribute("msg", "회원가입에 성공했습니다, 로그인 후 사용하세요");
		return "redirect:/";	
	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public String idCheck(String id) {
		
		int count = companyService.idCheck(id);
		
		return String.valueOf(count);
	}
	
	@ResponseBody
	@PostMapping("/rNumCheck")
	public String rNumCheck(String rNum) {
		
		int count = companyService.rNumCheck(rNum);
		
		return String.valueOf(count);
	}
}
