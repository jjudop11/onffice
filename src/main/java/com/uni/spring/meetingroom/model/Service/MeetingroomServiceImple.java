package com.uni.spring.meetingroom.model.Service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingroom.model.dao.MeetingroomDao;
import com.uni.spring.meetingroom.model.dto.Meetingroom;
import com.uni.spring.meetingroom.model.dto.Reserveroom;

@Service
public class MeetingroomServiceImple implements MeetingroomService {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// @Autowired
	// private MemberDao memberDao;

	@Autowired
	private MeetingroomDao meetingroomDao;

	// 회의실 관리 권한이 부여된 유저 확인
	@Override
	public int selectRoomsetUser(String roomsetUserId) {

		int result = meetingroomDao.selectRoomsetUser(sqlsession, roomsetUserId);
		return result;
	}

	@Override
	public int insertMeetingroom(Meetingroom m) {

		int result = meetingroomDao.insertMeetingroom(sqlsession, m);
		return result;
	}

	@Override
	public int selectRoomListCount(int userCNo) {
		// TODO Auto-generated method stub
		return meetingroomDao.selectRoomListCount(sqlsession, userCNo);
	}

	@Override
	public ArrayList<Meetingroom> selectRoomList(PageInfo pi, int userCNo) {
		// TODO Auto-generated method stub
		return meetingroomDao.selectRoomList(sqlsession, pi, userCNo);
	}

	// 회의실 예약화면 -> 하단 회의실 현황
	@Override
	public ArrayList<Meetingroom> selectList(int userCNo) {
		// TODO Auto-generated method stub
		return meetingroomDao.selectList(sqlsession, userCNo);
	}

	/*
	 * @Override public int deleteMeetingroom(String roomNo) { // TODO
	 * Auto-generated method stub return
	 * meetingroomDao.deleteMeetingroom(sqlsession, roomNo); }
	 */

	@Override
	public int roomNoCheck(String roomNo) {
		// TODO Auto-generated method stub
		return meetingroomDao.roomNoCheck(sqlsession, roomNo);
	}

	@Override
	public int deleteRooms(String roomNo) {
		// TODO Auto-generated method stub
		return meetingroomDao.deleteRooms(sqlsession, roomNo);
	}

	@Override
	public String selectRoomNo(String selectRoom) {
		// TODO Auto-generated method stub
		return meetingroomDao.selectRoomNo(sqlsession, selectRoom);
	}

	//회의실 예약
	@Override
	public int reserveRoom(Reserveroom room) {
		// TODO Auto-generated method stub
		return meetingroomDao.reserveRoom(sqlsession, room);
	}

}
