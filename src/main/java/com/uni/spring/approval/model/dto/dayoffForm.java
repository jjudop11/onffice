package com.uni.spring.approval.model.dto;

import java.sql.Date;

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

public class dayoffForm {
	
	private int doNo; // 휴가신청번호 
	private Date doDate; // 작성일 
	private String doTitle; // 제목 
	private Date doStartDate; // 시작일 
	private Date doEndDate; // 종료일 
	private String doContent; // 사유 
	private int apNo; // 전자결재번호 
	private int foNo; // 서식번호 
	private String mNo; // 사원번호 
	private int doType; // 휴가타입번호 

}
