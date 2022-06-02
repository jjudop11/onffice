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
	
	// 채팅방 생성
	@ResponseBody
	@RequestMapping("chatRoom")
	public ModelAndView createChatRoom(ModelAndView mv, 
			@RequestParam(value="crNo", required = false, defaultValue = "1") int crNo){
		
		
		
		
		mv.setViewName("chat/chatRoom");
		
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
	public int insertSelectUserList(@RequestBody Member[] eList, Model model) {

	
		if(eList.length > 0) {
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		Member m = new Member();
		m.setCMNo(loginUser.getMNo());
		m.setCNo(loginUser.getCNo());
		for(Member r: eList){
		   
			m.setMNo(r.getMNo());
			chatService.insertSelectUserList(m);
			System.out.println("m ================ " + m);
		  }
		
		//Member nm = new Member();
		
		//nm.setCNo(loginUser.getCNo());
		//nm.setMNo(loginUser.getMNo());
		
		//ArrayList<Member> mList = chatService.checkedUserList(nm);
		//System.out.println("mList ================ " + mList);
	//	return new GsonBuilder().create().toJson(mList);
		
		return 1;
		}
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
	
	/*
	@MessageMapping("/chat/chatTest")
    @SendTo("/chat/greetings")
    public Greeting greeting(Member m) throws Exception{
		
		Thread.sleep(100); // delay
		return new Greeting("Hello, " + HtmlUtils.htmlEscape(m.getMName()) + "!");
	}
	*/
	@RequestMapping("chat")
	public String EnterChatRoom(Model model, Chat chat) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		Member m = new Member();	
		
		m.setCNo(loginUser.getCNo());
		m.setMNo(loginUser.getMNo());	
		
		return "/chat/chat";
	}
	
	/*
	@GetMapping("WebSocketEx")
	public String WebSocketEx() {

		return "/chat/WebSocketEx";
	}
	*/
	
		
}
