package com.uni.spring.meetingroom.model.Service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.meetingroom.model.dto.Meetingroom;

public interface MeetingroomService {

	int selectRoomsetUser(String roomsetUserId);

	//ArrayList<Meetingroom> selectList(PageInfo pi, int userCNo);

	int insertMeetingroom(Meetingroom m);

	int selectRoomListCount(int userCNo);

	ArrayList<Meetingroom> selectRoomList(PageInfo pi, int userCNo);

	ArrayList<Meetingroom> selectList(int userCNo);

	int deleteMeetingroom(String roomNo);

	int roomNoCheck(String roomNo);

	//
	int deleteRooms(int checkedRoomNo);

	
}
