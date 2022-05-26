package com.uni.spring.approval.model.dto;

import java.sql.Date;

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

public class PaymentForm {

	private int payNo; // 결의서번호 
	private Date payDate; // 작성일 
	private String payTitle; // 제목 
	private Date payDay; // 결제일자 
	private String payList; // 구매내역, 금액 
	private String payAmount; // 총지출금액 
	private int apNo; // 전자결재벟노 
	private int foNo; // 서식번호 
	private String mNo; // 사원번호 
	
}
