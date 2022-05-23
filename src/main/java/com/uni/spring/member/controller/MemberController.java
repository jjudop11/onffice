package com.uni.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.service.MemberService;

@SessionAttributes({"loginUser", "msg"})
@Controller
public class MemberController {
	
	@Autowired // 스캐닝을 통해서 인터페이스는 구현한 클래스(구현체) 중에 @Service로 등록 되어있는 빈을 찾아서 자동으로 주입 해줌
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@PostMapping("/login")
	public String loginUser(Member m, Model model) { 
		System.out.println("로그인정보: "+m);
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
}
