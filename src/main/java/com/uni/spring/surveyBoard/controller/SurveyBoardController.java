package com.uni.spring.surveyBoard.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;
import com.uni.spring.surveyBoard.model.service.SurveyBoardService;


@Controller
//@RequiredArgsConstructor
@SessionAttributes({"loginUser", "msg"})
public class SurveyBoardController {
	
	@Autowired(required=false)
	private SurveyBoardService surveyBoardService;
	
	
	@RequestMapping(value="surveyBoardForm", method =  RequestMethod.GET)
	public String surveyBoardForm(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			
			return "member/login";
		}else {
		
			return "surveyBoard/surveyBoardList";
		}
	}
	
	@RequestMapping(value="createSurveyBoardForm")
	public String createSurveyBoardForm(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		System.out.println("loginUser === " + loginUser);
		
		if(loginUser == null) {
			
			return "member/login";
		}else {
			int cNo = loginUser.getCNo();
			
			ArrayList<Member> deptList = surveyBoardService.selectDeptList(cNo);
			System.out.println("deptList === " + deptList);
			if(deptList != null) {
				model.addAttribute("list" , deptList);

				return "surveyBoard/createSurveyBoard";
				
			}else {
				
				model.addAttribute("msg","설문게시판 작성 이동 실패");
				return "member/login";
			}
			
		
		}
	}
	
	
	@RequestMapping(value="regSurveyBoard")
	public String regSurveyBoard(Model model, SurveyBoard sb, int[] target, String[] questionContent) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			
			model.addAttribute("msg", "로그인후 이용해 주세요.");
			return "member/login";
		}else {
			
			long sbNo = new Date().getTime();
			String orderN = String.valueOf(sbNo).substring(5);
			sbNo = Long.parseLong(orderN);
			
			sb.setSbNo(sbNo);
			sb.setCNo(loginUser.getCNo());
			sb.setMNo(loginUser.getMNo());
			sb.setSbFounderNo(loginUser.getMNo());
			surveyBoardService.insertSurveyBoard(sb, target, questionContent);
			
			
			return "redirect:/surveyBoardForm";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="selectSBList", produces = "application/json; charset=utf-8")
	public Map<String, Object> selectSBList(@RequestParam(value="page" , required = false, defaultValue = "1") int page, Model model, int num) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		
			
		Map<String, Object> result = new HashMap<String, Object>();
		
		SurveyBoard sb = new SurveyBoard();
		sb.setCNo(loginUser.getCNo());
		sb.setMNo(loginUser.getMNo());
		sb.setDNo(loginUser.getDNo());
		
		// 홈 리스트
		if(num == 1) {
			
			int listCount = surveyBoardService.selectHomeListCount(sb);
			PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
			
			ArrayList<SurveyBoard> homeList = surveyBoardService.selectHomeList(pi, sb);
			
			result.put("list", homeList);
			result.put("page",  pi.getCurrentPage());
			result.put("startpage",  pi.getStartPage());
			result.put("endpage",  pi.getEndPage());
			result.put("maxpage",  pi.getMaxPage());
			
			return result;
			
		// 모든 리스트
		}else if(num == 2){
			
			int listCount = surveyBoardService.selectAllListCount(sb);
			PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
			
			ArrayList<SurveyBoard> AllList = surveyBoardService.selectAllList(pi, sb);
			
			result.put("list", AllList);
			result.put("page",  pi.getCurrentPage());
			result.put("startpage",  pi.getStartPage());
			result.put("endpage",  pi.getEndPage());
			result.put("maxpage",  pi.getMaxPage());
			
			return result;
		
		// 내가 작성한 리스트
		}else if(num == 3){
			
			int listCount = surveyBoardService.selectMyListCount(sb);
			PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
			
			ArrayList<SurveyBoard> MyList = surveyBoardService.selectMyList(pi, sb);
			
			result.put("list", MyList);
			result.put("page",  pi.getCurrentPage());
			result.put("startpage",  pi.getStartPage());
			result.put("endpage",  pi.getEndPage());
			result.put("maxpage",  pi.getMaxPage());
			
			return result;
			
		// 종료된 리스트
		}else{
			
			int listCount = surveyBoardService.selectEndListCount(sb);
			PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
			
			ArrayList<SurveyBoard> EndList = surveyBoardService.selectEndList(pi, sb);
			
			for(int i = 0; i < EndList.size(); i++) {
				
				System.out.println("EndList ==========> " + EndList.get(i));
			}
			
			
			
			result.put("list", EndList);
			result.put("page",  pi.getCurrentPage());
			result.put("startpage",  pi.getStartPage());
			result.put("endpage",  pi.getEndPage());
			result.put("maxpage",  pi.getMaxPage());
			
			return result;
		}

	}
	

	@RequestMapping("surveyBoardDetail")
	public String surveyBoardDetail(int sbNo, Model model, String sbAState) {
		
		
		System.out.println("sbNo ==== " + sbNo + " === sbAState === " + sbAState);
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			
			model.addAttribute("msg", "로그인후 이용해 주세요.");
			return "redirect:/";
		}else {
		
		SurveyBoard sb= new SurveyBoard();
		sb.setCNo(loginUser.getCNo());
		sb.setSbNo(sbNo);
		
		//ArrayList<Member> deptList = surveyBoardService.selectDeptList(loginUser.getCNo());
		ArrayList<SurveyBoard> list = surveyBoardService.selectBoardInfo(sb);
		ArrayList<SurveyBoard> qList = surveyBoardService.selectSBAnswerList(sbNo);
		System.out.println("list =========== " + list);
		
		int every = 0;
		
		if(list.get(0).getSbTDNo() == 0) {
			
			sb.setSbTDNo(0);
			System.out.println("list.get(0).getSbTDNo() -====================>  " + list.get(0).getSbTDNo());
			every = surveyBoardService.selectDeptAllCount(sb);
			
		}else {
		
			ArrayList<SurveyBoard> dlist = surveyBoardService.selectDeptNoList(sbNo);
			
			for(int i = 0; i < dlist.size(); i++) {
				
				sb.setSbTDNo(dlist.get(i).getSbTDNo());

				
				every += surveyBoardService.selectDeptCount(sb);

			}
		}
		
		int comMemCount = surveyBoardService.selectComMemCount(sbNo);
		
		model.addAttribute("comMemCount", comMemCount);
		model.addAttribute("memCount", every);
		model.addAttribute("sbList", list);
		model.addAttribute("sbAState", sbAState);
		model.addAttribute("qList", qList);

		
		
		
		return "surveyBoard/surveyBoardDetail";
		}
	}
	
	
	@RequestMapping(value="insertQuestionAnswer")
	public String insertQuestionAnswer(Model model, @RequestParam(value="sbNo" , required = false, defaultValue = "1") int sbNo, int[] sbQuestion,
										@RequestParam(value="sbINo" , required = false, defaultValue = "1") int sbINo) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		
		if(loginUser == null) {
			
			model.addAttribute("msg", "로그인후 이용해 주세요.");
			return "member/login";
		}else {
			String mNo = loginUser.getMNo();
			//int sbNo1 = Integer.parseInt(sbNo);
			System.out.println("sbNo =============== " + sbNo);
			surveyBoardService.insertAnswerInfo(sbNo, sbQuestion, sbINo, mNo);

			return "redirect:/surveyBoardForm";
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value="chartInfoList", produces = "application/json; charset=utf-8")
	public Map<String, Object> selectChartInfo(Model model, int sbNo) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
			SurveyBoard sb= new SurveyBoard();
			sb.setCNo(loginUser.getCNo());
			sb.setSbNo(sbNo);
			
			ArrayList<SurveyBoard> list = surveyBoardService.selectBoardInfo(sb);
			ArrayList<SurveyBoard> qList = surveyBoardService.selectSBAnswerList(sbNo);
			
			result.put("sbList", list);
			result.put("qList", qList);
			
			return result;
		}
	

	@GetMapping(value="deleteSurveyBoard")
	public String deleteSurveyBoard(Model model, int sbNo) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
			SurveyBoard sb= new SurveyBoard();
			sb.setCNo(loginUser.getCNo());
			sb.setSbNo(sbNo);
			

			System.out.println("sbNo ====== > " + sbNo);
			surveyBoardService.deleteSurveyBoard(sbNo);
			

			
			return "redirect:/surveyBoardForm";
		}
	
}
