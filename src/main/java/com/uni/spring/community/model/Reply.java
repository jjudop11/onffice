package com.uni.spring.community.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Reply {
	private int ComReNum;
	private String ComReContent;
	private int ComPreNum;
	private String ComReWriter;
	//private Date createDate;
	private Timestamp ComReDate;
	private String ComRe_Status;
}
