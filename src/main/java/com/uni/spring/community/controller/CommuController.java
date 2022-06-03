package com.uni.spring.community.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.Reply;
import com.uni.spring.community.service.CommuService;
import com.uni.spring.member.model.dto.Member;

@Controller
public class CommuController {
	
	@Autowired
	public CommuService commuService;
	
	@RequestMapping("listCommunity.do")
	public String selectList(@RequestParam(value="currentPage" , required = false, defaultValue = "1") int currentPage, Model model) {

		int listCount = commuService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		ArrayList<Community> list = commuService.selectList(pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi", pi);

		return "community/CommunityListView";
	}
	
	@RequestMapping("enrollFormCommunity.do")
	public String enrollForm() {
		return "community/CommunityEnrollForm";
	}
	
	@RequestMapping("insertCommu.do")
	public String insertBoard(Community c, HttpServletRequest request) {

		commuService.insertCommu(c);
		
		return "redirect:listCommunity.do";
	}
	
	@RequestMapping("detailCommunity.do")
	public String selectCommu(@RequestParam(value= "Com_Num") int cn, Model model) {
		Community c = commuService.selectCommu(cn);
		
		model.addAttribute("c", c);

		return "community/CommunityDetailView"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "rListCommunity.do", produces = "application/json; charset=UTF-8")
	public String selectReplyList(int cn) {
		ArrayList<Reply> list = commuService.selectReplyList(cn);

		return new GsonBuilder().setDateFormat("MM-dd HH:mm").create().toJson(list);
	}
	
	@ResponseBody
	@RequestMapping(value = "rinsertCommunity.do")
	public String insertReply(Reply r) {
		int result = commuService.insertReply(r);
		return String.valueOf(result);
	}
	
	@RequestMapping("deleteCommu.do")
	public String deleteNotice(int ComNum, HttpServletRequest request) {
		
		commuService.deleteCommu(ComNum);
		
		return "redirect:listCommunity.do";
	}

	@RequestMapping("updateFormCommu.do")
	public ModelAndView updateForm(@RequestParam(value= "ComNum") int cn, ModelAndView mv) {
		mv.addObject("c", commuService.selectCommu(cn)).setViewName("community/CommunityUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("updateCommunity.do")
	public ModelAndView updateBoard(Community c, ModelAndView mv, HttpServletRequest request) {

		commuService.updateCommu(c);
		
		mv.addObject("Com_Num", c.getComNum()).setViewName("redirect:detailCommunity.do");
		
		return mv;
	}
	
}
