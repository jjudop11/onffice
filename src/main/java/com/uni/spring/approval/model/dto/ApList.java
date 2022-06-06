package com.uni.spring.approval.model.dto;

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

public class ApList {
	
	private int apNo;
	private int foNo;
	private String doTitle;
	private String doDate;
	
	private String mNo;
	private int cNo;
	private String apStatus;

}
