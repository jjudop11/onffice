package com.uni.spring.surveyBoard.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.uni.spring.member.model.dto.Member;
import com.uni.spring.surveyBoard.model.service.SurveyBoardService;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
@SessionAttributes({"loginUser", "msg"})
public class SurveyBoardController {
	

	public SurveyBoardService surveyBoardService;
	
	
	
	@RequestMapping(value="surveyBoardForm", method =  RequestMethod.GET)
	public String surveyBoardForm(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			
			return "member/login";
		}else {
		
			return "surveyBoard/surveyBoardList";
		}
	}
	
	@RequestMapping(value="createSurveyBoardForm", method =  RequestMethod.GET)
	public String createSurveyBoardForm(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			
			return "member/login";
		}else {
		
			return "surveyBoard/createSurveyBoard";
		}
	}
	
	
	
}
