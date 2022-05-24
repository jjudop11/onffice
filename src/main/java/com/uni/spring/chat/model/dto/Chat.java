package com.uni.spring.chat.model.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class Chat {

	private int crNo; // 채팅방 번호
	private String mNo; // 사원 번호
	private int cNo; // 회사 번호
	private String crTitle; // 채팅방 제목
	private String crPw; // 채팅방 비밀번호
	private Timestamp chatEnter; // 채팅방 입장시간
	private Timestamp chatExit; // 채팅방 
	private int chatSeq; // 채팅 순서
	private String chatContent; // 채팅 내용
	private Timestamp chatTime; // 채팅 입력시간
	private String crImage; // 채팅방 이미지 파일명
	private String crImageRoot; // 채팅방 이미지 파일 경로
	private int crFounderNo; // 개설자 사번
}
