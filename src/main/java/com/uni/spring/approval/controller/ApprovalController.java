package com.uni.spring.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.approval.model.dto.ApList;
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
@SessionAttributes({"loginUser", "msg"})
public class ApprovalController {
	
	@Autowired
	public ApprovalService approvalService; // 서비스 연결
	
	// 기안작성 폼으로 이동
	@RequestMapping("approvalEnrollForm.do")
	public String EnrollForm() {
		return "approval/approvalEnrollForm";
	}
	
	// 기안작성 결재요청 
	@RequestMapping(value = "insertApproval.do", method = RequestMethod.POST)
	public String insertApproval(Approval ap, ApprovalLine apline, FormAtt att,
			@RequestParam(value="aplineNoList", required=false) List<String> aplineNoList,
			DayoffForm doForm, ProposalForm prForm, PaymentForm payForm, 
			HttpServletRequest request, // 뷰단에서 컨트롤러로 데이터 전달 
			@RequestParam(name = "upfile", required = false) MultipartFile file) { // 파일 선택 업로드
		
		System.out.println("CONTROLLER : " + ap);
		System.out.println("CONTROLLER : " + apline);
		System.out.println("CONTROLLER : " + doForm);
		System.out.println("CONTROLLER : " + aplineNoList);
//		System.out.println("CONTROLLER : " + Arrays.toString(apline.getAplineNoList()));
//		System.out.println("CONTROLLER : " + aplineNoList.size());
		
		approvalService.insertApproval(ap); // 전자결재문서 
		
		Map<String, Object> apprLineMap = new HashMap<>();
		apprLineMap.put("aplineNo", aplineNoList); // 배열 파라미터는 리스트에 담아서 맵에 담기 
		
		System.out.println("CONTROLLER : " + apprLineMap);
		
		approvalService.insertApprovalLine(apprLineMap); // 결재선 
		
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
	
	// 결재선 배열 받기 
//	@ResponseBody
//	@RequestMapping(value = "selectApprArr.do", method = RequestMethod.POST)
//	private List<String> selectApprArr(@RequestParam(value="apprArr[]", required=false) List<String> apprArr) { 
//		System.out.println("CONTROLLER : " + apprArr);
//		return apprArr; 
//	}
	 
	
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
		System.out.println("CONTROLLER memberMap : " + memberMap);
		
		// Map에 담은 정보와 일치하는 사원 리스트로 받기  
		ArrayList<Member> list = approvalService.selectMemberList(memberMap);
		System.out.println("CONTROLLER list : " + list);
		
		return new GsonBuilder().create().toJson(list);
		
	}
	
