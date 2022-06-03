package com.uni.spring.timetable.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class Timetable {
	
	private int tNo;
	private String tName; // 일정명
	private String tStart; // 시작시간 
	private String tEnd; // 종료시간 
	private String tContent; // 일정내용
	private String mNo;

}





