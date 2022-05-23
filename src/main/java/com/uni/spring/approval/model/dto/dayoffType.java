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

public class dayoffType {
	
	private int doTypeNo; // 휴가타입번호 
	private String doTypeName; // 휴가이름

}
