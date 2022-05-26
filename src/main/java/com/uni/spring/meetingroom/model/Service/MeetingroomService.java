package com.uni.spring.meetingroom.model.Service;

import java.util.ArrayList;

import com.uni.spring.meetingroom.model.dto.Meetingroom;

public interface MeetingroomService {

	int selectRoomsetUser(String roomsetUserId);

	ArrayList<Meetingroom> selectList(int userCNo);

	int insertMeetingroom(Meetingroom m);

	
}
