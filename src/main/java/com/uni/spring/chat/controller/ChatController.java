package com.uni.spring.chat.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.service.ChatService;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.service.MemberService;

@Controller
public class ChatController {

	@Autowired
	public ChatService chatService;
	
	@Autowired 
	private MemberService memberService;
	
	@RequestMapping("selectCommunityList.do")
	public ModelAndView selectCommunityList(ModelAndView mv) {
	
		mv.setViewName("chat/community");
	
		return mv;
	}
	
	@RequestMapping("selectChatRoomList.do")
	public ModelAndView selectChatRoomList(ModelAndView mv) {
		
		int cNo = 1;
		
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
		//System.out.println("list =====  " + list);
		
		
		mv.setViewName("chat/chatList");
		
		return mv;
	}
	
	@RequestMapping("createChatRoom.do")
	public ModelAndView createChatRoom(ModelAndView mv) {
		
		mv.setViewName("chat/createChatRoom");
		
		return mv;
	}
	
	@RequestMapping(value="CR_selectUserList.do", produces="application/json; charset=utf-8")
	public String selectUserList(Model model, Member m){
		
	Member loginUser = (Member)model.getAttribute("loginUser");
	
	int cNo = m.getCNo();
	System.out.println("cNo ======  " + cNo);
	System.out.println("loginUSer ==== = " + loginUser);
	ArrayList<Member> mList = chatService.selectMemList(loginUser.getCNo());
	
	return new GsonBuilder().setDateFormat("yyyy년 MM월 dd일 HH:mm:ss").create().toJson(mList);
	}
}
