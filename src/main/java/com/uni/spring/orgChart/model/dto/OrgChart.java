package com.uni.spring.orgChart.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrgChart {
	
	private String cName;
	private String mNo;
	private String mName;
	private String mEmail;
	private String mPhone;
	private int jNo;
	private String jName;
	private int dNo;
	private String dName;
	private String pName;
	private String aState;
	private int cNo;

}
