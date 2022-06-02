package com.uni.spring.member.model.dto;

import java.sql.Date;

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
public class Member {
	
	private String mNo;
	private String mId;
	private String mName;
	private String mEmail;
	private String mPhone;
	private String mAddress;
	private String mPwd;
	private Date mEntDate;
	private Date mHireDate;
	private String mWork;
	private String mManager;
	private String mPwdError;
	private String pName; // 사진이름
	private String cName; // 회사이름
	private String dName; // 부서이름
	private String jName; // 직급이름
	private int pNo; // 사진번호
	private int cNo; // 회사번호
	private int dNo; // 부서번호
	private int jNo; // 직급번호
	private String cMNo; // 채팅방 생성 사원번호
	
	private String aAtime; // 출근시간 
	private String aLtime; // 퇴근시간
	private String aWtime; // 근무시간 or 월평균근무시간
	private String aState; // 근무상태
	private String allWtime; // 이번주근무시간
	
	private int wCount; // 정상출근수
 	private int lCount; // 지각수
}

