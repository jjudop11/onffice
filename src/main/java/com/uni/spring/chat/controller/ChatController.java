package com.uni.spring.chat.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatController {

	@RequestMapping("selectCommunityList.do")
	public ModelAndView selectCommunityList(ModelAndView mv) {
		
		mv.setViewName("chat/community");
		
		return mv;
	}
	
	
	@RequestMapping("selectChatRoomList.do")
	public ModelAndView selectChatRoomList(ModelAndView mv) {
		
		mv.setViewName("chat/chatRoom");
		
		return mv;
	}
}
