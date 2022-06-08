package com.uni.spring.meetingroom.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingroom.model.dto.Meetingroom;
import com.uni.spring.meetingroom.model.dto.Reserveroom;

@Repository
public class MeetingroomDao {

	public int selectRoomsetUser(SqlSessionTemplate sqlsession, String roomsetUserId) {

		return sqlsession.selectOne("MeetingroomMapper.selecRoomsettUser", roomsetUserId);
	}

	public ArrayList<Meetingroom> seletcList(SqlSessionTemplate sqlsession, int userCNo) {

		return (ArrayList) sqlsession.selectList("MeetingroomMapper.selectList", userCNo);
	}

	// 회의실 추가
	public int insertMeetingroom(SqlSessionTemplate sqlsession, Meetingroom m) {

		return sqlsession.insert("MeetingroomMapper.insertMeetingroom", m);
	}

	// 회의실번호 중복체크
	public int roomNoCheck(SqlSessionTemplate sqlsession, String roomNo) {

		return sqlsession.selectOne("MeetingroomMapper.roomNoCheck", roomNo);
	}

	// 회의실 삭제
	public int deleteMeetingroom(SqlSessionTemplate sqlsession, String roomNo) {

		return sqlsession.delete("MeetingroomMapper.deleteMeetingroom", roomNo);
	}

	// 페이징 처리용
	public int selectRoomListCount(SqlSessionTemplate sqlsession, int userCNo) {

		return sqlsession.selectOne("MeetingroomMapper.selectRoomListCount", userCNo);
	}

	// 페이징 처리용
	public ArrayList<Meetingroom> selectRoomList(SqlSessionTemplate sqlsession, PageInfo pi, int userCNo) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList) sqlsession.selectList("MeetingroomMapper.selectRoomList", userCNo, rowBounds);
	}

	// 로그인유저 소속 회사의 총 회의실 목록
	public ArrayList<Meetingroom> selectList(SqlSessionTemplate sqlsession, int userCNo) {

		return (ArrayList) sqlsession.selectList("MeetingroomMapper.selectRoomList", userCNo);
	}

	public int deleteRooms(SqlSessionTemplate sqlsession, String roomNo) {
		// TODO Auto-generated method stub
		return sqlsession.delete("MeetingroomMapper.deleteRooms", roomNo);
	}

	public String selectRoomNo(SqlSessionTemplate sqlsession, String selectRoom) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selectRoomNo", selectRoom);
	}

	public int reserveRoom(SqlSessionTemplate sqlsession, Reserveroom room) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MeetingroomMapper.reserveRoom", room);
	}

	public double selectStartKey(SqlSessionTemplate sqlsession, String startTime) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selectStartKey", startTime);
	}

	public double selectEndKey(SqlSessionTemplate sqlsession, String endTime) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selectEndKey", endTime);
	}

	public ArrayList<Reserveroom> selectReservedRooms(SqlSessionTemplate sqlsession, int cNo, String date) {
		
		Reserveroom room = new Reserveroom();
		room.setCNo(cNo);
		room.setReserveDate(date);
	
		return (ArrayList) sqlsession.selectList("MeetingroomMapper.selectReservedRooms", room);
	}

	public ArrayList<Reserveroom> checkReservedRooms(SqlSessionTemplate sqlsession, String roomNo, String date) {
		
		//selectList시 파라미터 두개는 안 넘어감 //체크
		Reserveroom room = new Reserveroom();
		room.setRoomNo(roomNo);
		room.setReserveDate(date);
		
		return (ArrayList) sqlsession.selectList("MeetingroomMapper.checkReservedRooms", room);
	}

	

}
