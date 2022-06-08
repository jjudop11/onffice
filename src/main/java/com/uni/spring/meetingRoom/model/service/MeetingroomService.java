package com.uni.spring.meetingroom.model.Service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingroom.model.dto.Meetingroom;
import com.uni.spring.meetingroom.model.dto.Reserveroom;

public interface MeetingroomService {

	int selectRoomsetUser(String roomsetUserId);

	// ArrayList<Meetingroom> selectList(PageInfo pi, int userCNo);

	int insertMeetingroom(Meetingroom m);

	int selectRoomListCount(int userCNo);

	ArrayList<Meetingroom> selectRoomList(PageInfo pi, int userCNo);

	ArrayList<Meetingroom> selectList(int userCNo);

	// 회의실 번호 중복체크
	int roomNoCheck(String roomNo);

	// 회의실 하나 삭제
	// int deleteMeetingroom(String roomNo);

	// 회의실 삭제
	int deleteRooms(String roomNo);

	double selectStartKey(String startTime);

	double selectEndKey(String endTime);

	// 회의실 예약
	int reserveRoom(Reserveroom room);

	// 회의실 예약시 roomNo 얻기
	String selectRoomNo(String selectRoom);

	// 회의실 예약시 이미 예약된 목록 얻기
	ArrayList<Reserveroom> checkReservedRooms(String roomNo, String date);

	ArrayList<Reserveroom> selectReservedRooms(int cNo, String date);

}
