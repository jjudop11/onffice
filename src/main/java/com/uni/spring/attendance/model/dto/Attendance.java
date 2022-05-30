package com.uni.spring.attendance.model.dto;

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
public class Attendance {

	private String mNo;
	private String aEntDate; // 등록일
	private String aAtime; // 출근시간 
	private String aLtime; // 퇴근시간
	private String aWtime; // 근무시간 or 월평균근무시간
	private String aState; // 근무상태
	private String allWtime; // 이번주근무시간
}
