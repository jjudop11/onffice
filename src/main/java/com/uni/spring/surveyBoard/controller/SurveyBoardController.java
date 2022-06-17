package com.uni.spring.surveyBoard.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
			int result = surveyBoardService.insertSurveyBoard(sb, target, questionContent);
			
			
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
		
		
		//if(num == 1) {
			int listCount = surveyBoardService.selectHomeListCount(sb);
		//}
		//if(listCount != null) {
			
		//}
		PageInfo pi = Pagination.getPageInfo(listCount, page, 10, 10);
			
			ArrayList<SurveyBoard> homeList = surveyBoardService.selectHomeList(pi, sb);
			
			result.put("list", homeList);
			result.put("page",  pi.getCurrentPage());
			result.put("startpage",  pi.getStartPage());
			result.put("endpage",  pi.getEndPage());
			result.put("maxpage",  pi.getMaxPage());
		return result;
	}
	
	
}
