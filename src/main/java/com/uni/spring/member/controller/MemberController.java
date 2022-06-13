package com.uni.spring.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.dept.model.service.DeptService;
import com.uni.spring.job.model.dto.Job;
import com.uni.spring.job.model.service.JobService;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.meetingRoom.model.service.MeetingRoomService;
import com.uni.spring.member.model.dto.Alram;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.dto.Photo;
import com.uni.spring.member.model.dto.RememberLogin;
import com.uni.spring.member.model.service.MemberService;
import com.uni.spring.notice.model.notice;
import com.uni.spring.notice.service.noticeService;

import javax.mail.internet.MimeMessage;
import org.springframework.mail.javamail.MimeMessageHelper;


import lombok.Builder;
import oracle.net.aso.k;

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
	private noticeService noticeService;
	
	@Autowired
	private MeetingRoomService meetingRoomService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping("/alarm")
	public String alarm() {
		return "common/alarm";
	}
	
	@GetMapping("/")
	public String defalut() {	
		return "main";
	}
	
	@GetMapping("/loginpage")
	public String loginform() {	
		return "member/login";
	}
	
	@GetMapping("/main")
	public void main(Model model, @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {	
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		ArrayList<notice> list = noticeService.selectNoticeList(loginUser.getCNo());
		
		int userCNo = loginUser.getCNo(); 
		// 페이징 처리
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectRoomList(pi, userCNo);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("roomList", roomList);
		
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
		String content = "<img src=\"https://s3.us-west-2.amazonaws.com/secure.notion-static.com/eb5fa8b3-51d6-4643-88a7-363e92bf78be/logo.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220613%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220613T033346Z&X-Amz-Expires=86400&X-Amz-Signature=30a4cf56c3bb0e4ccbc926622c49d0cf99804351094b2b6e282e7618c3dffc53&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22logo.PNG.png%22&x-id=GetObject\">" 
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
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		if ( loginCookie != null ){
            // null이 아니면 존재하면!
            loginCookie.setPath("/");
            // 쿠키는 없앨 때 유효시간을 0으로 설정하는 것 !!! invalidate같은거 없음.
            loginCookie.setMaxAge(0);
            // 쿠키 설정을 적용한다.
            response.addCookie(loginCookie);
             
            // 사용자 테이블에서도 유효기간을 현재시간으로 다시 세팅해줘야함.
            memberService.deleteRemember(loginUser);
        }
		session.invalidate();
		return "redirect:/";
	}
	
	@PostMapping("/login")

	public ModelAndView loginUser(HttpSession session, HttpServletResponse response, Member m, String remember, @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage, Model model, ModelAndView mv) { 

		Member loginUser;

		if(session.getAttribute("loginUser") != null) {
			session.removeAttribute("loginUser"); // 기존값을 제거해 준다.
		}
		
		loginUser = memberService.loginUser(bCryptPasswordEncoder, m);

		int userCNo = loginUser.getCNo(); 
		// 페이징 처리
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectRoomList(pi, userCNo);
		
		System.out.println("DB정보: "+loginUser);
		
		
		if(m.getMPwd().equals("0")) {
			mv.addObject("loginUser", loginUser).addObject("msg","첫로그인 입니다. 비밀번호를 변경하세요").setViewName("member/updatePwdForm");
		} else if (loginUser.getMPwd().equals("99")) {
			mv.addObject("msg", "비밀번호를 틀렸습니다. 5번틀리면 계정이 잠깁니다").setViewName("redirect:/");
		} else {
			if(remember != null) {
				Cookie cookie = new Cookie("loginCookie", session.getId());
				cookie.setPath("/");
				int amount = 60*60*24;
				cookie.setMaxAge(amount); // 하루 유지
				response.addCookie(cookie);
				
				Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
				RememberLogin r = RememberLogin.builder()
						.mNo(loginUser.getMNo())
						.sessionkey(session.getId())
						.sessionLimit(sessionLimit)
						.build();
				memberService.insertRemember(r);
			} 
			ArrayList<notice> list = noticeService.selectNoticeList(loginUser.getCNo());
			mv.addObject("loginUser", loginUser).addObject("list", list).addObject("pi", pi).addObject("roomList", roomList).setViewName("main");
		}

		return mv;

	}
	
	@GetMapping("mypageForm")
	public String mypageForm() {	
		return "member/mypageForm"; 
	}
	
	@GetMapping("/managerpageForm")
	public String managerpageForm() {
		return "member/managerpageForm"; 
	}

	@ResponseBody
	@PostMapping(value ="/selectMemList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectMemList(@RequestParam(value="page" , required = false, defaultValue = "1") int page, Model model) {	
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		int listCount = memberService.selectMemListCount(loginUser.getCNo());
		
		PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
		
		ArrayList<Member> list = memberService.selectMemList(pi, loginUser.getCNo());
		
		result.put("list", list);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());

		return result;
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
		return "member/jdForm"; 
	}
	
	@ResponseBody
	@PostMapping(value ="/deletejd",produces = "application/json; charset=utf-8")
	public String deletejd(String del, String set, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(set.equals("1")) {
			Job job = new Job().builder()
					.jName(del)
					.cNo(loginUser.getCNo())
					.build();
			int result = jobService.deletejd(job);
			return String.valueOf(result);
		} else {
			Dept dept = new Dept().builder()
					.dName(del)
					.cNo(loginUser.getCNo())
					.build();
			int result = deptService.deletejd(dept);
			return String.valueOf(result);
		}

	}
	
	@ResponseBody
	@PostMapping(value ="/updatejd",produces = "application/json; charset=utf-8")
	public String updatejd(String upd, String set, String ori, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(set.equals("1")) {
			
			ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
			for (Job j : jList) {
				if(j.getJName().equals(upd)) {
					return String.valueOf("중복");
				}
			}
			Job job = new Job().builder()
					.jName(upd)
					.oriName(ori)
					.cNo(loginUser.getCNo())
					.build();
			int result = jobService.updatejd(job);
			return String.valueOf(result);
		} else {
			
			ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());
			for (Dept d : dList) {
				if(d.getDName().equals(upd)) {
					return String.valueOf("중복");
				}
			}
			Dept dept = new Dept().builder()
					.dName(upd)
					.oriName(ori)
					.cNo(loginUser.getCNo())
					.build();
			int result = deptService.updatejd(dept);
			return String.valueOf(result);
		}

	}
	
	@ResponseBody
	@PostMapping(value ="/insertjd",produces = "application/json; charset=utf-8")
	public String insertjd(String ins, String set, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(set.equals("1")) {
			
			ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
			for (Job j : jList) {
				if(j.getJName().equals(ins)) {
					return String.valueOf("중복");
				}
			}
			Job job = Job.builder()
					.jName(ins)
					.cNo(loginUser.getCNo())
					.build();
			int result = jobService.insertjd(job);
			return String.valueOf(result);
			
		} else {
			
			ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());
			for (Dept d : dList) {
				if(d.getDName().equals(ins)) {
					return String.valueOf("중복");
				}
			}
			Dept dept = Dept.builder()
					.dName(ins)
					.cNo(loginUser.getCNo())
					.build();
			int result = deptService.insertjd(dept);
			return String.valueOf(result);
		}

	}
	
	@ResponseBody
	@PostMapping(value ="/selectJdList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectJdList(@RequestParam(value = "set", defaultValue = "1", required = false) int set, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member) model.getAttribute("loginUser");
		if(set == 1) {
			ArrayList<Job> jList = jobService.selectJobList(loginUser.getCNo());
			result.put("list",  jList);
			result.put("set",  1);
		} else {
			ArrayList<Dept> dList = deptService.selectDeptList(loginUser.getCNo());
			result.put("list",  dList);
			result.put("set",  2);
		}
		
		return result;
		
	}
	
	@ResponseBody
	@PostMapping(value ="/selectSerach",produces = "application/json; charset=utf-8")
	public String selectSerach(String condition, Model model) {	

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		if(condition.equals("job")) {
			ArrayList<Job> list = jobService.selectJobList(loginUser.getCNo());
			return new GsonBuilder().create().toJson(list);
		} else {
			ArrayList<Dept> list = deptService.selectDeptList(loginUser.getCNo());
			return new GsonBuilder().create().toJson(list);
		}
	}
	
	@GetMapping("/searchMemListForm")
	public String searchMemListForm(@RequestParam(value="page" , required = false, defaultValue = "1") int page, String condition, String search, Model model) {	
		System.out.println(condition);
		System.out.println(search);

		model.addAttribute("condition", condition);
		model.addAttribute("search", search);
		
		return "member/searchMemListForm";
	}
	
	@ResponseBody
	@GetMapping(value ="/searchMemList",produces = "application/json; charset=utf-8")
	public Map<String, Object> searchMemList(@RequestParam(value="page" , required = false, defaultValue = "1") int page, String condition, String search, Model model) {	
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		Member m = null;
		int listCount = 0;
		if(condition.equals("no")) {
			m = Member.builder()
					.mNo(search)
					.cNo(loginUser.getCNo())
					.build();
			listCount = memberService.searchMemListCount(m);
		} else if (condition.equals("name")) {
			m = Member.builder()
					.mName(search)
					.cNo(loginUser.getCNo())
					.build();
			listCount = memberService.searchMemListCount(m);
		} else if (condition.equals("job")) {
			m = Member.builder()
					.jName(search)
					.cNo(loginUser.getCNo())
					.build();
			listCount = memberService.searchMemListCount(m);
		} else {
			m = Member.builder()
					.dName(search)
					.cNo(loginUser.getCNo())
					.build();
			listCount = memberService.searchMemListCount(m);
		}
 		
		PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
		
		ArrayList<Member> list = memberService.searchMemList(pi, m);
		
		result.put("list", list);
		result.put("c", condition);
		result.put("s", search);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());

		return result;
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAlramList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectAlramList(Model model) {	
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		ArrayList<Alram> list = memberService.selectAlramList(loginUser.getMNo());
		
		result.put("list", list);
		result.put("count", list.size());

		return result;
	}
	
	@ResponseBody
	@PostMapping(value ="/deleteAlram",produces = "application/json; charset=utf-8")
	public String deleteAlram(Model model, String content) {	
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		String conString = "";
		
		int index = content.indexOf("이");
		if(index > -1) {
			conString = content.substring(0,index+1) + "<br>" + content.substring(index+1);
		} 
		
		Alram a = Alram.builder()
				.mNo(loginUser.getMNo())
				.alContent(conString)
				.build();
		int result = memberService.deleteAlram(a);
		
		return String.valueOf(result);
	}

}
