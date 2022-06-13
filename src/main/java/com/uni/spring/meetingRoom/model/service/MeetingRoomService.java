package com.uni.spring.meetingRoom.model.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.meetingRoom.model.dto.ReserveRoom;

public interface MeetingRoomService {

	int selectRoomSetUser(String roomsetUserId);

	// ArrayList<Meetingroom> selectList(PageInfo pi, int userCNo);

	int insertMeetingRoom(MeetingRoom m);

	int selectRoomListCount(int userCNo);

	ArrayList<MeetingRoom> selectRoomList(PageInfo pi, int userCNo);

	ArrayList<MeetingRoom> selectList(int userCNo);

	// 회의실 번호 중복체크
	int roomNoCheck(String roomNo);

	// 회의실 하나 삭제
	// int deleteMeetingroom(String roomNo);

	// 회의실 삭제
	int deleteRooms(String roomNo);

	double selectStartKey(String startTime);

	double selectEndKey(String endTime);

	// 회의실 예약
	int reserveRoom(ReserveRoom room);

	// 회의실 예약시 roomNo 얻기
	String selectRoomNo(String selectRoom);

	// 회의실 예약시 이미 예약된 목록 얻기
	ArrayList<ReserveRoom> checkReservedRooms(String roomNo, String date);

	ArrayList<ReserveRoom> selectReservedRooms(int cNo, String date);


	ReserveRoom selectRoom(ReserveRoom roomInfo);

	String selectMName(String mNo);

	String selectMJobName(String mNo);

	String selectRoomName(String roomNo);

	int deleteReservation(String reservationNo);

	String selectReserveDate(String reservationNo);

	//예약 수정
	int updateReservation(ReserveRoom updateRoom);

	ReserveRoom selectreservedRoom(ReserveRoom r);


}
