package com.uni.spring.approval.model.dto;

import java.util.List;

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
	private String aplineNo; // 결재사원번호 
	
//	private int[] apNoList; // 전자결재번호
//	private String[] aplineStatusList; // 결재상태 
//	private String[] aplineNoList; // 결재사원번호 리스트

//	public void setAplineNoList(String string) {
//		// TODO Auto-generated method stub
//		
//	}
	
}
