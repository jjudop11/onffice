package com.uni.spring.chat.controller;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import com.google.gson.GsonBuilder;
import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.service.ChatService;
import com.uni.spring.member.model.dto.Member;

@SessionAttributes({"loginUser", "msg"})
@Controller
public class ChatController {

	@Autowired
	public ChatService chatService;
	
	@RequestMapping("selectCommunityList")
	public ModelAndView selectCommunityList(ModelAndView mv, Model model) {

		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			mv.setViewName("member/login");
		}else{
			mv.setViewName("chat/community");
		}
		
		
	
		return mv;
	}
	
	
	@RequestMapping("selectChatRoomList")
	public ModelAndView selectChatRoomList(ModelAndView mv, Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			mv.setViewName("member/login");
	
		}else {
		
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
		}
		return mv;
	}
	
	
	
	@ResponseBody
	@RequestMapping(value="crSelectUserList", produces="application/json; charset=utf-8")
	public String selectUserList(Model model){
		
	Member loginUser = (Member)model.getAttribute("loginUser");
	
	Member m = new Member();
	
	m.setCNo(loginUser.getCNo());
	m.setMNo(loginUser.getMNo());
	
	ArrayList<Member> mList = chatService.selectMemList(m);
	//System.out.println("mList -====- " + mList);
	return new GsonBuilder().create().toJson(mList);
	}
	
	
	@ResponseBody
	@RequestMapping(value="insertSelectUserList")
	//public int insertSelectUserList(@RequestBody Member[] eList, Model model) {
	  public int insertSelectUserList(@RequestParam(value="eList[]") ArrayList<String> eList, Model model) {
		
		//System.out.println(eList);
		
		if(eList.size() > 0) {
			Member loginUser = (Member)model.getAttribute("loginUser");
			Member m = new Member();
			m.setCMNo(loginUser.getMNo());
			m.setCNo(loginUser.getCNo());
			for(int i = 0; i < eList.size(); i++){
			   
				m.setMNo(eList.get(i));
				System.out.println("eList.get(i) ================ " + eList.get(i));
				chatService.insertSelectUserList(m);
				
			  }
			
			return 1;
			}

		
		/*
	
		if(eList.length > 0) {
		Member loginUser = (Member)model.getAttribute("loginUser");
		Member m = new Member();
		m.setCMNo(loginUser.getMNo());
		m.setCNo(loginUser.getCNo());
		for(Member r: eList){
		   
			m.setMNo(r.getMNo());
			System.out.println("r.getMNo ================ " + r.getMNo());
			chatService.insertSelectUserList(m);
			
		  }
		
		return 1;
		}
		*/
		return 0;
	}
	
	@ResponseBody
	@RequestMapping(value="checkedUserList", produces="application/json; charset=utf-8")
	public String checkedUserList(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		Member m = new Member();
		
		m.setCNo(loginUser.getCNo());
		m.setMNo(loginUser.getMNo());

		ArrayList<Member> mList = chatService.checkedUserList(m);
		

		return new GsonBuilder().create().toJson(mList);
	}
	
	@ResponseBody
	@RequestMapping("deleteCheckedUser")
	public int deleteCheckedUser(Model model) {
		
		System.out.println("컨트롤러 찍히는지 홧인");
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		Member m = new Member();	
		
		m.setCNo(loginUser.getCNo());
		m.setMNo(loginUser.getMNo());	
		
		chatService.deleteCheckedUser(m);
		
		return 1;
	}
	
	
	@RequestMapping("chat")
	public String EnterChatRoom(Model model, Chat chat) {
		
		//Member loginUser = (Member)model.getAttribute("loginUser");
		
		//Member m = new Member();	
		
		//m.setCNo(loginUser.getCNo());
		//m.setMNo(loginUser.getMNo());	
		
		return "/chat/chat";
	}
	
	// 채팅방 생성
		@ResponseBody
		@RequestMapping("chatRoom/{crNo}")
		public ModelAndView createChatRoom(ModelAndView mv, Chat chat, Model model){
			
			Member loginUser = (Member)model.getAttribute("loginUser");
			
			Member m = new Member();	
			
			m.setCNo(loginUser.getCNo());
			m.setMNo(loginUser.getMNo());
			m.setMName(loginUser.getMName());
			
			mv.addObject("m", m);
			mv.addObject("chat", chat);
			//System.out.println(m);
			//System.out.println(chat);
			mv.setViewName("chat/chat");
			
			return mv;
			
		}
	
		
}
