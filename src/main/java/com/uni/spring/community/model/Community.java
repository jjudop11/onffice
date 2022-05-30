package com.uni.spring.community.model;

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
public class Community {
	
	private int ComNum;
	private String ComTitle;
	private String ComContent;
	private String ComWrite;
	private Date ComDate;
	private int ComView;
	private String ComStatus;

}
