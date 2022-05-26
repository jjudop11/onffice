package com.uni.spring.meetingroom.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingroom.model.dto.Meetingroom;

@Repository
public class MeetingroomDao {

	public int selectRoomsetUser(SqlSessionTemplate sqlsession, String roomsetUserId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selecRoomsettUser", roomsetUserId);
	}

	public ArrayList<Meetingroom> seletcList(SqlSessionTemplate sqlsession, int userCNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("MeetingroomMapper.selectList", userCNo);
	}

	public int insertMeetingroom(SqlSessionTemplate sqlsession, Meetingroom m) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MeetingroomMapper.insertMeetingroom", m);
	}

	public int selectRoomListCount(SqlSessionTemplate sqlsession, int userCNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selectRoomListCount", userCNo);
	}

	public ArrayList<Meetingroom> selectRoomList(SqlSessionTemplate sqlsession, PageInfo pi, int userCNo) {
		// TODO Auto-generated method stub
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("MeetingroomMapper.selectRoomList", userCNo, rowBounds);
	}

	public ArrayList<Meetingroom> selectList(SqlSessionTemplate sqlsession, int userCNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("MeetingroomMapper.selectRoomList", userCNo);
	}

}
