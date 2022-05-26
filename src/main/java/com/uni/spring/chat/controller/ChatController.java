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
		
		// 채팅방 당 참가자 수 구하기
		ArrayList<Chat> count = chatService.selectCount();
		
		ArrayList<Chat> list = chatService.selectChatRoomList();
		
		for(int i = 0; i < list.size(); i++) {
			
			for(int j = 0; j < count.size(); j++) {
				if(count.get(j).getCrNo() == list.get(i).getCrNo()) {
					list.get(i).setCrCount(count.get(j).getCrCount());
				}
				
			}
			
			
		}
		
		mv.addObject("list", list);
		System.out.println("list =====  " + list);
		
		
		mv.setViewName("chat/chatList");
		
		return mv;
	}
	
	@RequestMapping("createChatRoom.do")
	public ModelAndView createChatRoom(ModelAndView mv) {
		
		mv.setViewName("chat/createChatRoom");
		
		return mv;
	}

}
