package com.uni.spring.notice.model;

import java.sql.Date;

public class notice {
	
	private int No_Num;
	private String No_Title;
	private String No_Write;
	private String No_Content;
	private String No_View;
	private int count;
	private Date No_Date;
	private String No_status;
	
	public int getNo_Num() {
		return No_Num;
	}
	public void setNo_Num(int no_Num) {
		No_Num = no_Num;
	}
	public String getNo_Title() {
		return No_Title;
	}
	public void setNo_Title(String no_Title) {
		No_Title = no_Title;
	}
	public String getNo_Write() {
		return No_Write;
	}
	public void setNo_Write(String no_Write) {
		No_Write = no_Write;
	}
	public String getNo_Content() {
		return No_Content;
	}
	public void setNo_Content(String no_Content) {
		No_Content = no_Content;
	}
	public String getNo_View() {
		return No_View;
	}
	public void setNo_View(String no_View) {
		No_View = no_View;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getNo_Date() {
		return No_Date;
	}
	public void setNo_Date(Date no_Date) {
		No_Date = no_Date;
	}
	public String getNo_status() {
		return No_status;
	}
	public void setNo_status(String no_status) {
		No_status = no_status;
	}
	
	@Override
	public String toString() {
		return "notice [No_Num=" + No_Num + ", No_Title=" + No_Title + ", No_Write=" + No_Write + ", No_Content="
				+ No_Content + ", No_View=" + No_View + ", count=" + count + ", No_Date=" + No_Date + ", No_status="
				+ No_status + "]";
	}
	

}
