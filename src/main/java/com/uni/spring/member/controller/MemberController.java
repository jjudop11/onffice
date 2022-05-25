package com.uni.spring.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.dept.model.service.DeptService;
import com.uni.spring.job.model.dto.Job;
import com.uni.spring.job.model.service.JobService;

import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.dto.Photo;
import com.uni.spring.member.model.service.MemberService;

import lombok.Builder;

@SessionAttributes({"loginUser", "msg"})
@Controller
public class MemberController {
	
	@Autowired 
	private MemberService memberService;

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
	public ModelAndView loginUser(Member m, Model model, ModelAndView mv) { 

		Member loginUser = memberService.loginUser(bCryptPasswordEncoder, m);
		
		System.out.println("DB정보: "+loginUser);
		
		if(m.getMPwd().equals("0") && loginUser != null) {
			mv.addObject("loginUser", loginUser).addObject("msg","첫로그인 입니다. 비밀번호를 변경하세요").setViewName("member/updatePwdForm");
		} else {
			mv.addObject("loginUser", loginUser).setViewName("main");
		}
		
		return mv;

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

	@GetMapping("detailMember")
	public String selectMember(String mNo, Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		Member m = memberService.selectMember(mNo);
		
		ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
		ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());

		model.addAttribute("jList", jList);
		model.addAttribute("dList", dList);
		model.addAttribute("m", m);
		
		return "member/detailMemberForm";
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
	
	@PostMapping("/insertMember")
	public String insertMember(Member m, @RequestParam("post") String post,
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, 
			HttpServletRequest request, @RequestParam(name = "file", required = false) MultipartFile file,
			Model model, HttpSession session) {
		
		String encPwd = bCryptPasswordEncoder.encode("0");
		int ran = (int)(Math.random() * 1000) + 1;
		
		if(!file.getOriginalFilename().equals("")) { 
			String changeName = saveFile(file, request);
			System.out.println("changeNamechangeNamechangeNamechangeName"+changeName);
			if(changeName != null) {
				String resources = request.getSession().getServletContext().getRealPath("resources"); 
				String savePath = resources + "\\id_pictures\\";

				Photo p = Photo.builder()
						.pName(changeName)
						.pPath(savePath)
						.build();
				memberService.insertPhoto(p);
				System.out.println("=============================사진 삽입");
			}
		}
		m.setMAddress(post +"/"+ address1 +"/"+ address2);
		m.setMPwd(encPwd);
		m.setMNo(String.valueOf(m.getCNo())+m.getDNo()+m.getJNo()+String.valueOf(ran));
		
		memberService.insertMember(m);
		session.setAttribute("msg","신규사원등록완료");
		return "redirect:/managerpageForm";	
	}
	
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		
		String resources = request.getSession().getServletContext().getRealPath("resources"); // 웹컨터이너에서의 resources 폴더까지의 경로

		String savePath = resources + "\\id_pictures\\";
		
		String originName = file.getOriginalFilename();
		
		String currentTile = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		String ext = originName.substring(originName.lastIndexOf(".")); // 파일명에서 확장자명 추출
	
		String changeName = currentTile + ext;
		
		try {
			file.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			throw new CommException("파일 업로드 에러");
		}
		return changeName;
	}
	
	@PostMapping("/updateMember")
	public String updateMember(Member m, @RequestParam("post") String post,
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, Model model) {
		
		//Member loginUser = (Member)model.getAttribute("loginUser");
		if(m.getMEntDate().equals(2022-05-24)) {
			m.setMEntDate(null);
		}
		m.setMAddress(post +"/"+ address1 +"/"+ address2);
		Member updateM = memberService.updateMember(m);
		
		ArrayList<Job> jList = jobService.selectJobList(m.getCNo());
		ArrayList<Dept> dList = deptService.selectDeptList(m.getCNo());

		model.addAttribute("jList", jList);
		model.addAttribute("dList", dList);
		model.addAttribute("m", updateM);
		return "member/detailMemberForm"; 
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember(String mNo, Model model) {
		
		memberService.deleteMember(mNo);

		model.addAttribute("msg", "퇴사등록 완료");
		return "redirect:/managerpageForm"; 
	}
	
	@PostMapping("/updateMypage")
	public String updateMypage(Member m, @RequestParam("post") String post,
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		m.setMAddress(post +"/"+ address1 +"/"+ address2);
		
		Member updateM = memberService.updateMypage(m);
		model.addAttribute("loginUser", updateM);

		return "member/mypageForm"; 
	}
	
	@GetMapping("/updatePwdForm")
	public String updatePwdForm() {	
		return "member/updatePwdForm"; 
	}
	
	@PostMapping("/updatePassword")
	public String updatePassword(String pwd, String newPwd, Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		String encPwd = bCryptPasswordEncoder.encode(newPwd);
		
		Member updateUser =  memberService.updatePassword(bCryptPasswordEncoder, loginUser, pwd, encPwd);

		model.addAttribute("loginUser", updateUser);
		model.addAttribute("msg", "비밀번호가 변경되었습니다");
		
		return "member/updatePwdForm";
	}
	
	@PostMapping("resetPwd")
	public String resetPwd(Member m, Model model) {
		
		String encPwd = bCryptPasswordEncoder.encode("0");
		m.setMPwd(encPwd);
		Member updateM = memberService.resetPwd(m);
		
		ArrayList<Job> jList = jobService.selectJobList(m.getCNo());
		ArrayList<Dept> dList = deptService.selectDeptList(m.getCNo());

		model.addAttribute("jList", jList);
		model.addAttribute("dList", dList);
		model.addAttribute("m", updateM);
		model.addAttribute("msg", "비밀번호가 초기화됐습니다");
		return "member/detailMemberForm"; 
	}
	
}
