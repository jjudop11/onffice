package com.uni.spring.meetingroom.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MeetingroomDao {

	public int selectRoomsetUser(SqlSessionTemplate sqlsession, String roomsetUserId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MeetingroomMapper.selecRoomsettUser", roomsetUserId);
	}

}
