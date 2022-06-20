package com.uni.spring.chat.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Message {

	private int cNo;				// 회사 번호
	private long crNo; 				// 채팅방 번호
	private String mNo; 			// 사원 번호
	private int chatSeq; 			// 채팅 순서
	private String chatContent; 	// 채팅 내용
	private String chatTime; 		// 채팅 입력시간
	private String chatCTime; 		// 채팅 대화 시간
	private String crImage; 		// 채팅방 이미지 파일명
	private String crImageRoot; 	// 채팅방 이미지 파일 경로
	private String sender; 			// 채팅 보낸 사람
	private String pName; 			// 프로필사진 이름

}
