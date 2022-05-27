package com.uni.spring.attendance.model.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.uni.spring.job.model.dto.Job;

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
	private String entDate; // 등록일
	private String aAtime; // 출근시간
	private String aLtime; // 퇴근시간
	private String aWtime; // 근무시간
	private String aState; // 근무상태
}
