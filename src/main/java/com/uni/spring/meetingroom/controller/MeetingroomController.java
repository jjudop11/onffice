package com.uni.spring.meetingroom.controller;


import java.util.ArrayList;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.uni.spring.meetingroom.model.Service.MeetingroomService;
import com.uni.spring.meetingroom.model.dto.Meetingroom;
import com.uni.spring.member.model.dto.Member;

@Controller
public class MeetingroomController {
	
	@Autowired
	MeetingroomService meetingroomService;
	
	@RequestMapping("roomSetting.do")
	public String roomSetting(HttpSession session, Model model) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);
				
		String roomsetUserId = loginUser.getMId();     //로그인유저의 사번
		int userCNo = loginUser.getCNo();              //로그인유저의 회사번호
		System.out.println(userCNo);
		
		int result = meetingroomService.selectRoomsetUser(roomsetUserId);
		
		ArrayList<Meetingroom> roomList = meetingroomService.selectList(userCNo);
		System.out.println("회의실 목록 : " + roomList);
	
		model.addAttribute("loginUser", loginUser);    //로그인 회원정보 전달용
		model.addAttribute("roomList", roomList);      //회의실 목록 출력용
		
		if(result > 0) {
			
			//현재 로그인한 유저의 회사에 등록된 회의실 가져와서 뿌려줘야함
			//ArrayList<Meetingroom> list = meetingroomService.selectList(userCNo);
			//model.addAttribute("list", list);
			
			//model.addAttribute("roomList", roomList);
			return "meetingRoom/roomSetting";
			
		}else {		
			model.addAttribute("msg", "접근권한이 없습니다.");
			return "main"; 
		}
		 
	}
	
	@RequestMapping("saveRoom.do")
	public String insertMeetingroom(@ModelAttribute Meetingroom m,
									@RequestParam("addRoomNo") String addRoomNo, @RequestParam("addRoomName") String addRoomName,
									@RequestParam("addRoomCapa") int addRoomCapa, @RequestParam(value="addRoomNote", required=false) String addRoomNote, Model model, HttpSession session) {
		
		//Member loginUser = (Member)model.getAttribute("loginUser");
		//int userCNo = loginUser.getCNo();
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		
		m.setRoomNo(addRoomNo);
		m.setRoomName(addRoomName);
		m.setRoomCapa(addRoomCapa);
		m.setRoomNote(addRoomNote);
		m.setcNo(userCNo);
		
		System.out.println("m 출력 : " + m);
		
		int result = meetingroomService.insertMeetingroom(m);
		
		System.out.println("인서트 됐니?" + result);
		
		//새로 저장된 데이터도 포함해서 다시 뿌려줘야 함.
		
		if(result > 0) {
			model.addAttribute("msg", "회의실 변경에 성공하였습니다.");
			return "meetingRoom/roomSetting";
		}else {
			model.addAttribute("msg", "회의실 변경에 실패하였습니다.");
			return "main";
		}
		
		
	}
	
	/* @RequestMapping("meetingRoomList.do")
	public Map<String, Object> meetingRoomList(@ModelAttribute meetingRoom meetingRoom){
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("meetingRoomList", meetingRoomService.getStoreList(store));
		return returnMap;
	


	}*/
	
	/* @RequestMapping("meetingRoomList.do")
	public String selectmeetingRoom(int bno){
		
		//테스트용 임의설정
		
		
		
	} */

}
