package com.uni.spring.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
import com.uni.spring.common.exception.CommException;
import com.uni.spring.notice.model.notice;
import com.uni.spring.notice.service.noticeService;

@Controller
public class noticeController {
	
	@Autowired
	public noticeService noticeService;
	
	@RequestMapping("listNotice.do")
	public String selectList(@RequestParam(value="currentPage" , required = false, defaultValue = "1") int currentPage, Model model) {

		int listCount = noticeService.selectListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		
		ArrayList<notice> list = noticeService.selectList(pi);
		
		model.addAttribute("list",list);
		model.addAttribute("pi", pi);
		
		return "notice/noticeListView";
	}
	
	@RequestMapping("enrollFormNotice.do")
	public String enrollForm() {
		return "notice/noticeEnrollForm";
	}
	
	@RequestMapping("detailNotice.do")
	public ModelAndView selectBoard(int bno, ModelAndView mv) {
		notice n = noticeService.selectNotice(bno);
		
		mv.addObject("n", n).setViewName("notice/noticeDetailView");
		
		return mv; 
	}

	@RequestMapping("insertNotice.do")
	public String insertBoard(notice n, HttpServletRequest request, @RequestParam(name="uploadFile", required = false) MultipartFile file) {

		/*if(!file.getOriginalFilename().equals("")) { 
			String changeName = saveFile(file, request);
			if(changeName != null) {
				n.setOriginName(file.getOriginalFilename());
				n.setChangeName(changeName);
			}
		}*/
		
		noticeService.insertNotice(n);
		
		return "redirect:listNotice.do";
	}

	// 전달 받은 파일을 업로드 시킨후 파일명을 리턴하는 역할
	/*private String saveFile(MultipartFile file, HttpServletRequest request) {
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
	}*/
	
	@RequestMapping("deleteNotice.do")
	public String deleteBoard(int bno, String fileName, HttpServletRequest request) {
		
		noticeService.deleteNotice(bno);
		
		if(!fileName.equals("")) {
			deleteFile(fileName, request);
		}
		
		return "redirect:listNotice.do";
	}

	private void deleteFile(String fileName, HttpServletRequest request) {
		String resources = request.getSession().getServletContext().getRealPath("resources"); 
		String savePath = resources+"\\upload_files\\";
		
		File deleteFile = new File(savePath+fileName);
		deleteFile.delete();
	}
	
	@RequestMapping("updateFormNotice.do")
	public ModelAndView updateForm(int bno, ModelAndView mv) {
		mv.addObject("n", noticeService.selectNotice(bno)).setViewName("notice/noticeUpdateForm");
		
		return mv;
	}
	
	@RequestMapping("updateNotice.do")
	public ModelAndView updateBoard(notice n, ModelAndView mv, HttpServletRequest request, @RequestParam(name="reUploadFile", required = false) MultipartFile file) {

		/*String orgChangeName = n.getChangeName(); 
		
		if(!file.getOriginalFilename().equals("")) { // 새로 넘어온 파일이 있는 경우 / !file.isEmpty()도 가능
			String changeName = saveFile(file, request);
			n.setOriginName(file.getOriginalFilename());
			n.setChangeName(changeName);
		}*/
		
		noticeService.updateNotice(n);
		
		/*if(orgChangeName != null) { // 새로 넘어온 파일이 있는데 기존 파일이 있는 경우
			deleteFile(orgChangeName, request);
		}*/
		
		mv.addObject("bno", n.getNo_Num()).setViewName("redirect:detailNotice.do");
		
		return mv;
	}
	
}
