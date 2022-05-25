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

public class formAtt {
	
	private int apNo; // 전자결재번호 
	private String originName; // 파일원본명
	private String changeName; // 파일수정명 
	private String filePath; // 저장폴더경로 
	private String status; // 삭제여부 
	private int foNo; // 서식번호 
	
	public int getApNo() {
		return apNo;
	}
	public void setApNo(int apNo) {
		this.apNo = apNo;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getChangeName() {
		return changeName;
	}
	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getFoNo() {
		return foNo;
	}
	public void setFoNo(int foNo) {
		this.foNo = foNo;
	}

}
