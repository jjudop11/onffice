package com.uni.spring.meetingroom.model.Service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.meetingroom.model.dao.MeetingroomDao;

@Service
public class MeetingroomServiceImple implements MeetingroomService {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// @Autowired
	// private MemberDao memberDao;

	@Autowired
	private MeetingroomDao meetingroomDao;

	@Override
	public int selectRoomsetUser(String roomsetUserId) {

		int result = meetingroomDao.selectRoomsetUser(sqlsession, roomsetUserId);

		return result;
	}

}
