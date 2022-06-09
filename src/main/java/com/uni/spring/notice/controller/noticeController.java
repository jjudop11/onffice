package com.uni.spring.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.common.SearchCondition;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.notice.model.notice;
import com.uni.spring.notice.service.noticeService;

@Controller
public class noticeController {
	
	@Autowired
	public noticeService noticeService;
	
	
	@RequestMapping("listNotice.do")
	public String selectList(@RequestParam(value="currentPage" , required = false, defaultValue = "1") int currentPage, HttpSession session, Model model) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		int companyNo = loginUser.getCNo();
		int listCount = noticeService.selectListCount(companyNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		
		ArrayList<notice> list = noticeService.selectList(pi,companyNo);
		
		model.addAttribute("list",list);
		model.addAttribute("pi", pi);
		
		return "notice/noticeListView";
	}
	
	@RequestMapping("searchNotice.do")
	public String searchNotice(@RequestParam(value="currentPage" , required = false, defaultValue = "1") int currentPage, @RequestParam(value= "keyword") String keyword, @RequestParam(value= "condition") String condition, HttpSession session, Model model) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		int companyNo = loginUser.getCNo();
		
		SearchCondition sc = new SearchCondition();
		sc.setCNo(companyNo);
		switch (condition) {
		case "titleAndContent":
			sc.setTitleAndContent(keyword);
			break;
		case "title":
			sc.setTitle(keyword);
			break;
		case "content":
			sc.setContent(keyword);
			break;
		}
		
		int listCount = noticeService.searchListCount(sc);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		ArrayList<notice> list = noticeService.searchList(sc, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		model.addAttribute("listCount",listCount);
		
		return "notice/noticeSearchView";
	}
	
	@RequestMapping("enrollFormNotice.do")
	public String enrollForm() {
		return "notice/noticeEnrollForm";
	}
	
	@RequestMapping("detailNotice.do")
	public String selectNotice(@RequestParam(value= "no_Num") int no_Num, Model model) {
		notice n = noticeService.selectNotice(no_Num);
		
		model.addAttribute("n", n);
		
		return "notice/noticeDetailView"; 
	}

	@RequestMapping("insertNotice.do")
	public String insertBoard(notice n, HttpServletRequest request, @RequestParam(name="No_Important", required = false) String imp) {

		if( imp == null || imp == "N" ) { n.setNo_Important("N"); }
		if( imp == "Y") { n.setNo_Important("Y"); }
		
		noticeService.insertNotice(n);
		
		return "redirect:listNotice.do";
	}

	
	@RequestMapping("deleteNotice.do")
	public String deleteNotice(int No_Num, String fileName, HttpServletRequest request) {
		
		noticeService.deleteNotice(No_Num);
		
		
		return "redirect:listNotice.do";
	}

	@RequestMapping("updateFormNotice.do")
	public ModelAndView updateForm(@RequestParam(value="No_Num") int no_Num, ModelAndView mv) {
		mv.addObject("n", noticeService.selectNotice(no_Num)).setViewName("notice/noticeUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("updateNotice.do")
	public ModelAndView updateBoard(notice n, ModelAndView mv, @RequestParam(name="No_Important", required = false) String imp, HttpServletRequest request) {

		if( imp == null || imp == "N" ) { n.setNo_Important("N"); }
		if( imp == "Y") { n.setNo_Important("Y"); }
		
		noticeService.updateNotice(n);

		mv.addObject("no_Num", n.getNo_Num()).setViewName("redirect:detailNotice.do");
		
		return mv;
	}
	
}
