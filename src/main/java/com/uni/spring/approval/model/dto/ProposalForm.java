package com.uni.spring.approval.model.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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

public class ProposalForm {
	
	private int prNo; // 사업기획번호
	private Date prDate; // 작성일 
	private String prTitle; // 프로젝트명 
	private String prGoal; // 시행목적 
	private String prPlan; // 운영계획 
	private String prStartDate; // 시작일 	
	private String prEndDate; // 종료일 
	private String prPerson; // 참여인원 
	private String prAmount; // 소요예산 
	private int apNo; // 전자결재번호 
	private int foNo; // 서식번호 
	private String mNo; // 사원번호 
	
}
