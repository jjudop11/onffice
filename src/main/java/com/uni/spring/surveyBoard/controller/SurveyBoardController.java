package com.uni.spring.surveyBoard.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.uni.spring.member.model.dto.Member;
import com.uni.spring.orgChart.model.service.OrgChartService;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;
import com.uni.spring.surveyBoard.model.service.SurveyBoardService;


@Controller
//@RequiredArgsConstructor
@SessionAttributes({"loginUser", "msg"})
public class SurveyBoardController {
	
	@Autowired(required=false)
	private SurveyBoardService surveyBoardService;
	
	@Autowired(required=false)
	private OrgChartService orgChartService;
	
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
			
			ArrayList<String> deptList = orgChartService.selectDeptList(cNo);
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
	public String regSurveyBoard(Model model, SurveyBoard sb, String[] target, String[] questionContent) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		System.out.println("surveyBoard ===  " + sb);
		
		if(loginUser == null) {
			
			model.addAttribute("msg", "로그인후 이용해 주세요.");
			return "member/login";
		}else {
			
			sb.setCNo(loginUser.getCNo());
			sb.setSbFounderNo(loginUser.getMNo());
			int result = surveyBoardService.insertSurveyBoard(sb, target, questionContent);
			
			
			return "redirect:/surveyBoardForm";
		}
	}
	
	
	
}
