package com.uni.spring.meetingRoom.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingRoom.model.dao.MeetingRoomDao;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.meetingRoom.model.dto.ReserveRoom;

@Service
public class MeetingRoomServiceImple implements MeetingRoomService {

	@Autowired
	private SqlSessionTemplate sqlsession;

	@Autowired
	private MeetingRoomDao meetingRoomDao;

	// 회의실 관리 권한이 부여된 유저 확인
	@Override
	public int selectRoomSetUser(String roomsetUserId) {

		int result = meetingRoomDao.selectRoomSetUser(sqlsession, roomsetUserId);
		return result;
	}

	@Override
	public int insertMeetingRoom(MeetingRoom m) {

		int result = meetingRoomDao.insertMeetingRoom(sqlsession, m);
		return result;
	}

	@Override
	public int selectRoomListCount(int userCNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectRoomListCount(sqlsession, userCNo);
	}

	@Override
	public ArrayList<MeetingRoom> selectRoomList(PageInfo pi, int userCNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectRoomList(sqlsession, pi, userCNo);
	}

	// 회의실 예약화면 -> 하단 회의실 현황
	@Override
	public ArrayList<MeetingRoom> selectList(int userCNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectList(sqlsession, userCNo);
	}

	/*
	 * @Override public int deleteMeetingroom(String roomNo) { 
	 * meetingroomDao.deleteMeetingroom(sqlsession, roomNo); }
	 */

	@Override
	public int roomNoCheck(String roomNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.roomNoCheck(sqlsession, roomNo);
	}

	@Override
	public int deleteRooms(String roomNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.deleteRooms(sqlsession, roomNo);
	}

	@Override
	public String selectRoomNo(String selectRoom) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectRoomNo(sqlsession, selectRoom);
	}

	//회의실 예약
	@Override
	public int reserveRoom(ReserveRoom room) {
		// TODO Auto-generated method stub
		return meetingRoomDao.reserveRoom(sqlsession, room);
	}

	@Override
	public double selectStartKey(String startTime) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectStartKey(sqlsession, startTime);
	}

	@Override
	public double selectEndKey(String endTime) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectEndKey(sqlsession, endTime);
	}

	@Override
	public ArrayList<ReserveRoom> selectReservedRooms(int cNo, String date){
		return meetingRoomDao.selectReservedRooms(sqlsession, cNo, date);
	}

	@Override
	public ArrayList<ReserveRoom> checkReservedRooms(String roomNo, String date) {
		// TODO Auto-generated method stub
		return meetingRoomDao.checkReservedRooms(sqlsession, roomNo, date);
	}

	@Override
	public ReserveRoom selectRoom(ReserveRoom roomInfo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectRoom(sqlsession, roomInfo);
	}

	@Override
	public String selectMName(String mNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectMName(sqlsession, mNo);
	}

	@Override
	public String selectMJobName(String mNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectMJobName(sqlsession, mNo);
	}

	@Override
	public String selectRoomName(String roomNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectRoomName(sqlsession, roomNo);
	}

	@Override
	public int deleteReservation(String reservationNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.deleteReservation(sqlsession, reservationNo);
	}

	@Override
	public String selectReserveDate(String reservationNo) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectReserveDate(sqlsession, reservationNo);
	}

	@Override
	public int updateReservation(ReserveRoom updateRoom) {
		// TODO Auto-generated method stub
		return meetingRoomDao.updateReservation(sqlsession, updateRoom);
	}




}
