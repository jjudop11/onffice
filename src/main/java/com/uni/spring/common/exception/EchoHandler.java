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
		String category = "";
		String name = "";
		String jName = "";
		String dName = "";

		if(msg.equals("새로운 공지사항이 등록되었습니다")) {
			category = msg;
		} else {
			String[] strs = msg.split(",");
			
			category = strs[0];
			name = strs[1];
			jName = strs[2];
			dName = strs[3];
		}

		Map<String,Object> map = new HashMap<String, Object>();
		ArrayList<Member> allList = memberService.selectMemList(null, loginUser.getCNo());
		ArrayList<Alram> aList = new ArrayList<Alram>();
		System.out.println("==================================리스트 길이" + sessions.size());
		
		if(category.equals("퇴근")) {
			// 알림창
			for(WebSocketSession sess : sessions){ // 로그인한 사람 리스트 돌려서
				if(sess.getAttributes() != null) {
					map = sess.getAttributes();
					Member m = (Member) map.get("loginUser"); // 로그인 유저 뽑아서
					
					if(!m.getMName().equals(loginUserName)) { // 퇴근 유저아닌 유저한테 알림 띄우고
						TextMessage tmpMsg = new TextMessage(dName +"부서의 "+name + jName + "님이" + "<br>퇴근하셨습니다");
				         sess.sendMessage(tmpMsg);
					}
				}
			}
			// DB 저장
			for(Member mem : allList) { // 전체 리스트 에서
				if(!mem.getMName().equals(loginUserName)) { // 지금 출퇴근자 제외
					Alram a = Alram.builder()
			        		 .alContent(dName +"부서의 "+name + jName + "님이" + "<br>퇴근하셨습니다")
			        		 .mNo(mem.getMNo())
			        		 .build();
	       		 	aList.add(a);
				}
			}
			
		} else if(category.equals("출근")) {
			
			for(WebSocketSession sess : sessions){ // 로그인한 사람 리스트 돌려서
				if(sess.getAttributes() != null) {
					map = sess.getAttributes();
					Member m = (Member) map.get("loginUser"); // 로그인 유저 뽑아서
					
					if(!m.getMName().equals(loginUserName)) { // 출근 유저아닌 유저한테 알림 띄우고
						TextMessage tmpMsg = new TextMessage(dName +"부서의 "+name + jName + "님이" + "<br>출근하셨습니다");
				         sess.sendMessage(tmpMsg);
					}
				}
			}
			
			for(Member mem : allList) { // 전체 리스트 에서
				if(!mem.getMName().equals(loginUserName)) { // 출퇴근자 제외
					Alram a = Alram.builder()
			        		 .alContent(dName +"부서의 "+name + jName + "님이" + "<br>출근하셨습니다")
			        		 .mNo(mem.getMNo())
			        		 .build();
	        		 aList.add(a);
				}
			}
			
		} else {
			
			for(WebSocketSession sess : sessions){ // 로그인한 사람 리스트 돌려서
				if(sess.getAttributes() != null) {
					map = sess.getAttributes();
					Member m = (Member) map.get("loginUser"); // 로그인 유저 뽑아서
					
					if(!m.getMName().equals(loginUserName)) { // 출근 유저아닌 유저한테 알림 띄우고
						TextMessage tmpMsg = new TextMessage(msg);
				         sess.sendMessage(tmpMsg);
					}
				}
			}
			
			for(Member mem : allList) { // 전체 리스트 에서
				if(!mem.getMName().equals(loginUserName)) { // 출퇴근자 제외
					Alram a = Alram.builder()
			        		 .alContent("새로운 공지사항이<br> 등록되었습니다")
			        		 .mNo(mem.getMNo())
			        		 .build();
	        		 aList.add(a);
				}
			}
			
		}
		memberService.insertAlram(aList);
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		sessions.remove(session);
		//userSessionsMap.remove(currentUserName(session),session);
	}

}
