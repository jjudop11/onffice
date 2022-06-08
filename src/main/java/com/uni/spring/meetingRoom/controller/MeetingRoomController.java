package com.uni.spring.meetingRoom.controller;

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
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.meetingRoom.model.dto.ReserveRoom;
import com.uni.spring.meetingRoom.model.service.MeetingRoomService;
import com.uni.spring.member.model.dto.Member;

@Controller
public class MeetingRoomController {

	@Autowired
	MeetingRoomService meetingRoomService;

	// 회의실 예약 진입
	@RequestMapping("roomReservation.do")
	public String roomReservation(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);

		int userCNo = loginUser.getCNo();
		System.out.println("유저의 회사번호 : " + userCNo);

		// 예약 모달창에서 보여질 예약자명
		String userName = loginUser.getMName();
		String userJob = loginUser.getJName();
		model.addAttribute("userName", userName);
		model.addAttribute("userJob", userJob);

		// 하단 회의실 리스트
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(userCNo);
		model.addAttribute("roomList", roomList);

		// 페이징 : 추후 수정
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		return "meetingRoom/roomReservation";

	}

	// 회의실 예약시 예약시간 검사 //roomNo, date, cNo, startTime, endTime
	private boolean isValidTime(String roomNo, String date, String startTime, String endTime) {
		// 테스트용 코드 : 10시와 12시에 예약되었다고 가정하고 테스트
		// 실사용시 예약목록 select 해오면 됨
		/*
		 * Reserveroom testRoom = new Reserveroom(); testRoom.setStartTime("10:00");
		 * testRoom.setEndTime("12:00");
		 * 
		 * ArrayList<Reserveroom> reservedRooms = new ArrayList<Reserveroom>();
		 * reservedRooms.add(testRoom);
		 */
		//

		// 해당 날짜의 해당 회의실에 예약된 내역이 없어야 예약 가능
		ArrayList<ReserveRoom> reservedRooms = meetingRoomService.checkReservedRooms(roomNo, date);
		System.out.println("reservedRooms : " + reservedRooms);

		// 예약 모달에서 입력한 시작시간, 종료시간(String)을 int형으로 변환 //하단 getTime 메소드
		int startTimeCal = getTime(startTime);
		int endTimeCal = getTime(endTime);

		// 위에서 룸넘버랑 날짜로 구해온 예약 목록 foreach로 돌리면서 예약된 시간이랑 예약할 시간이랑 비교
		for (ReserveRoom r : reservedRooms) {
			
			int rStartTime = getTime(r.getStartTime());
			int rEndTime = getTime(r.getEndTime());

			System.out.println("startTimeCal:" + startTimeCal + ", endTimeCal:" + endTimeCal + 
							   ", rStartCal:" + rStartTime + ", rEndCal:" + rEndTime);

			// 예약된 시작시간 <= 예약할 시작시간 && 예약된 종료시간 > 예약할 시작시간 ||
			// 예약된 시작시간 < 예약할 종료시간 && 예약된 종료시간 >= 예약할 종료시간이면
			
			// 새로 예약할 시간의 사이에 이미 예약된 시간이 포함되어 있어도 안 됨 
			 if (rStartTime <= startTimeCal && rEndTime > startTimeCal || 
				rStartTime < endTimeCal && rEndTime >= endTimeCal ||
				startTimeCal < rStartTime && startTimeCal < rEndTime &&
				endTimeCal > rStartTime && endTimeCal > rEndTime) {
				
				return false;
			} 
		
						
		}
        return true;
	}

	// 시간 변환
	private static int getTime(String timeString) {
		
		String[] times = timeString.split(":"); 

		int t1 = Integer.parseInt(times[0]);
		int t2 = Integer.parseInt(times[1]);

		return t1 * 60 + t2;
	}

	private static int getCellTime(String timeString) {
		
		
		return getTime(timeString) / 30 - 14;
	}

	// 회의실 예약
	@RequestMapping("reserveRoom.do")
	@ResponseBody
	public int reserveRoom(@ModelAttribute ReserveRoom room, @RequestParam("date") String date,
			@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime,
			@RequestParam("selectRoom") String selectRoom, HttpSession session) {

		// 예약번호(시퀀스), 회의실번호, 예약일, 시작시간, 종료시간, 예약자사원번호, 회사번호

		// 회의실명을 넘기고 있으므로 해당값으로 회의실 번호를 찾아와야 함
		String roomNo = meetingRoomService.selectRoomNo(selectRoom);
		// 예약자명을 넘기고 있으므로 해당값으로 사원번호를 찾아와야 함 (예약자명은 현재 로그인한 유저로 고정됨)
		Member loginUser = (Member) session.getAttribute("loginUser");
		String mNo = loginUser.getMNo();
		// 현재 로그인 유저의 회사번호를 가져와야 함
		int cNo = loginUser.getCNo();

		// 예약시에 회의실번호, 날짜, 회사번호(예약된목록 불러오기용), 시작시간, 종료시간 넘겨서 검사해야함
		if (!isValidTime(roomNo, date, startTime, endTime)) {

			//throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이미 예약된 시간입니다.");
			//return "meetingroom/roomReservation";
			return -1;
			
		} else {
			room.setRoomNo(roomNo);
			room.setReserveDate(date);
			room.setStartTime(startTime);
			room.setEndTime(endTime);
			room.setmNo(mNo);
			room.setCNo(cNo);
			
			//날짜, 시간 체크 후 위배사항 없으면 예약 실행
			int result = meetingRoomService.reserveRoom(room);
	
			return result;
		}
	
		// if (startTime endTime ....)
		// {
		// return;
		// }
		// meetingroomService.reserveRoom(room);

		// 현재 화면에 뿌려줘야 함
		// return new GsonBuilder().create().toJson(room);
	}

	// 예약일정 화면에 뿌리기
	@RequestMapping("reservedRoomList.do")
	@ResponseBody
	public String reserveRoomList(@RequestParam("date") String date, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		int cNo = loginUser.getCNo();

		//회사번호, 날짜로 예약목록 뽑기
		ArrayList<ReserveRoom> rooms = meetingRoomService.selectReservedRooms(cNo, date);
		

		JsonObject obj = new JsonObject();
		JsonArray jsonRooms = new JsonArray();
		
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(cNo);

		// java 10부터 var 도입
		// 변수 선언시 타입 생략가능, 컴파일러가 타입 추론. 지역변수에만 사용.
		for (var room : roomList) {
			
			JsonObject roomObj = new JsonObject();			
			var reservedRoomArray = new JsonArray();

			//회의실 목록 foreach 돌리면서 roomObj에 name값 담고
			roomObj.addProperty("name", room.getRoomName());

			//예약목록 돌리면서
			for (var reservedRoom : rooms) {
				// 예약된 회의실명이랑 등록되어있는 회의실명이랑 같으면 
				if (reservedRoom.getRoomNo().equals(room.getRoomNo())) {
					System.out.println(reservedRoom.getRoomNo() + " : " + room.getRoomNo());

					var innerArr = new JsonArray();

					//getCellTime으로 시간값 얻고		
					int startTime = getCellTime(reservedRoom.getStartTime());
					int endTime = getCellTime(reservedRoom.getEndTime());

					//배열에 담고
					innerArr.add(startTime);
					innerArr.add(endTime);

					//시간 담긴 배열을 또 배열에 담아
					reservedRoomArray.add(innerArr);
					System.out.println(reservedRoomArray.toString());
				}
			}

			//roomObj에 회의실명이랑 해당 회의실에 예약된 시간들이 담김
			roomObj.add("times", reservedRoomArray);

			jsonRooms.add(roomObj);
		}

		obj.add("rooms", jsonRooms);

		//var str
		String str = obj.toString();

		System.out.println(str);
		
		return str;
	}

	// 회의실 예약 시간 선택기 //이것도 getTime 메소드로 바꿔보기
	@RequestMapping("timeCheck.do")
	@ResponseBody
	public double timeCheck(@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime) {

		System.out.println("시작시간 : " + startTime);
		System.out.println("종료시간 : " + endTime);

		// 받아온 시간으로 KEY값 구해와서 계산
		double startKey = meetingRoomService.selectStartKey(startTime);
		double endKey = meetingRoomService.selectEndKey(endTime);

		System.out.println("시작키 : " + startKey);
		System.out.println("종료키 : " + endKey);

		double result = endKey - startKey;

		return result;

	}
	
	// 예약 상세 진입
	@RequestMapping("reservationDetails.do")
	public String reservationDetails() {
		
		return "meetingRoom/reservationDetails";
	}

	// 회의실 관리 진입
	@RequestMapping("roomSetting.do")
	public String roomSetting(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);

		String roomsetUserId = loginUser.getMId(); 
		int userCNo = loginUser.getCNo(); 
		System.out.println("유저의 회사번호 : " + userCNo);

		int result = meetingRoomService.selectRoomSetUser(roomsetUserId);

		// 페이징 처리
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		ArrayList<MeetingRoom> roomList = meetingRoomService.selectRoomList(pi, userCNo);
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

	// 회의실 예약메뉴에서 설정메뉴로 진입
	@RequestMapping("reserve-roomSetting.do")
	public String reserve_roomSetting(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		System.out.println("로그인유저 : " + loginUser);

		String roomsetUserId = loginUser.getMId(); // 로그인유저의 사번
		int userCNo = loginUser.getCNo(); // 로그인유저의 회사번호
		System.out.println("유저의 회사번호 : " + userCNo);

		int result = meetingRoomService.selectRoomSetUser(roomsetUserId);

		// model.addAttribute("loginUser", loginUser); // 로그인 회원정보 전달용

		// 페이징 처리 : 추후 수정
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		ArrayList<MeetingRoom> roomList = meetingRoomService.selectRoomList(pi, userCNo);
		System.out.println("회의실 목록 : " + roomList);
		model.addAttribute("roomList", roomList); // 회의실 목록 출력용

		if (result > 0) {
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

		int count = meetingRoomService.roomNoCheck(roomNo);
		return String.valueOf(count);

	}

	// 회의실 추가
	@RequestMapping("insertRoom.do")
	@ResponseBody 
	public String insertMeetingroom(@ModelAttribute MeetingRoom m, @RequestParam("roomNo") String roomNo,
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

		int result = meetingRoomService.insertMeetingRoom(m);

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

			int result = meetingRoomService.deleteRooms(roomNo);
			System.out.println("삭제된 행 : " + result);
		}

		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(userCNo);

		return new GsonBuilder().create().toJson(roomList);

	}

	@RequestMapping("onlineMeetingroom.do")
	public String onlineMeetingroom() {

		return "meetingRoom/onlineMeetingroom";
	}
}
