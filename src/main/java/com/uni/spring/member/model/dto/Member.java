package com.uni.spring.member.model.dto;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
	
	
	

}
