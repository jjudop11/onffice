package com.uni.spring.common;

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
public class SearchCondition extends PageInfo {

	private String keyword;
	private String condition;
	
	private String title;
	private String content;
	private String titleAndContent;
	
}
