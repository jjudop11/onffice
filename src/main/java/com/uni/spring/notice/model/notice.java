package com.uni.spring.notice.model;

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
public class notice {
	
	private int No_Num;
	private String No_Title;
	private String No_Content;
	private String No_Write;
	private Date No_Date;
	private String No_Important;
	private String No_status;
	
	private String No_WirterName;
}
