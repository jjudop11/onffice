package com.uni.spring.car.model.dto;

public class ReserveCar {
	
	private int reserveNo;
	private int reseveCarNo;
	private String reserveMNo;
	private String useDate;
	private String useNote;
	
	public ReserveCar() {
		// TODO Auto-generated constructor stub
	}

	public int getReserveNo() {
		return reserveNo;
	}

	public void setReserveNo(int reserveNo) {
		this.reserveNo = reserveNo;
	}

	public int getReseveCarNo() {
		return reseveCarNo;
	}

	public void setReseveCarNo(int reseveCarNo) {
		this.reseveCarNo = reseveCarNo;
	}

	public String getReserveMNo() {
		return reserveMNo;
	}

	public void setReserveMNo(String reserveMNo) {
		this.reserveMNo = reserveMNo;
	}

	public String getUseDate() {
		return useDate;
	}

	public void setUseDate(String useDate) {
		this.useDate = useDate;
	}

	public String getUseNote() {
		return useNote;
	}

	public void setUseNote(String useNote) {
		this.useNote = useNote;
	}
	
	
}
