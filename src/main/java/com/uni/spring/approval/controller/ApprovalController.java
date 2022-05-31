package com.uni.spring.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.GsonBuilder;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;
import com.uni.spring.approval.model.service.ApprovalService;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.exception.CommException;
import com.uni.spring.member.model.dto.Member;

@Controller
public class ApprovalController {
	
	@Autowired
	public ApprovalService approvalService; // 서비스 연결
	
	// 기안작성 폼으로 이동
	@RequestMapping("enrollFormApproval.do")
	public String enrollForm() {
		return "approval/approvalEnrollForm";
	}
	
	// 기안작성 결재요청 
	@RequestMapping(value = "insertApproval.do", method = RequestMethod.POST)
	public String insertApproval(Approval ap, ApprovalLine apline, FormAtt att,
			DayoffForm doForm, ProposalForm prForm, PaymentForm payForm, 
			@RequestParam(name = "doType") int doType,
			HttpServletRequest request, // 뷰단에서 컨트롤러로 데이터 전달 
			@RequestParam(name = "upfile", required = false) MultipartFile file) { // 파일 선택 업로드
		
		System.out.println("CONTROLLER : " + ap);
		System.out.println("CONTROLLER : " + apline);
		System.out.println("CONTROLLER : " + doForm);
		
//		System.out.println("CONTROLLER : " + doForm.getDoStartDate());
//		System.out.println("CONTROLLER : " + doForm.getDoStartDate().getClass().getName());
		
		approvalService.insertApproval(ap); // 전자결재문서 
		approvalService.insertApprovalLine(apline); // 결재선
		
		// 서식폼 선택 
		if(ap.getFoNo() == 10) {
			approvalService.insertDayoffForm(doForm); // 휴가신청서 
		} else if(ap.getFoNo() == 20) {
			approvalService.insertProposalForm(prForm); // 사업기획서 
		} else if(ap.getFoNo() == 30) {
			approvalService.insertPaymentForm(payForm); // 지출결의서 
		}
		
		// 업로드된 파일이 있을 때 
		if(!file.getOriginalFilename().equals("")) {
			String changeName = saveFile(file, request); // 글 등록, 수정할 때 파일 공통적으로 처리할 saveFile 메소드 생성 
			
			if(changeName != null) {
				att.setOriginName(file.getOriginalFilename());
				att.setChangeName(changeName);
				att.setFilePath((request.getSession().getServletContext().getRealPath("resources")) + "\\upload_files\\");
			
				System.out.println("CONTROLLER : " + att);
				
				approvalService.insertFormAtt(att);
			}
		}
		
		return "redirect:/main"; 
		
	}
	
	// 전달받은 파일을 업로드한 후 수정된 파일명을 리턴
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		
		// 파일 저장 경로 
		String resources = request.getSession().getServletContext().getRealPath("resources"); // 물리 경로 (웹컨테이너 ~ resources 폴더까지 경로
		String savePath = resources + "\\upload_files\\"; // 업로드이미지 저장 경로 
		
		// 파일명 변경 
		String originName = file.getOriginalFilename(); // 오리지널파일명
		
		String currentTime = new SimpleDateFormat("yyyymmddHHmmss").format(new Date()); // 년월일시분초 
		String ext = originName.substring(originName.lastIndexOf(".")); // 확장자 뺀 파일명 
		String changeName = currentTime + ext;
		
		try {
			
			// 변경된 파일명으로 저장 
			file.transferTo(new File(savePath + changeName)); 
			
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			throw new CommException("file upload error");
		} 
		
		return changeName;
	}
	
	// 결재선 검색 
	@ResponseBody
    @RequestMapping(value="searchApprovalLine.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
    public String searchMember(@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, Model model,
    		@RequestParam(value="searchName", required=false) String searchName,
    		@RequestParam(value="cNo", required=false) int cNo) {
		
		System.out.println("CONTROLLER : " + searchName);
		System.out.println("CONTROLLER : " + cNo);
		
		// 검색한 쿼리, 로그인 유저의 회사번호 Map 에 담기 
		Map<String, Object> memberMap = new HashMap<>();
		memberMap.put("searchName", searchName);
		memberMap.put("cNo", cNo);
		
		// Map에 담은 정보와 일치하는 사원 리스트로 받기  
		ArrayList<Member> list = approvalService.selectMemberList(memberMap);
		System.out.println("CONTROLLER : " + list);
		
		return new GsonBuilder().create().toJson(list);
		
	}

}
