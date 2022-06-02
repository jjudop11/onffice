package com.uni.spring.community.controller;

import java.io.File;
import java.util.ArrayList;

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
import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.Reply;
import com.uni.spring.community.service.CommuService;

@Controller
public class CommuController {
	
	@Autowired
	public CommuService commuService;
	
	@RequestMapping("listCommunity.do")
	public String selectList(Model model) {

		int listCount = commuService.selectListCount();
		
		ArrayList<Community> list = commuService.selectList();
		model.addAttribute("list",list);

		return "community/CommunityListView";
	}
	
	@RequestMapping("enrollFormCommunity.do")
	public String enrollForm() {
		return "community/CommunityEnrollForm";
	}
	
	@RequestMapping("insertCommu.do")
	public String insertBoard(Community c, HttpServletRequest request, @RequestParam(name="uploadFile", required = false) MultipartFile file) {

		/*if(!file.getOriginalFilename().equals("")) { 
			String changeName = saveFile(file, request);
			if(changeName != null) {
				n.setOriginName(file.getOriginalFilename());
				n.setChangeName(changeName);
			}
		}*/

		commuService.insertCommu(c);
		
		return "redirect:listCommunity.do";
	}
	
	@RequestMapping("detailCommunity.do")
	public String selectNotice(@RequestParam(value= "Com_Num") int cn, Model model) {
		Community c = commuService.selectCommu(cn);
		
		model.addAttribute("c", c);
		System.out.println(c);
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
		
		commuService.deleteNotice(ComNum);
		
		return "redirect:listCommunity.do";
	}

	/*
	// 전달 받은 파일을 업로드 시킨후 파일명을 리턴하는 역할
	private String saveFile(MultipartFile file, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources"); // 웹 컨텐트에서의 resources 폴더까지의 경로 지정
		String savePath = resources+"\\upload_files\\";
		
		System.out.println(resources);
		System.out.println(savePath);
		
		String originName = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHmmss").format(new Date());
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String changeName = currentTime + ext;
		
		try {
			file.transferTo(new File(savePath+changeName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new CommException("file upload error");
		}
		
		return changeName;
	}
	
	

	private void deleteFile(String fileName, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources"); 
		String savePath = resources+"\\upload_files\\";
		
		File deleteFile = new File(savePath+fileName);
		deleteFile.delete();
	}
	
	@RequestMapping("updateFormNotice.do")
	public ModelAndView updateForm(@RequestParam(value= "No_Num") int bno, ModelAndView mv) {
		mv.addObject("n", noticeService.selectNotice(bno)).setViewName("notice/noticeUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("updateNotice.do")
	public ModelAndView updateBoard(notice n, ModelAndView mv, HttpServletRequest request, @RequestParam(name="reUploadFile", required = false) MultipartFile file) {

		String orgChangeName = n.getChangeName(); 
		
		if(!file.getOriginalFilename().equals("")) { // 새로 넘어온 파일이 있는 경우 / !file.isEmpty()도 가능
			String changeName = saveFile(file, request);
			n.setOriginName(file.getOriginalFilename());
			n.setChangeName(changeName);
		}
		
		noticeService.updateNotice(n);
		
		if(orgChangeName != null) { // 새로 넘어온 파일이 있는데 기존 파일이 있는 경우
			deleteFile(orgChangeName, request);
		}
		
		mv.addObject("No_Num", n.getNo_Num()).setViewName("redirect:detailNotice.do");
		
		return mv;
	}*/
	
}
