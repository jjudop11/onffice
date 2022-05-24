package com.uni.spring.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.formAtt;
import com.uni.spring.approval.model.service.ApprovalService;
import com.uni.spring.common.exception.CommException;

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
	@RequestMapping("insertApproval.do")
	public String insertApproval(Approval ap, // 결재문서기본정보 
			formAtt att,
			HttpServletRequest request, // 뷰단에서 컨트롤러로 데이터 전달 
			@RequestParam(name = "upfile", required = false) MultipartFile file) { // 파일 선택 업로드
		
		System.out.println("ap : " + ap);
		
		// 업로드된 파일이 있을 때 
		if(!file.getOriginalFilename().equals("")) {
			String changeName = saveFile(file, request); // 글 등록, 수정할 때 파일 공통적으로 처리할 saveFile 메소드 생성 
			
			if(changeName != null) {
				att.setOriginName(file.getOriginalFilename());
				att.setChangeName(changeName);
			}
		}
		
		return "redirect:/"; 
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

}
