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

public class ApList {
	
	private int apNo; // 전자결재번호
	private int foNo; // 서식번호
	private String doTitle; // 제목
	private String doDate; // 작성날짜 
	
	private String mNo; // 사원번호 
	private int cNo; // 회사번호 
	private String apStatus; // 최종결재여부
	private String aplineNo; // 결재자 사원번호

}
