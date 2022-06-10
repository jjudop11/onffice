package com.uni.spring.common.exception;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.uni.spring.member.model.dto.Alram;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.service.MemberService;

@SessionAttributes({"loginUser", "msg", "mNo"})
public class EchoHandler extends TextWebSocketHandler {
	
	@Autowired
	private MemberService memberService;
	
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		// 로그인한 Member 모두 list 저장
		sessions.add(session);
		/*
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
		*/
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		
		Map<String, Object> httpSession = session.getAttributes();
		
		Member loginUser = (Member)httpSession.get("loginUser");	
		
		String loginUserName = loginUser.getMName();

		String msg = message.getPayload();
		
		String[] strs = msg.split(",");
		
		String category = strs[0];
		String name = strs[1];
		String jName = strs[2];
		String dName = strs[3];
		
		Map<String,Object> map = new HashMap<String, Object>();
		ArrayList<Member> allList = memberService.selectMemList(null, loginUser.getCNo());
		ArrayList<Alram> aList = new ArrayList<Alram>();
		System.out.println("==================================리스트 길이" + sessions.size());
		 for(WebSocketSession sess : sessions){
			 System.out.println("sess.getAttributes() ==============="+ sess.getAttributes());
			 if(sess.getAttributes() != null) {
				 
				 map = sess.getAttributes();
				 Member m = (Member) map.get("loginUser");

				if(!m.getMName().equals(loginUserName)) {
					 
					 if(category.equals("퇴근")) {
				         for(Member m2 : allList) {
				        	 if(!m2.getMName().equals(loginUserName)) {
				        		 Alram a = Alram.builder()
						        		 .alContent(dName +"부서의 "+name + jName + "님이" + "<br> 퇴근하셨습니다")
						        		 .mNo(m2.getMNo())
						        		 .build();
				        		 aList.add(a);
				        	 }
				         }
				         memberService.insertAlram(aList);
						 
						 TextMessage tmpMsg = new TextMessage(dName +"부서의 "+name + jName + "님이" + "<br> 퇴근하셨습니다");
				         sess.sendMessage(tmpMsg);
				         
					 } else if(category.equals("출근")) {
						
						 for(Member m2 : allList) {
				        	 if(!m2.getMName().equals(loginUserName)) {
				        		 Alram a = Alram.builder()
						        		 .alContent(dName +"부서의 "+name + jName + "님이" + "<br> 출근하셨습니다")
						        		 .mNo(m2.getMNo())
						        		 .build();
				        		 aList.add(a);
				        	 }
						 }
						 memberService.insertAlram(aList);

						 TextMessage tmpMsg = new TextMessage(dName +"부서의 "+name + jName + "님이" + "<br> 출근하셨습니다");
				         sess.sendMessage(tmpMsg);
					 }
				} 
			 }
	     }
						
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		sessions.remove(session);
		//userSessionsMap.remove(currentUserName(session),session);
	}

}
