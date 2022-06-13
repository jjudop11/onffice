package com.uni.spring.chat.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.GsonBuilder;
import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.dto.Message;
import com.uni.spring.chat.model.service.ChatService;
import com.uni.spring.member.model.dto.Member;

import lombok.RequiredArgsConstructor;

import lombok.RequiredArgsConstructor;

@SessionAttributes({"loginUser", "msg"})
@Controller
//@RequiredArgsConstructor // Autowired를 안써도 되는 어노테이션
public class ChatController {

	@Autowired
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
			//System.out.println("loginUser ==== " + loginUser);
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
		int cNo = loginUser.getCNo();
		ArrayList<Chat> count = chatService.selectCount(cNo);
		System.out.println("count === " + count);
		ArrayList<Chat> list = chatService.selectChatRoomList(cNo);
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
	  public int insertSelectUserList(@RequestParam(value="eList[]") ArrayList<String> eList, Model model) {
		
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
			
			
				long chatNo = new Date().getTime();
				String orderN = String.valueOf(chatNo).substring(5);
				chatNo = Long.parseLong(orderN);
				
				chat.setCrNo(chatNo);
				chat.setCrFounderNo(loginUser.getMNo());
				chat.setCNo(loginUser.getCNo());
				chatService.createChatRoom(chat);
				
				/*
				Member m = new Member();	
				
				m.setCNo(loginUser.getCNo());
				m.setMNo(loginUser.getMNo());	
				*/
				ArrayList<Member> mList = chatService.checkedUserList(loginUser);
				System.out.println("mList.size === " + mList );
				if(mList.size() > 0) {
				
					chatService.insertChatUser(chat, mList,loginUser);
				
				}
				return "chat/chatList";
			
			
	}
	

	@GetMapping(value="/chatRoom/exitRoom")
	public String exitRoom(Model model, String crNo, String mNo, String cNo) {
		
		Chat chat = new Chat();
		chat.setCrNo(Integer.parseInt(crNo));
		chat.setMNo(mNo);
		chat.setCNo(Integer.parseInt(cNo));
		System.out.println("chat ========== " + chat);
		//System.out.println("exit 실행 ==================");
		Chat chatRoom = chatService.findRoomUser(chat);
		//System.out.println("chatRoom === " + chatRoom );
		if(chatRoom.getMNo().equals(chatRoom.getCrFounderNo())) {
			
			// 채팅방 자체 삭제
			chatService.deleteRoom(chat);
			
		}else {
			
			chatService.exitChatRoom(chat);
			
			chatService.deleteCAUser(chat);
			
		}

		return "redirect:/chatRoomListForm";
	}
	
	
		// 채팅방 입장
		@PostMapping(value="chatRoom/{crNo}")
		public String EnterChatRoom(Model model, Chat chat){
			
			Member loginUser = (Member)model.getAttribute("loginUser");
			
			//비로그인이면 메인으로
			if(loginUser == null) {
				
				return "redirect:/";
			}else{
				
				// 채팅방 채팅내역 정보
				ArrayList<Message> message = chatService.selectCHList(chat);	
				//System.out.println("message ==== " + message);
				
				// 채팅방 입장 시간 입력
				Date chatNo = new Date();
				SimpleDateFormat sd = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
				String chatEnter = sd.format(chatNo);
				
				chat.setChatEnter(chatEnter);
				chat.setCNo(loginUser.getCNo());
				chat.setMNo(loginUser.getMNo());
				//System.out.println("chatNo ===  " + chatEnter);
				
				// 채팅방 출입 목록에 있는지 확인 = 한 번이라도 그 방에 들어간 적이 있는지 확인
				Chat caUser = chatService.findCAUser(chat);
				
				// 들어가려는 채팅방의 맴버 정보 출력
				ArrayList<Chat> user = chatService.findRoomUserList(chat);
				
				for(Chat c : user) {
					// 들어가려는 채팅방 목록에 맴버 정보가 있으면
					if(c.getMNo().contains(chat.getMNo())) {

						// 출입 여부를 확인해서 입장 시간을 입력 or 수정 해줌 
						if(caUser == null) {
							chatService.insertCAUser(chat);
						}else {
							chatService.updateCAUser(chat);
						}
						
						//System.out.println("message ==== " + message);
						//System.out.println("mem ===== " + loginUser);
						
						model.addAttribute("message", message);
						model.addAttribute("mem", loginUser);
						model.addAttribute("chat", chat);
						
						return "chat/chat";
						
					}
	
				}
				
				chat.setCrFounderNo(user.get(0).getCrFounderNo());
				
				chatService.insertCAUser(chat);				
				chatService.insertChatUser(chat);
				
				model.addAttribute("message", message);
				model.addAttribute("mem", loginUser);
				model.addAttribute("chat", chat);
				
				return "chat/chat";
			}
		}

		
		@MessageMapping("/chat/send")
	    public void sendMsg(Message message){

			// message에 cNo넣어주기
			Chat chat = new Chat();
			//System.out.println("message.getCNo === " + message.getCNo());
			chat.setCNo(message.getCNo());
			chat.setCrNo(message.getCrNo());
			chat.setMNo(message.getMNo());
			chat.setSender(message.getSender());
			chat.setChatContent(message.getChatContent());
			
			Date chatNo = new Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			chat.setChatTime(sd.format(chatNo));
			message.setChatTime(sd.format(chatNo));
			
			SimpleDateFormat sd1 = new SimpleDateFormat("MM.dd a HH:mm");
			chat.setChatCTime(sd1.format(chatNo));
			message.setChatCTime(sd1.format(chatNo));
			
			System.out.println(chat);
			Member m = chatService.loginUser(chat);
			System.out.println("loginUser m ====== " + m);
			message.setPName(m.getPName());
			
			chat.setPName(m.getPName());
	
			
			template.convertAndSend("/topic/" + message.getCrNo(), message);
			
			Chat chatSeq = new Chat(); 
			chatSeq = chatService.findCHSeq(chat);
			System.out.println("chatSeq === " + chatSeq);
			int seq = 1;
			if(chatSeq == null) {
				
				chat.setChatSeq(seq);
				
			}else {
				int seq1 = chatSeq.getChatSeq()+1;
				chat.setChatSeq(seq1);
			}
		
			//System.out.println("message ==== " + message);
			chatService.saveChat(chat);

	    }
		
		
		@RequestMapping("/chatRoom/disconnect")
		public String disconnect(String crNo, String mNo) {
			System.out.println("disconnect 실행");
			Chat mem = new Chat();
			
			Date exitTime = new Date();
			SimpleDateFormat sd = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			mem.setChatExit(sd.format(exitTime));
			
			
			mem.setCrNo(Integer.parseInt(crNo));
			mem.setMNo(mNo);
			
			chatService.disconnect(mem);
			return "redirect:/chatRoomListForm";
		}
		
}
