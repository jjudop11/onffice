package com.uni.spring.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
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

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;


import lombok.Builder;

@SessionAttributes({"loginUser", "msg", "mNo"})
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
	
	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping("/")
	public String defalut() {	
		return "main";
	}
	
	@GetMapping("/main")
	public void main() {	
	}

	@GetMapping("/passwordForm")
	public String passwordForm(SessionStatus status) {
		status.setComplete();
		return "member/forgotPassword";
	}
	
	@PostMapping("/findPwd")
	public String findPwd(Member m, Model model) { 
		
		Member mem = memberService.findPwd(m);
		
		Random r = new Random();
		int num = r.nextInt(999999); // 랜덤난수설정
		
		String from = "jjudop11@naver.com";
		String to = mem.getMEmail(); // DB에서 가져온 Member객체의 이메일주소
		String title = "[ONFFICE] 비밀번호변경 인증 이메일 입니다"; 
		String content = "<img src=\"https://s3.us-west-2.amazonaws.com/secure.notion-static.com/eb5fa8b3-51d6-4643-88a7-363e92bf78be/logo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220526%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220526T024331Z&X-Amz-Expires=86400&X-Amz-Signature=a1903135bee523ddd3e526112cc83ded0a196da6867fffc15ad94adb24ce9585&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22logo.PNG.png%22&x-id=GetObject\">" 
				+"<br><br><br>" + "안녕하세요 "+ mem.getMName() +"님 " +"<br>"
				+ "비밀번호찾기(변경) 인증번호는 " + num + " 입니다.";
		
        try {
        	MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");  // true는 멀티파트 메세지를 사용 -> 파일첨부가능
			// MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
			
			mailHelper.setFrom(from);
			mailHelper.setTo(to); // to 값을 넣어야하지만 테스트 및 시연을 위해 개인 이메일 작성
		 	mailHelper.setSubject(title);
            mailHelper.setText(content, true); // true는 html을 사용
            // mailHelper.setText(content);
            mailSender.send(mail);
            
		} catch (Exception  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        model.addAttribute("num", num);
        model.addAttribute("mNo", mem.getMNo());
        
		return "member/checkEmailForm";

	}
	
	@GetMapping("/resetPwd2")
	public String resetPwd(String num, String checkNum, Model model, SessionStatus status) {
		
		String mNo = (String) model.getAttribute("mNo");
		String encPwd = bCryptPasswordEncoder.encode("0");
		
		Member m = Member.builder()
				.mNo(mNo)
				.mPwd(encPwd)
				.build();
		
		memberService.resetPwd(m);
		status.setComplete(); // 세션 mNo 초기화
		model.addAttribute("msg", "비밀번호가 0으로 초기화 되었습니다");
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
		
		Random r = new Random();
		int ran = r.nextInt(9999); // 랜덤난수설정
		
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
			Job job = Job.builder()
					.jName(ins)
					.cNo(loginUser.getCNo())
					.build();
			ArrayList<Job> jList = jobService.insertjd(job);
			model.addAttribute("lists", jList);
			model.addAttribute("set", "1");
			return "member/jdForm";
		} else {
			Dept dept = Dept.builder()
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
