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

public class ApprovalLine {
	
	private int apNo; // 전자결재번호
	private String aplineStatus; // 결재상태
	private String mNo; // 사원번호 

}
