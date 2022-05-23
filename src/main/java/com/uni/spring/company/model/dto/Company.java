package com.uni.spring.company.model.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Company {
	
	private int cNo;
	private String cName;
	private String cId;
	private String cPwd;
	private String cEmail;
	private String cRNumber;
}
