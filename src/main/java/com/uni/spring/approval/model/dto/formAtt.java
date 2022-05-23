package com.uni.spring.approval.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class formAtt {
	
	private int apNo; // 전자결재번호 
	private String originName; // 파일원본명
	private String changeName; // 파일수정명 
	private String filePath; // 저장폴더경로 
	private String status; // 삭제여부 
	private int foNo; // 서식번호 

}