	// 결재진행 리스트 페이지로 이동
	@RequestMapping("approvalOngoingListView.do")
	public String approvalOngoingListView(@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, Model model) {
	
		Member m = (Member) model.getAttribute("loginUser");
		
		// 검색한 쿼리, 로그인 유저의 회사번호 Map 에 담기 
		Map<String, Object> listMap = new HashMap<>();
		listMap.put("mNo", m.getMNo());
		listMap.put("cNo", m.getCNo());
	
		int listCount = approvalService.selectListCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

		ArrayList<ApList> list = approvalService.selectList(pi, listMap);
		
		System.out.println("LIST : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalOngoingListView";
	
	}
	
	// 결재진행 디테일뷰 이동 
	@RequestMapping("approvalOngoingDetailView")
	public ModelAndView approvalOngoingDetailView(int apNo, int foNo, ModelAndView mv) {
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + foNo);
		
		// 결재여부 검사 
		int apStatus = approvalService.selecetApprovalStatus(apNo);
		System.out.println("CONTROLLER apStatus : " + apStatus);
		
		// 서식번호에 따라 다른 데이터 전달
		if(foNo == 10) {
			DayoffForm dayoffForm = approvalService.selectApprovalOngoingDo(apNo);
			mv.addObject("dayoffForm", dayoffForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 20) {
			ProposalForm prForm = approvalService.selectApprovalOngoingPr(apNo);
			mv.addObject("prForm", prForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 30) {
			PaymentForm payForm = approvalService.selectApprovalOngoingPay(apNo);
			mv.addObject("payForm", payForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		}
		
		// 첨부파일 
		FormAtt formAtt = approvalService.selectApprovalOngoingAtt(apNo);
		mv.addObject("formAtt", formAtt);
		
		// 결재선 
//		ApprovalLine apLine = approvalService.selectApprovalOngoingApLine(apNo);
//		System.out.println("CONTROLLER : " + apLine);
//		ArrayList<Member> apList = approvalService.selectApprovalOngoingApLine(apNo);
		Member apList = approvalService.selectApprovalOngoingApLine(apNo);
		mv.addObject("jName", apList.getJName());
		mv.addObject("mName", apList.getMName());
		System.out.println("CONTROLLER APLIST : " + apList);
		
		mv.setViewName("approval/approvalOngoingDetailView");
		
		return mv;
		
	}
	
	// 결재 수정 폼으로 이동 
	@RequestMapping("updateApprovalForm.do")
	public ModelAndView updateApprovalOngoing(int apNo, int foNo, String fileName, ModelAndView mv) {
		
		if(foNo == 10) {
			mv.addObject("dayoffForm", approvalService.selectApprovalOngoingDo(apNo));
			mv.addObject("formAtt", approvalService.selectApprovalOngoingAtt(apNo));
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
		} else if(foNo == 20) {
			mv.addObject("prForm", approvalService.selectApprovalOngoingPr(apNo));
			mv.addObject("formAtt", approvalService.selectApprovalOngoingAtt(apNo));
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
		} else if(foNo == 30) {
			mv.addObject("payForm", approvalService.selectApprovalOngoingPay(apNo));
			mv.addObject("formAtt", approvalService.selectApprovalOngoingAtt(apNo));
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
		}
		
		mv.setViewName("approval/approvalUpdateForm");
		
		return mv;
		
	}
	
	// 결재 수정 
	@RequestMapping(value = "updateApproval.do", method = RequestMethod.POST)
	public ModelAndView updateApproval(Approval ap, ApprovalLine apline, FormAtt att, int apNo, int foNo,
			DayoffForm doForm, ProposalForm prForm, PaymentForm payForm, 
			ModelAndView mv, HttpServletRequest request,
			@RequestParam(name = "reUploadFile", required = false) MultipartFile file) { // 파일 선택 업로드
		
		System.out.println("CONTROLLER : " + ap);
		System.out.println("CONTROLLER : " + apline);
		System.out.println("CONTROLLER : " + doForm);
		System.out.println("CONTROLLER : " + att);
		System.out.println("CONTROLLER : " + apNo);
		
//		approvalService.updateApproval(ap); // 전자결재문서 
//		approvalService.updateApprovalLine(apline); // 결재선
		
		// 서식폼 선택 
		if(ap.getFoNo() == 10) {
			doForm.setApNo(apNo);
			approvalService.updateDayoffForm(doForm); // 휴가신청서 
		} else if(ap.getFoNo() == 20) {
			prForm.setApNo(apNo);
			approvalService.updateProposalForm(prForm); // 사업기획서 
		} else if(ap.getFoNo() == 30) {
			payForm.setApNo(apNo);
			approvalService.updatePaymentForm(payForm); // 지출결의서 
		}
		
		// 파일 업로드
		String orgChangeName = att.getChangeName();
		
		if(!file.getOriginalFilename().equals("")) { // 새로 넘어온 파일이 있는 경우
			String changeName = saveFile(file, request); // 글 등록, 수정할 때 파일 공통적으로 처리할 saveFile 메소드 생성 
			
			att.setOriginName(file.getOriginalFilename());
			att.setChangeName(changeName);
		}
		
		approvalService.updateFormAtt(att);
		
		if(orgChangeName != null) { // 새로 넘어온 파일이 있는데 기존의 파일이 있는 경우 --> 서버에 업로드 된 기존 파일 삭제 
			deleteFile(orgChangeName, request);
		}
		
		mv.addObject("foNo", foNo);
		mv.addObject("apNo", apNo).setViewName("redirect:approvalOngoingDetailView.do");
		
		return mv; 
		
	}
	
	// 결재 삭제 
	@RequestMapping("deleteApproval.do")
	public String deleteApproval(int apNo, String fileName, HttpServletRequest request) {
		
		System.out.println("CONTROLLER : " + apNo);
		
		approvalService.deleteApproval(apNo);
		
		if(!fileName.equals("")) { // 파일이 빈 문자열이 아니라면 
			deleteFile(fileName, request); // 업데이트할때 같이 쓸 딜리트파일 생성 
		}
		
		return "redirect:approvalOngoingListView.do";
		
	}
	
	// 파일 삭제 
	private void deleteFile(String fileName, HttpServletRequest request) {
		
		String resources = request.getSession().getServletContext().getRealPath("resources"); // 웹컨테이너에서 resource 폴더까지의 경로 (C:\FWORK\spring\SpringP\src\main\webapp\resources)
		
		String savePath = resources + "\\upload_files\\";
		
		File deleteFile = new File(savePath + fileName);
		deleteFile.delete();
		
	}
	
	// 결재요청 리스트로 이동 
	@RequestMapping("approvalRequestListView.do")
	public String approvalRequestListViewapprovalOngoingListView(@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, Model model) {
	
		Member m = (Member) model.getAttribute("loginUser");
		
		Map<String, Object> listMap = new HashMap<>();
		listMap.put("mNo", m.getMNo());
		listMap.put("cNo", m.getCNo());
	
		int listCount = approvalService.selectRequestListCount(m.getMNo());
		System.out.println("CONTROLLER : " + listCount);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

		ArrayList<ApList> list = approvalService.selectRequestList(pi, listMap);
		
		System.out.println("LIST : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalRequestListView";
	
	}
	
	// 결재요청 디테일뷰로 이동 
	@RequestMapping("approvalRequestDetailView")
	public ModelAndView approvalRequestDetailView(int apNo, int foNo, ModelAndView mv) {
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + foNo);
		
		// 서식번호에 따라 다른 데이터 전달
		if(foNo == 10) {
			DayoffForm dayoffForm = approvalService.selectApprovalOngoingDo(apNo);
			mv.addObject("dayoffForm", dayoffForm);
		} else if(foNo == 20) {
			ProposalForm prForm = approvalService.selectApprovalOngoingPr(apNo);
			mv.addObject("prForm", prForm);
		} else if(foNo == 30) {
			PaymentForm payForm = approvalService.selectApprovalOngoingPay(apNo);
			mv.addObject("payForm", payForm);
		}
		
		//
		mv.addObject("foNo", foNo);
		mv.addObject("apNo", apNo);
		
		// 작성자 정보 
		Member writer = approvalService.selectApprovalWriter(apNo);
		mv.addObject("writer", writer);
		System.out.println(writer);
		
		// 첨부파일 
		FormAtt formAtt = approvalService.selectApprovalOngoingAtt(apNo);
		mv.addObject("formAtt", formAtt);
		
		// 결재선 
		Member apList = approvalService.selectApprovalOngoingApLine(apNo);
		mv.addObject("jName", apList.getJName());
		mv.addObject("mName", apList.getMName());
		System.out.println(apList.getJName());
		System.out.println(apList.getMName());
		
		mv.setViewName("approval/approvalRequestDetailView");
		
		return mv;
		
	}
	
	// 결재상태 확인 
	@ResponseBody
	@RequestMapping(value="selectApLineStatus.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String selectApLineStatus(@RequestParam(value="apNo", required=false) int apNo,
//			@RequestParam(value="aplineNo", required=false) String aplineNo,
			@RequestParam(value="mName", required=false) String mName) {
		
		// Map 에 담아서 넘기기 
		Map<String, Object> apprMap = new HashMap<>();
		apprMap.put("apNo", apNo);
		apprMap.put("mName", mName);
//		apprMap.put("aplineNo", aplineNo);
		
		System.out.println("CONTROLLER : " + mName);
		
//		String apLineStatus = approvalService.selecetApLineStatus(apprMap);
		Member apLine = approvalService.selecetApLineStatus(apprMap);
		
		System.out.println("CONTROLLER : " + apLine.getAplineStatus());
		
		return new GsonBuilder().create().toJson(apLine.getAplineStatus());
	}
	
	// 결재 승인
	@ResponseBody
	@RequestMapping(value="updateApprPermit.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String updateApprPermit(@RequestParam(value="apNo", required=false) int apNo,
			@RequestParam(value="aplineNo", required=false) int aplineNo) {
		
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + aplineNo);
		
		// Map 에 담아서 넘기기 
		Map<String, Object> apprMap = new HashMap<>();
		apprMap.put("apNo", apNo);
		apprMap.put("aplineNo", aplineNo);
		
		approvalService.updateApprPermit(apprMap);
		
		// 최종 결재 상태 변경
		approvalService.updateApStatus(apNo);
		
		return null;
	}
	
	// 결재 반려 
	@ResponseBody
	@RequestMapping(value="updateApprRefuse.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String updateApprRefuse(@RequestParam(value="apNo", required=false) int apNo,
			@RequestParam(value="aplineNo", required=false) int aplineNo) {
		
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + aplineNo);
		
		// Map 에 담아서 넘기기 
		Map<String, Object> apprMap = new HashMap<>();
		apprMap.put("apNo", apNo);
		apprMap.put("aplineNo", aplineNo);
		
		// 
		approvalService.updateApprRefuse(apprMap);
		
		// 최종 결재 상태 변경
		approvalService.updateApStatus(apNo);
		
		return null;
	}
	
	// 최종결재상태 
//	@ResponseBody
//	@RequestMapping(value="updateApStatus.do", method=RequestMethod.POST, produces = "application/text; charset=utf8")
//	public void updateApStatus(@RequestParam(value="apNo", required=false) int apNo) {
//		approvalService.updateApStatus(apNo);
//	}
	
	// 결재 완료 리스트 이동 
	@RequestMapping("approvalCompleteListView.do")
	public String approvalCompleteListView(@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, Model model) {
	
		Member m = (Member) model.getAttribute("loginUser");

		Map<String, Object> listMap = new HashMap<>();
		listMap.put("mNo", m.getMNo());
		listMap.put("cNo", m.getCNo());
	
		int listCount = approvalService.selectCompleteListCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

		ArrayList<ApList> list = approvalService.selectCompleteList(pi, listMap);
		
		System.out.println("LIST : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalCompleteListView";
	
	}
	
	// 결재완료 디테일뷰 이동 
	@RequestMapping("approvalCompleteDetailView.do")
	public ModelAndView approvalCompleteDetailView(int apNo, int foNo, ModelAndView mv) {
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + foNo);
		
		// 결재여부 검사 
		int apStatus = approvalService.selecetApprovalStatus(apNo);
		System.out.println("CONTROLLER apStatus : " + apStatus);
		
		// 서식번호에 따라 다른 데이터 전달
		if(foNo == 10) {
			DayoffForm dayoffForm = approvalService.selectApprovalOngoingDo(apNo);
			mv.addObject("dayoffForm", dayoffForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 20) {
			ProposalForm prForm = approvalService.selectApprovalOngoingPr(apNo);
			mv.addObject("prForm", prForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 30) {
			PaymentForm payForm = approvalService.selectApprovalOngoingPay(apNo);
			mv.addObject("payForm", payForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		}
		
		// 첨부파일 
		FormAtt formAtt = approvalService.selectApprovalOngoingAtt(apNo);
		mv.addObject("formAtt", formAtt);
		
		// 결재선 
//			ApprovalLine apLine = approvalService.selectApprovalOngoingApLine(apNo);
//			System.out.println("CONTROLLER : " + apLine);
//			ArrayList<Member> apList = approvalService.selectApprovalOngoingApLine(apNo);
		Member apList = approvalService.selectApprovalOngoingApLine(apNo);
		mv.addObject("jName", apList.getJName());
		mv.addObject("mName", apList.getMName());
		System.out.println("CONTROLLER APLIST : " + apList);
		
		mv.setViewName("approval/approvalCompleteDetailView");
		
		return mv;
		
	}
	
	// 결재내역 리스트 이동 
	@RequestMapping("approvalAllowListView.do")
	public String approvalAllowListView(@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage, Model model) {
	
		Member m = (Member) model.getAttribute("loginUser");

		Map<String, Object> listMap = new HashMap<>();
		listMap.put("aplineNo", m.getMNo());
		listMap.put("cNo", m.getCNo());
	
		int listCount = approvalService.selectAllowListCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);

		ArrayList<ApList> list = approvalService.selectAllowList(pi, listMap);
		
		System.out.println("LIST : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		
		return "approval/approvalAllowListView";
	
	}
	
	// 결재내역 디테일뷰 이동 
	@RequestMapping("approvalAllowDetailView.do")
	public ModelAndView approvalAllowDetailView(int apNo, int foNo, ModelAndView mv) {
		System.out.println("CONTROLLER : " + apNo);
		System.out.println("CONTROLLER : " + foNo);
		
		// 결재여부 검사 
		int apStatus = approvalService.selecetApprovalStatus(apNo);
		System.out.println("CONTROLLER apStatus : " + apStatus);
		
		// 서식번호에 따라 다른 데이터 전달
		if(foNo == 10) {
			DayoffForm dayoffForm = approvalService.selectApprovalOngoingDo(apNo);
			mv.addObject("dayoffForm", dayoffForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 20) {
			ProposalForm prForm = approvalService.selectApprovalOngoingPr(apNo);
			mv.addObject("prForm", prForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		} else if(foNo == 30) {
			PaymentForm payForm = approvalService.selectApprovalOngoingPay(apNo);
			mv.addObject("payForm", payForm);
			mv.addObject("foNo", foNo);
			mv.addObject("apNo", apNo);
			mv.addObject("apStatus", apStatus);
		}
		
		// 첨부파일 
		FormAtt formAtt = approvalService.selectApprovalOngoingAtt(apNo);
		mv.addObject("formAtt", formAtt);
		
		// 결재선 
//				ApprovalLine apLine = approvalService.selectApprovalOngoingApLine(apNo);
//				System.out.println("CONTROLLER : " + apLine);
//				ArrayList<Member> apList = approvalService.selectApprovalOngoingApLine(apNo);
		Member apList = approvalService.selectApprovalOngoingApLine(apNo);
		mv.addObject("jName", apList.getJName());
		mv.addObject("mName", apList.getMName());
		System.out.println("CONTROLLER APLIST : " + apList);
		
		mv.setViewName("approval/approvalAllowDetailView");
		
		return mv;
		
	}
	
}
