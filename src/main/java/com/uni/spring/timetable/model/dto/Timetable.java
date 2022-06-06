package com.uni.spring.timetable.model.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

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
	
	@JsonProperty("tNo")
	private int tNo;
	@JsonProperty("tTitle")
	private String tTitle; // 일정명
	@JsonProperty("tStart")
	private String tStart; // 시작시간 
	@JsonProperty("tEnd")
	private String tEnd; // 종료시간 
	@JsonProperty("tContent")
	private String tContent; // 일정내용
	@JsonProperty("tCategory")
	private String tCategory; // 구분
	@JsonProperty("tColor")
	private String tColor; // 색깔
	@JsonProperty("tAllday")
	private String tAllday; // 하루종일
	@JsonProperty("mNo")
	private String mNo;

}





