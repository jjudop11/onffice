package com.uni.spring.member.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.dept.model.service.DeptService;
import com.uni.spring.job.model.dto.Job;
import com.uni.spring.job.model.service.JobService;
import com.uni.spring.member.model.dto.Member;

import com.uni.spring.member.model.service.MemberService;

import oracle.net.aso.b;

@SessionAttributes({"loginUser", "msg"})
@Controller
public class MemberController {
	
	@Autowired 
	private MemberService memberService;
	
	@Autowired 
	private DeptService deptService;
	
	@Autowired 
	private JobService jobService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@GetMapping("main")
	public void main() {
		
	}
	
	@GetMapping("logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	@PostMapping("/login")
	public String loginUser(Member m, Model model) { 

		Member loginUser;
		try {
			
			loginUser = memberService.loginUser(bCryptPasswordEncoder, m);
			System.out.println("DB정보: "+loginUser);
			model.addAttribute("loginUser", loginUser);
			return "main";
			
		} catch (Exception e) {
			
			e.printStackTrace();
			model.addAttribute("msg", "로그인 실패");
			return "redirect:/"; 
		}

	}
	
	@GetMapping("/mypageForm")
	public String mypageForm() {	
		return "member/mypageForm"; 
	}
	
	@GetMapping("/managerpageForm")
	public String managerpageForm(@RequestParam(value="currentPage" , required = false, defaultValue = "1") int currentPage, Model model) {	
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		int listCount = memberService.selectMemListCount(loginUser.getCNo());
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<Member> list = memberService.selectMemList(pi, loginUser.getCNo());
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		return "member/managerpageForm"; 
	}
	
	@GetMapping("/insertMemberForm")
	public String insertMemberForm(Model model) {	
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
		ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());
		
		model.addAttribute("jList", jList);
		model.addAttribute("dList", dList);
		return "member/insertMemberForm"; 
	}
}
