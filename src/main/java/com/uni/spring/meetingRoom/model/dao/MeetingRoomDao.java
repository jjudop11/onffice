package com.uni.spring.meetingRoom.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.meetingRoom.model.dto.ReserveRoom;

@Repository
public class MeetingRoomDao {

	public int selectRoomSetUser(SqlSessionTemplate sqlsession, String roomsetUserId) {

		return sqlsession.selectOne("MeetingRoomMapper.selecRoomSetUser", roomsetUserId);
	}

	public ArrayList<MeetingRoom> seletcList(SqlSessionTemplate sqlsession, int userCNo) {

		return (ArrayList) sqlsession.selectList("MeetingRoomMapper.selectList", userCNo);
	}

	// 회의실 추가
	public int insertMeetingRoom(SqlSessionTemplate sqlsession, MeetingRoom m) {

		return sqlsession.insert("MeetingRoomMapper.insertMeetingRoom", m);
	}

	// 회의실번호 중복체크
	public int roomNoCheck(SqlSessionTemplate sqlsession, String roomNo) {

		return sqlsession.selectOne("MeetingRoomMapper.roomNoCheck", roomNo);
	}

	// 회의실 삭제
	public int deleteMeetingRoom(SqlSessionTemplate sqlsession, String roomNo) {

		return sqlsession.delete("MeetingRoomMapper.deleteMeetingRoom", roomNo);
	}

	// 페이징 처리용
	public int selectRoomListCount(SqlSessionTemplate sqlsession, int userCNo) {

		return sqlsession.selectOne("MeetingRoomMapper.selectRoomListCount", userCNo);
	}

	// 페이징 처리용
	public ArrayList<MeetingRoom> selectRoomList(SqlSessionTemplate sqlsession, PageInfo pi, int userCNo) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList) sqlsession.selectList("MeetingRoomMapper.selectRoomList", userCNo, rowBounds);
	}

	// 로그인유저 소속 회사의 총 회의실 목록
	public ArrayList<MeetingRoom> selectList(SqlSessionTemplate sqlsession, int userCNo) {

		return (ArrayList) sqlsession.selectList("MeetingRoomMapper.selectRoomList", userCNo);
	}

	public int deleteRooms(SqlSessionTemplate sqlsession, String roomNo) {
		// TODO Auto-generated method stub
		return sqlsession.delete("MeetingRoomMapper.deleteRooms", roomNo);
	}

	public String selectRoomNo(SqlSessionTemplate sqlsession, String selectRoom) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectRoomNo", selectRoom);
	}

	public int reserveRoom(SqlSessionTemplate sqlsession, ReserveRoom room) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MeetingRoomMapper.reserveRoom", room);
	}

	public double selectStartKey(SqlSessionTemplate sqlsession, String startTime) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectStartKey", startTime);
	}

	public double selectEndKey(SqlSessionTemplate sqlsession, String endTime) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectEndKey", endTime);
	}

	public ArrayList<ReserveRoom> selectReservedRooms(SqlSessionTemplate sqlsession, int cNo, String date) {
		
		//파라미터 두개 안 넘어감
		ReserveRoom room = new ReserveRoom();
		room.setcNo(cNo);
		room.setReserveDate(date);
	
		return (ArrayList) sqlsession.selectList("MeetingRoomMapper.selectReservedRooms", room);
	}

	public ArrayList<ReserveRoom> checkReservedRooms(SqlSessionTemplate sqlsession, String roomNo, String date) {
		
		ReserveRoom room = new ReserveRoom();
		room.setRoomNo(roomNo);
		room.setReserveDate(date);
		
		return (ArrayList) sqlsession.selectList("MeetingRoomMapper.checkReservedRooms", room);
	}

	//예약정보로 예약내역 select
	public ReserveRoom selectRoom(SqlSessionTemplate sqlsession, ReserveRoom roomInfo) {
		
		//날짜, 시작시간, 룸넘버 담아서 가져왔음
		return sqlsession.selectOne("MeetingRoomMapper.selectRoom", roomInfo);
	}

	public String selectMName(SqlSessionTemplate sqlsession, String mNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectMName", mNo);
	}

	public String selectMJobName(SqlSessionTemplate sqlsession, String mNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectMJobName", mNo);
	}

	public String selectRoomName(SqlSessionTemplate sqlsession, String roomNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectRoomName", roomNo);
	}

	public int deleteReservation(SqlSessionTemplate sqlsession, String reservationNo) {
		// TODO Auto-generated method stub
		return sqlsession.delete("MeetingRoomMapper.deleteReservation", reservationNo);
	}

	public String selectReserveDate(SqlSessionTemplate sqlsession, String reservationNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingRoomMapper.selectReserveDate", reservationNo);
	}

	public int updateReservation(SqlSessionTemplate sqlsession, ReserveRoom updateRoom) {
		// TODO Auto-generated method stub
		return sqlsession.update("MeetingRoomMapper.updateReservation", updateRoom);
	}

	public ReserveRoom selectreservedRoom(SqlSessionTemplate sqlsession, ReserveRoom r) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selectreservedRoom", r);
	}

	

}
