package com.uni.spring.chat.model.dto;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Chat {

	private int crNo; // 채팅방 번호
	private String mNo; // 사원 번호
	private int cNo; // 회사 번호
	private String crTitle; // 채팅방 제목
	private String crPw; // 채팅방 비밀번호
	private String chatEnter; // 채팅방 입장시간
	private String chatExit; // 채팅방 
	private int chatSeq; // 채팅 순서
	private String chatContent; // 채팅 내용
	private String chatTime; // 채팅 입력시간
	private String crImage; // 채팅방 이미지 파일명
	private String crImageRoot; // 채팅방 이미지 파일 경로
	private int crFounderNo; // 개설자 사번
	private int crCount; // 참가자 총 명수
	private MessageType type;
	private Set<WebSocketSession> sessions = new HashSet<>();
	
	
	public enum MessageType{
		ENTER, CHAT, LEAVE
	}
	
	public void handlerMessage(WebSocketSession session, Chat chat, ObjectMapper objMapper) throws IOException{
		
		if(chat.getType() == MessageType.ENTER) {
			sessions.add(session);
		}else if(chat.getType() == MessageType.LEAVE) {
			sessions.remove(session);
		}else {
			chat.setChatContent(chat.getMNo() + " : " + chat.getChatContent()); 
		}
		
		send(chat, objMapper);
	}
	
	private void send(Chat chat, ObjectMapper objMapper) throws IOException{
		
		TextMessage textMessage = new TextMessage(objMapper.
												writeValueAsString(chat.getChatContent()));
		
	}
	
}
