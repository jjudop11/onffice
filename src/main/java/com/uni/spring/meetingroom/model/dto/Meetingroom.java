package com.uni.spring.meetingroom.model.dto;

public class Meetingroom {
	
	private String roomNo;     //회의실번호
	private String roomName;   //회의실이름
	private int roomCapa;      //수용인원
	private String roomNote;   //비고
	private int cNo;           //회사번호
	
	public String getRoomNo() {
		return roomNo;
	}
	public void setRoomNo(String roomNo) {
		this.roomNo = roomNo;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public int getRoomCapa() {
		return roomCapa;
	}
	public void setRoomCapa(int roomCapa) {
		this.roomCapa = roomCapa;
	}
	public String getRoomNote() {
		return roomNote;
	}
	public void setRoomNote(String roomNote) {
		this.roomNote = roomNote;
	}
	public int getcNo() {
		return cNo;
	}
	public void setcNo(int cNo) {
		this.cNo = cNo;
	}
	@Override
	public String toString() {
		return "Meetingroom [roomNo=" + roomNo + ", roomName=" + roomName + ", roomCapa=" + roomCapa + ", roomNote="
				+ roomNote + ", cNo=" + cNo + "]";
	}
	
	
	

}
