package com.uni.spring.meetingroom.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.GsonBuilder;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.meetingroom.model.Service.MeetingroomService;
import com.uni.spring.meetingroom.model.dto.Meetingroom;
import com.uni.spring.member.model.dto.Member;

@Controller
public class MeetingroomController {

	@Autowired
	MeetingroomService meetingroomService;

	// 회의실 예약 진입
	@RequestMapping("roomReservation.do")
	public String roomReservation(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);
		
		int userCNo = loginUser.getCNo();
		System.out.println("유저의 회사번호 : " + userCNo);
		
		//예약 모달창에서 보여질 예약자명
		String userName = loginUser.getMName();
		String userJob = loginUser.getJName();
		model.addAttribute("userName", userName);
		model.addAttribute("userJob", userJob);

		//하단 회의실 리스트
		ArrayList<Meetingroom> roomList = meetingroomService.selectList(userCNo);
		model.addAttribute("roomList", roomList);

		//페이징 : 추후 수정
		int listCount = meetingroomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		return "meetingRoom/roomReservation";

	}

	// 회의실 관리 진입
	@RequestMapping("roomSetting.do")
	public String roomSetting(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);

		String roomsetUserId = loginUser.getMId(); // 로그인유저의 사번
		int userCNo = loginUser.getCNo(); // 로그인유저의 회사번호
		System.out.println("유저의 회사번호 : " + userCNo);

		int result = meetingroomService.selectRoomsetUser(roomsetUserId);

		// model.addAttribute("loginUser", loginUser); // 로그인 회원정보 전달용

		// 페이징 처리
		int listCount = meetingroomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		ArrayList<Meetingroom> roomList = meetingroomService.selectRoomList(pi, userCNo);
		System.out.println("회의실 목록 : " + roomList);
		model.addAttribute("roomList", roomList); // 회의실 목록 출력용

		if (result > 0) {

			// 현재 로그인한 유저의 회사에 등록된 회의실 가져와서 뿌려줘야함
			// ArrayList<Meetingroom> list = meetingroomService.selectList(userCNo);
			// model.addAttribute("list", list);

			// model.addAttribute("roomList", roomList);
			return "meetingRoom/roomSetting";

		} else {
			model.addAttribute("msg", "접근권한이 없습니다.");
			return "main";
		}

	}

	//회의실 예약메뉴에서 설정메뉴로 진입
	@RequestMapping("reserve-roomSetting.do")
	public String reserve_roomSetting(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);

		String roomsetUserId = loginUser.getMId(); // 로그인유저의 사번
		int userCNo = loginUser.getCNo(); // 로그인유저의 회사번호
		System.out.println("유저의 회사번호 : " + userCNo);

		int result = meetingroomService.selectRoomsetUser(roomsetUserId);

		// model.addAttribute("loginUser", loginUser); // 로그인 회원정보 전달용

		// 페이징 처리 : 추후 수정
		int listCount = meetingroomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		ArrayList<Meetingroom> roomList = meetingroomService.selectRoomList(pi, userCNo);
		System.out.println("회의실 목록 : " + roomList);
		model.addAttribute("roomList", roomList); // 회의실 목록 출력용

		if (result > 0) {

			// 현재 로그인한 유저의 회사에 등록된 회의실 가져와서 뿌려줘야함
			// ArrayList<Meetingroom> list = meetingroomService.selectList(userCNo);
			// model.addAttribute("list", list);

			// model.addAttribute("roomList", roomList);
			return "meetingRoom/roomSetting";

		} else {
			model.addAttribute("msg", "접근권한이 없습니다.");
			return "meetingRoom/roomReservation";
		}

	}

	// 회의실번호 중복체크
	@RequestMapping("roomNoCheck.do")
	@ResponseBody
	public String roomNoCheck(@RequestParam("roomNo") String roomNo) {

		int count = meetingroomService.roomNoCheck(roomNo);
		return String.valueOf(count);

	}

	// 회의실 추가
	@RequestMapping("insertRoom.do")
	@ResponseBody // json 사용 용도
	public String insertMeetingroom(@ModelAttribute Meetingroom m, @RequestParam("roomNo") String roomNo,
			@RequestParam("roomName") String roomName, @RequestParam("roomCapa") int roomCapa,
			@RequestParam(value = "roomNote", required = false) String roomNote, Model model, HttpSession session) {

		// Member loginUser = (Member)model.getAttribute("loginUser");
		// int userCNo = loginUser.getCNo();

		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();

		m.setRoomNo(roomNo);
		m.setRoomName(roomName);
		m.setRoomCapa(roomCapa);
		m.setRoomNote(roomNote);
		m.setcNo(userCNo);

		System.out.println("추가할 회의실 : " + m);

		int result = meetingroomService.insertMeetingroom(m);

		System.out.println("회의실 추가 완료 : " + result);

		// 새로 추가한 회의실 정보만 제이슨형식으로 넘기기
		return new GsonBuilder().create().toJson(m);

	}

	// 회의실 한개 삭제
	/*
	 * @RequestMapping("deleteRoom.do")
	 * 
	 * @ResponseBody public String deleteMeetingroom(HttpSession session, Model
	 * model, @RequestParam("roomNo") String roomNo) {
	 * 
	 * //선택된 회의실 삭제하고 int result = meetingroomService.deleteMeetingroom(roomNo);
	 * System.out.println("회의실 삭제 완료 : " + result);
	 * 
	 * 
	 * //로그인 유저의 회사번호로 현재 회의실 리스트 다시 불러오기 Member loginUser = (Member)
	 * session.getAttribute("loginUser"); System.out.println("로그인유저 : " +
	 * loginUser);
	 * 
	 * int userCNo = loginUser.getCNo(); System.out.println(userCNo);
	 * 
	 * ArrayList<Meetingroom> roomList = meetingroomService.selectList(userCNo);
	 * model.addAttribute("roomList", roomList);
	 * 
	 * return "meetingRoom/roomSetting"; }
	 */

	// 회의실 여러개 삭제
	@RequestMapping("deleteRooms.do")
	@ResponseBody
	public String deleteRooms(@RequestParam(value = "checkedArr[]") List<String> checkedArr, HttpSession session,
			Model model) {

		for (int i = 0; i < checkedArr.size(); i++) {

			String roomNo = checkedArr.get(i);

			int result = meetingroomService.deleteRooms(roomNo);
			System.out.println("삭제된 행 : " + result);
		}

		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		ArrayList<Meetingroom> roomList = meetingroomService.selectList(userCNo);

		return new GsonBuilder().create().toJson(roomList);

	}

	@RequestMapping("onlineMeetingroom.do")
	public String onlineMeetingroom() {
		
		return "meetingRoom/onlineMeetingroom";
	}
}
