package com.uni.spring.chat.controller;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

	private SimpMessagingTemplate template;

	
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
	
	@RequestMapping("chatRoomListForm")
	public ModelAndView chatRoomListForm(ModelAndView mv, Model model) {

		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			mv.setViewName("member/login");
		}else{
			mv.setViewName("chat/chatList");
		}
		
		
	
		return mv;
	}
	
	
	@ResponseBody
	@RequestMapping(value="selectChatRoomList", produces="application/json; charset=utf-8")
	public String selectChatRoomList(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		if(loginUser == null) {
			return "member/login";
	
		}else {
		
		// 채팅방 당 참가자 수 구하기
		ArrayList<Chat> count = chatService.selectCount();
		System.out.println("count === " + count);
		ArrayList<Chat> list = chatService.selectChatRoomList();
		System.out.println("list ========= " + list);
		for(int i = 0; i < list.size(); i++) {
			
		
				if(count.get(i).getCrNo() == list.get(i).getCrNo()) {
					list.get(i).setCrCount(count.get(i).getCrCount());
	
				
			}
			
		
		}
		return new GsonBuilder().create().toJson(list);
	}
	
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
	
	// 채팅방 생성
	@RequestMapping("createChatRoom")
	//public ModelAndView createChatRoom(ModelAndView mv, Chat chat, @RequestParam(value="eList[]") ArrayList<String> eList, Model model) {
	public String createChatRoom(ModelAndView mv, Chat chat, Model model) {
	
			
			Member loginUser = (Member)model.getAttribute("loginUser");
			
			if(loginUser == null) {
				
				return "member/login";
			}else{
			
				long chatNo = new Date().getTime();
				String orderN = String.valueOf(chatNo).substring(5);
				chatNo = Long.parseLong(orderN);
				
				chat.setCrNo(chatNo);
				chat.setCrFounderNo(loginUser.getMNo());
				chat.setCNo(loginUser.getCNo());
				chatService.createChatRoom(chat);
				
				Member m = new Member();	
				
				m.setCNo(loginUser.getCNo());
				m.setMNo(loginUser.getMNo());	
				ArrayList<Member> mList = chatService.checkedUserList(m);
				System.out.println("mList.size === " + mList );
				if(mList.size() > 0) {
				
					chatService.insertChatUser(chat, mList,m);
				
				}
				return "chatRoom/" + chat.getCrNo();
			
			}
	}
	
	/*
	@RequestMapping("chat")
	public String EnterChatRoom(Model model, Chat chat) {
		
		//Member loginUser = (Member)model.getAttribute("loginUser");
		
		//Member m = new Member();	
		
		//m.setCNo(loginUser.getCNo());
		//m.setMNo(loginUser.getMNo());	
		
		return "/chat/chat";
	}
	*/
	 
	
	
		// 채팅방 입장

		@RequestMapping("chatRoom/{crNo}")
		public ModelAndView EnterChatRoom(Chat chat, ModelAndView mv, Model model){
			
			Member loginUser = (Member)model.getAttribute("loginUser");
			
			if(loginUser == null) {
				
				mv.setViewName("redirect:/");
				return mv;
			}else{
				
				chat.setMNo(loginUser.getMNo());
		
				Chat user = chatService.findRoomUser(chat);
				
				
				if(user.getMNo() == null) {
					chat.setCrFounderNo(user.getCrFounderNo());
					chatService.insertChatUser(chat);
					
					mv.addObject("m", loginUser);
					mv.addObject("chat", chat);
			
					mv.setViewName("chat/chat");
					
					return mv;
					
				}else {

					mv.addObject("m", loginUser);
					mv.addObject("chat", chat);
					mv.setViewName("chat/chat");
					
					return mv;
					}
			}
		}
		
		
		
		@MessageMapping("/chat/send")
	    public void sendMsg(Chat message){
			
			long crNo = message.getCrNo();
			System.out.println("message  ==== " + message);
	        //chatService.saveMessage(message);
	        template.convertAndSend("/topic/" + crNo,message);
	        
	    }
	
		
}
