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

public class Approval {
	
	private int apNo; // 전자결재번호
	private String apStatus; // 최종결재상태 
	private String status; // 삭제여부 
	private int foNo; // 서식번호
	private int cNo; // 회사번호
	private int dNo; // 부서번호
	private String mNo; // 사원번호

}
