package com.uni.spring.chat.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.service.ChatService;

@Controller
public class ChatController {

	@Autowired
	public ChatService chatService;
	
	@RequestMapping("selectCommunityList.do")
	public ModelAndView selectCommunityList(ModelAndView mv) {
	
		mv.setViewName("chat/community");
	
		return mv;
	}
	
	
	
	@RequestMapping("selectChatRoomList.do")
	public ModelAndView selectChatRoomList(ModelAndView mv) {
		
		ArrayList<Chat> list = chatService.selectChatRoomList();
		
		mv.addObject("list", list);
		//System.out.println("list =====  " + list);
		mv.setViewName("chat/chatList");
		
		return mv;
	}
	
	@RequestMapping("createChatRoom.do")
	public ModelAndView createChatRoom(ModelAndView mv) {
		
		mv.setViewName("chat/createChatRoom");
		
		return mv;
	}

}
