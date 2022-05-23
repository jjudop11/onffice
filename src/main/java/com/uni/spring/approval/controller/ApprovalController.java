package com.uni.spring.approval.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.uni.spring.approval.model.service.ApprovalService;

@Controller
public class ApprovalController {
	
	@Autowired
	public ApprovalService approvalService; // 서비스 연결
	
	// 기안작성 폼으로 이동
	@RequestMapping("enrollFormApproval.do")
	public String enrollForm() {
		return "approval/approvalEnrollForm";
	}
	
	// 기안작성 인서트 
	@RequestMapping("insertApproval.do")
	public String insertApproval() {
		return "redirect:/"; 
	}
	
//	@RequestMapping("insertBoard.do")
//	public String insertBoard(Board b, 
//			HttpServletRequest request, // 파일 업로드를 받아야 하기 때문에 리퀘스트로 받아준다
//			@RequestParam(name="uploadFile", required = false) MultipartFile file) { // 파일이 있을 수도, 없을 수도 있으므로 required = false 로 받아줌
//		
//		// 업로드할 파일 루트컨텍스트에서 빈 등록, 폼.xml 에 라이브러리 추가 
//		
//		if(!file.getOriginalFilename().equals("")) { // 전달받은 파일이 없으면 빈 문자열이 넘어온다
//			String changeName = saveFile(file, request); // 글 등록, 수정할때 파일 공통적으로 처리할 saveFile 메소드 생성 (리퀘스트는 saveFile 경로때문에 쓰는거)
//		
//			if(changeName != null) {
//				b.setOriginName(file.getOriginalFilename());
//				b.setChangeName(changeName);
//			}
//		}
//		
//		boardService.insertBoard(b);
//		
//		return "redirect:listBoard.do";
//	}

}
