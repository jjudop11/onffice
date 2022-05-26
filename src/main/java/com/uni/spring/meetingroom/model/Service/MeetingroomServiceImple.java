package com.uni.spring.meetingroom.model.Service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.meetingroom.model.dao.MeetingroomDao;
import com.uni.spring.meetingroom.model.dto.Meetingroom;

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

	@Override
	public ArrayList<Meetingroom> selectList(int userCNo) {
		
		return meetingroomDao.seletcList(sqlsession, userCNo);
	}

	@Override
	public int insertMeetingroom(Meetingroom m) {
		
		int result = meetingroomDao.insertMeetingroom(sqlsession, m);
		
		return result;
	}

}
