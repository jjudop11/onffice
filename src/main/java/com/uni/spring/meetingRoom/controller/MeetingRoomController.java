package com.uni.spring.meetingRoom.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MeetingRoomController {
	
	@RequestMapping("roomSetting.do")
	public String roomSetting() {
		return "meetingRoom/roomSetting";
	}

}
