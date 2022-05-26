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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;

import com.uni.spring.common.exception.CommException;
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
	
   @Autowired 
   private JobService jobService;
   
   @Autowired 
   private DeptService deptService;
	
	@GetMapping("main")
	public void main() {
		
	}

	@GetMapping("/passwordForm")
	public String passwordForm(SessionStatus status) {
		status.setComplete();
		return "member/forgotPassword";
	}
	
	@PostMapping("/findPwd")
	public String findPwd(Member m, Model model) { 
		
		System.out.println("찾기전=============:"+m);
		Member mem = memberService.findPwd(m);
		System.out.println("찾기후=============:"+mem);

		return "member/login";

	}
	
	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:/";
	}
	
	@PostMapping("/login")
	public ModelAndView loginUser(Member m, Model model, ModelAndView mv) { 

		Member loginUser = memberService.loginUser(bCryptPasswordEncoder, m);
		
		System.out.println("DB정보: "+loginUser);
		
		if(m.getMPwd().equals("0")) {
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

			if(changeName != null) {
				String resources = request.getSession().getServletContext().getRealPath("resources"); 
				String savePath = resources + "\\id_pictures\\";

				Photo p = Photo.builder()
						.pName(changeName)
						.pPath(savePath)
						.build();
				memberService.insertPhoto(p);
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
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, 
			HttpServletRequest request, @RequestParam(name = "file", required = false) MultipartFile file, Model model) {
		
		//Member loginUser = (Member)model.getAttribute("loginUser");
		if(m.getMEntDate().equals(2022-05-24)) {
			m.setMEntDate(null);
		}
		m.setMAddress(post +"/"+ address1 +"/"+ address2);
		
		String originalP = m.getPName(); // 기존파일이있을때 기존변경된파일명 변수에 초기화
	
		if(!file.isEmpty()) { // 새로넘어온 파일이 있는 경우 
			
			String changeName = saveFile(file, request);
			m.setPName(changeName); // 바꾼 파일 이름 저장
			
			Photo p = Photo.builder()
					.pNo(String.valueOf(m.getPNo())) // 원래 있던 사진번호
					.pName(changeName) // 바꿀 사진 이름
					.build();
			
			memberService.updatePhoto(p); // 사진 변경	
			deleteFile(originalP, request); // 기존 사진 삭제
		} 
		
		Member updateM = memberService.updateMember(m);
		
		ArrayList<Job> jList = jobService.selectJobList(m.getCNo());
		ArrayList<Dept> dList = deptService.selectDeptList(m.getCNo());
		
		model.addAttribute("jList", jList);
		model.addAttribute("dList", dList);
		model.addAttribute("m", updateM);
		
		Member loginUser = (Member) model.getAttribute("loginUser");
		if(loginUser.getMId().equals(updateM.getMId())) {
			model.addAttribute("loginUser", updateM);
		}
		
		return "member/detailMemberForm"; 
	}
	
	private void deleteFile(String fileName, HttpServletRequest request) {
		
		String resources = request.getSession().getServletContext().getRealPath("resources"); // 웹컨터이너에서의 resources 폴더까지의 경로

		String savePath = resources + "\\id_pictures\\";
		
		File deleteFile = new File(savePath + fileName);
		deleteFile.delete();
		
	}
	
	@PostMapping("/deleteMember")
	public String deleteMember(String mNo, Model model) {
		
		memberService.deleteMember(mNo);

		model.addAttribute("msg", "퇴사등록 완료");
		return "redirect:/managerpageForm"; 
	}
	
	@PostMapping("/updateMypage")
	public String updateMypage(Member m, @RequestParam("post") String post,
			@RequestParam("address1") String address1, @RequestParam("address2") String address2, 
			HttpServletRequest request, @RequestParam(name = "file", required = false) MultipartFile file, Model model) {
		
		m.setMAddress(post +"/"+ address1 +"/"+ address2);
		
		String originalP = m.getPName(); // 기존파일이있을때 기존변경된파일명 변수에 초기화
		
		if(!file.isEmpty()) { // 새로넘어온 파일이 있는 경우 
			
			String changeName = saveFile(file, request);
			m.setPName(changeName); // 바꾼 파일 이름 저장
			
			Photo p = Photo.builder()
					.pNo(String.valueOf(m.getPNo())) // 원래 있던 사진번호
					.pName(changeName) // 바꿀 사진 이름
					.build();
			
			memberService.updatePhoto(p); // 사진 변경	
			deleteFile(originalP, request); // 기존 사진 삭제
		} 
		
		Member updateM = memberService.updateMypage(m);
		model.addAttribute("loginUser", updateM);

		return "member/mypageForm"; 
	}
	
	@GetMapping("/updatePwdForm")
	public String updatePwdForm() {	
		return "member/updatePwdForm"; 
	}
	
	@GetMapping("/updateMPwdForm")
	public String updateMPwdForm() {	
		return "member/updateMPwdForm"; 
	}
	
	@PostMapping("/updatePassword")
	public ModelAndView updatePassword(String pwd, String newPwd, Model model, ModelAndView mv) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		String encPwd = bCryptPasswordEncoder.encode(newPwd);
		
		Member updateUser =  memberService.updatePassword(bCryptPasswordEncoder, loginUser, pwd, encPwd);
		
		if(loginUser.getMManager().equals("Y")) {
			mv.setViewName("member/updateMPwdForm");
		} else {
			mv.setViewName("member/updatePwdForm");
		}
		mv.addObject("loginUser", updateUser);
		mv.addObject("msg", "비밀번호가 변경되었습니다");
		
		return mv;
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
	
	@GetMapping("/jdForm")
	public String jdForm(Model model) {	
		
		Member loginUser = (Member) model.getAttribute("loginUser");
		ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
		model.addAttribute("lists", jList);
		model.addAttribute("set", "1");
		
		return "member/jdForm"; 
	}
	
	@GetMapping("/updatejdList")
	public String updatejdList(String val, Model model) {	
		
		Member loginUser = (Member) model.getAttribute("loginUser");
		if(val.equals("1")) {
			ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
			model.addAttribute("lists", jList);
			model.addAttribute("set", "1");
		} else {
			ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());
			model.addAttribute("lists", dList);
			model.addAttribute("set", "2");
		}
		
		return "member/jdForm"; 

	}
	
	@GetMapping("/deletejd")
	public String deletejd(String del, String val, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(val.equals("1")) {
			Job job = new Job().builder()
					.jName(del)
					.cNo(loginUser.getCNo())
					.build();
			ArrayList<Job> jList = jobService.deletejd(job);
			model.addAttribute("lists", jList);
			model.addAttribute("set", "1");
			return "member/jdForm";
		} else {
			Dept dept = new Dept().builder()
					.dName(del)
					.cNo(loginUser.getCNo())
					.build();
			ArrayList<Dept> dList = deptService.deletejd(dept);
			model.addAttribute("lists", dList);
			model.addAttribute("set", "2");
			return "member/jdForm";
		}

	}
	
	@GetMapping("/insertjd")
	public String insertjd(String ins, String val, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(val.equals("1")) {
			Job job = new Job().builder()
					.jName(ins)
					.cNo(loginUser.getCNo())
					.build();
			ArrayList<Job> jList = jobService.insertjd(job);
			model.addAttribute("lists", jList);
			model.addAttribute("set", "1");
			return "member/jdForm";
		} else {
			Dept dept = new Dept().builder()
					.dName(ins)
					.cNo(loginUser.getCNo())
					.build();
			ArrayList<Dept> dList = deptService.insertjd(dept);
			model.addAttribute("lists", dList);
			model.addAttribute("set", "2");
			return "member/jdForm";
		}

	}
	
}
