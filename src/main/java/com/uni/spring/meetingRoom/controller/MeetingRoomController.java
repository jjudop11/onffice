package com.uni.spring.meetingRoom.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

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
@SessionAttributes("loginUser")
public class MeetingRoomController {

	@Autowired
	MeetingRoomService meetingRoomService;

	// 회의실 예약 메뉴 진입
	@RequestMapping("roomReservingForm.do")
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

		// 페이지 들어왔을 때 오늘날짜 예약내역 보여주기 //체크
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDate.format(date);
		model.addAttribute("today", today);

		return "meetingRoom/roomReservation";

	}

	// 예약 모달에서 시간 선택시 사용
	@RequestMapping("timeCheck.do")
	@ResponseBody
	public double timeCheck(@RequestParam("startTime") String startTimeString,
			@RequestParam("endTime") String endTimeString) {

		/*
		 * System.out.println("시작시간 : " + startTime); System.out.println("종료시간 : " +
		 * endTime);
		 * 
		 * // 받아온 시간으로 KEY값 구해와서 계산 double startKey =
		 * meetingRoomService.selectStartKey(startTime); double endKey =
		 * meetingRoomService.selectEndKey(endTime);
		 * 
		 * System.out.println("시작키 : " + startKey); System.out.println("종료키 : " +
		 * endKey);
		 * 
		 * double result = endKey - startKey;
		 * 
		 * return result;
		 */

		int startTime = getTime(startTimeString);
		int endTime = getTime(endTimeString);

		int result = endTime - startTime;

		return result;

	}

	// 회의실 예약시 예약시간 검사 //roomNo, date, startTime, endTime
	private boolean isValidTime(String roomNo, String date, String startTime, String endTime) {

		// 테스트용 코드 : 10시와 12시에 예약되었다고 가정하고 테스트
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

			System.out.println("startTimeCal:" + startTimeCal + ", endTimeCal:" + endTimeCal + ", rStartCal:"
					+ rStartTime + ", rEndCal:" + rEndTime);

			// 예약된 시작시간 <= 예약할 시작시간 && 예약된 종료시간 > 예약할 시작시간 ||
			// 예약된 시작시간 < 예약할 종료시간 && 예약된 종료시간 >= 예약할 종료시간이면

			// 새로 예약할 시간의 사이에 이미 예약된 시간이 포함되어 있어도 안 됨
			if (rStartTime <= startTimeCal && rEndTime > startTimeCal
					|| rStartTime < endTimeCal && rEndTime >= endTimeCal || startTimeCal < rStartTime
							&& startTimeCal < rEndTime && endTimeCal > rStartTime && endTimeCal > rEndTime) {

				return false;
			}

		}
		return true;
	}

	// 시간변환
	private static int getTime(String timeString) {

		String[] times = timeString.split(":");

		int t1 = Integer.parseInt(times[0]);
		int t2 = Integer.parseInt(times[1]);

		return t1 * 60 + t2;
	}

	private static int getCellTime(String timeString) {

		// 10:00
		// 600 -> 20
		// (30분 * 14) => 7시간 뺌
		// 420
		// 600 - 420 = 180 (3시간)

		return getTime(timeString) / 30 - 14;
	}

	// 회의실 예약
	@RequestMapping("reserveRoom.do")
	@ResponseBody
	public int reserveRoom(@ModelAttribute ReserveRoom room, @RequestParam("date") String date,
			@RequestParam("startTime") String startTime, @RequestParam("endTime") String endTime,
			@RequestParam("selectRoom") String selectRoom, @RequestParam("title") String title, HttpSession session) {

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

			// throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이미 예약된 시간입니다.");
			// return "meetingroom/roomReservation";
			return -1;

		} else {
			room.setRoomNo(roomNo);
			room.setReserveDate(date);
			room.setStartTime(startTime);
			room.setEndTime(endTime);
			room.setReserveTitle(title);
			room.setmNo(mNo);
			room.setcNo(cNo);

			// 날짜, 시간 체크 후 위배사항 없으면 예약 실행
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



		System.out.println("===================" + date);

		Member loginUser = (Member) session.getAttribute("loginUser");
		int cNo = loginUser.getCNo();

		// 회사번호, 날짜로 예약목록 뽑기
		ArrayList<ReserveRoom> rooms = meetingRoomService.selectReservedRooms(cNo, date);

		JsonObject obj = new JsonObject();
		JsonArray jsonRooms = new JsonArray();

		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(cNo);

		// java 10부터 var 도입
		// 변수 선언시 타입 생략가능, 컴파일러가 타입 추론. 지역변수에만 사용.
		for (var room : roomList) {

			JsonObject roomObj = new JsonObject();
			var reservedRoomArray = new JsonArray();

			// 회의실 목록 돌리면서 roomObj에 회의실명 담기
			roomObj.addProperty("name", room.getRoomNo());

			// 예약목록 돌리면서
			for (var reservedRoom : rooms) {
				// 예약된 회의실명이랑 등록되어있는 회의실명이랑 같으면
				if (reservedRoom.getRoomNo().equals(room.getRoomNo())) {
					// roomObj.addProperty("mName",
					// meetingRoomService.selectMName(reservedRoom.getmNo()));

					System.out.println(reservedRoom.getRoomNo() + " : " + room.getRoomNo());

					var innerArr = new JsonArray();

					int startTime = getCellTime(reservedRoom.getStartTime());
					int endTime = getCellTime(reservedRoom.getEndTime());

					innerArr.add(startTime);
					innerArr.add(endTime);

					// 시간 담긴 배열을 또 배열에 담아
					reservedRoomArray.add(innerArr);
					System.out.println(reservedRoomArray.toString());
				}
			}

			// roomObj에 회의실명이랑 해당 회의실에 예약된 시간들이 담김
			roomObj.add("times", reservedRoomArray);

			jsonRooms.add(roomObj);
		}

		obj.add("rooms", jsonRooms);

		// var str
		String str = obj.toString();

		System.out.println(str);

		return str;
	}

	// 예약상세 진입
	// 예약표시 테이블에서 date, roomNo, startTime 전달받아 올 것
	/*
	 * @RequestMapping("reservationDetails.do")
	 * 
	 * @ResponseBody public String reservationDetails(@RequestParam("date") String
	 * date, @RequestParam("startTime") String startTime,
	 * 
	 * @RequestParam("roomNo") String roomNo, HttpSession session, Model model) {
	 * 
	 * //파라미터 정보로 해당 예약의 모든 정보 select 해오기 //roomName으로 roomNo select 해오기 //String
	 * roomNo = meetingRoomService.selectRoomNo(roomName);
	 * 
	 * System.out.println("날짜 : " + date);
	 * 
	 * //룸넘버로 룸네임 가져오기 String roomName = meetingRoomService.selectRoomName(roomNo);
	 * 
	 * ReserveRoom roomInfo = new ReserveRoom(); roomInfo.setReserveDate(date);
	 * roomInfo.setStartTime(startTime); roomInfo.setRoomNo(roomNo);
	 * 
	 * ReserveRoom room = meetingRoomService.selectRoom(roomInfo);
	 * 
	 * //예약자의 이름, 직급 select 해오기 String mNo = room.getmNo(); String mName =
	 * meetingRoomService.selectMName(mNo); String mJob =
	 * meetingRoomService.selectMJobName(mNo);
	 * 
	 * model.addAttribute("room", room); model.addAttribute("roomName", roomName);
	 * model.addAttribute("mName", mName); model.addAttribute("mJob", mJob);
	 * 
	 * return new GsonBuilder().create().toJson(room); }
	 */

	// 예약상세 진입
	@RequestMapping("reservationDetails.do")
	public String reservationDetails(HttpServletRequest request, HttpSession session, Model model) {

		// 파라미터 정보로 해당 예약의 모든 정보 select 해오기
		String date = request.getParameter("dateD");
		String roomNo = request.getParameter("roomNoD");
		String startTime = request.getParameter("startTimeD");

		String roomName = meetingRoomService.selectRoomName(roomNo);

		ReserveRoom roomInfo = new ReserveRoom();
		roomInfo.setReserveDate(date);
		roomInfo.setStartTime(startTime);
		roomInfo.setRoomNo(roomNo);

		ReserveRoom room = meetingRoomService.selectRoom(roomInfo);

		String mNo = room.getmNo();
		String mName = meetingRoomService.selectMName(mNo);
		String mJob = meetingRoomService.selectMJobName(mNo);

		// 회의실 선택 selectbox용
		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(userCNo);
		model.addAttribute("roomList", roomList);

		// 예약내역 전달
		model.addAttribute("room", room);
		model.addAttribute("roomName", roomName);
		model.addAttribute("mName", mName);
		model.addAttribute("mJob", mJob);

		return "meetingRoom/details";

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
	
	//회의실 수정
	

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

	// 회의실 예약 삭제
	/*
	 * @RequestMapping("deleteReservation.do") public String
	 * deleteReservation(@RequestParam("reservationNo") String reservationNo, Model
	 * model) {
	 * 
	 * int result = meetingRoomService.deleteReservation(reservationNo);
	 * 
	 * if(result > 0) { model.addAttribute("msg", "예약을 취소하였습니다."); }else {
	 * model.addAttribute("msg", "예약에 실패하였습니다."); }
	 * 
	 * return "meetingRoom/roomReservation";
	 * 
	 * }
	 */

	// 예약 수정
	/*
	 * @RequestMapping("updateReservation.do") public String
	 * updateReservation(@RequestParam("reserveNo") String reserveNo,
	 * 
	 * @RequestParam("roomName") String roomName, @RequestParam("date") String date,
	 * 
	 * @RequestParam("startTime") String startTime, @RequestParam("endTime") String
	 * endTime,
	 * 
	 * @RequestParam("reserveUserNo") String
	 * reserveUserNo, @RequestParam("reserveTitle") String reserveTitle, HttpSession
	 * session, Model model) {
	 * 
	 * Member loginUser = (Member) session.getAttribute("loginUser"); String mNo =
	 * loginUser.getMNo(); // 예약자랑 비교 int cNo = loginUser.getCNo();
	 * 
	 * if (mNo.equals(reserveUserNo)) { // 예약자랑 로그인유저랑 동일하면 수정 진행
	 * 
	 * String roomNo = meetingRoomService.selectRoomNo(roomName);
	 * 
	 * ReserveRoom updateRoom = new ReserveRoom();
	 * updateRoom.setReserveNo(reserveNo); updateRoom.setRoomNo(roomNo);
	 * updateRoom.setReserveDate(date); updateRoom.setStartTime(startTime);
	 * updateRoom.setEndTime(endTime); updateRoom.setReserveTitle(reserveTitle);
	 * updateRoom.setmNo(mNo); updateRoom.setcNo(cNo);
	 * 
	 * int result = meetingRoomService.updateReservation(updateRoom);
	 * 
	 * if (result > 0) {
	 * 
	 * return "redirect:/reservationDetails.do"; } else { return
	 * "redirect:/reservationDetails.do"; }
	 * 
	 * } else { model.addAttribute("msg", "해당 예약은 수정할 수 없습니다."); return
	 * "redirect:/reservationDetails.do"; }
	 * 
	 * }
	 */

	// 예약 수정
	@RequestMapping("updateReservation.do")
	public String updateReservation(HttpServletRequest request, HttpSession session, Model model) {
		
		//그냥 delete 했다가 다시 insert 하면 안될까?
		
		// 예약번호
		String reserveNoUpdate = request.getParameter("reserveNoUpdate");

		// 룸 이름으로 룸 번호 가져오기
		String selectRoomUpdate = request.getParameter("selectRoomUpdate");
		String roomNo = meetingRoomService.selectRoomNo(selectRoomUpdate);

		String dateUpdate = request.getParameter("dateUpdate");

		String startTimeUpdate = request.getParameter("startTimeUpdate");
		String endTimeUpdate = request.getParameter("endTimeUpdate");

		String reserveTitleUpdate = request.getParameter("reserveTitleUpdate");
		String reserveUserNoUpdate = request.getParameter("reserveUserNoUpdate");

		Member loginUser = (Member) session.getAttribute("loginUser");
		String mNo = loginUser.getMNo(); // 예약자랑 비교
		int cNo = loginUser.getCNo();

		if (mNo.equals(reserveUserNoUpdate)) {		
			
			// 예약일, 시간 검사
			if (!isValidTime(roomNo, dateUpdate, startTimeUpdate, endTimeUpdate)) {
				
				//false 
				session.setAttribute("msg", "이미 예약된 시간입니다.");
				return "redirect:/roomReservingForm.do";
				
			} else {
				
				//true
				ReserveRoom updateRoom = new ReserveRoom();
				updateRoom.setReserveNo(reserveNoUpdate);
				updateRoom.setRoomNo(roomNo);
				updateRoom.setReserveDate(dateUpdate);
				updateRoom.setStartTime(startTimeUpdate);
				updateRoom.setEndTime(endTimeUpdate);
				updateRoom.setReserveTitle(reserveTitleUpdate);
				updateRoom.setmNo(reserveUserNoUpdate);
				updateRoom.setcNo(cNo);
				
				int result = meetingRoomService.updateReservation(updateRoom);
				
				if(result > 0) {
					session.setAttribute("msg", "예약을 수정하였습니다.");
					return "redirect:/roomReservingForm.do";
					
				}else {
					session.setAttribute("msg", "예약 수정에 실패하였습니다.");
					return "redirect:/roomReservingForm.do";
				}
			}
		
		}else {
			
			session.setAttribute("msg", "해당 예약은 수정할 수 없습니다.");
			return "redirect:/roomReservingForm.do";
		}
		
		
	}

	// 예약 취소
	@RequestMapping("deleteReservation.do")
	public String deleteReservation(HttpServletRequest request, HttpSession session, Model model) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		String mNo = loginUser.getMNo(); // 예약자랑 비교
		String reservationUserNo = request.getParameter("reserveUserNo");

		if (mNo.equals(reservationUserNo)) {
			String reservationNo = request.getParameter("reserveNo");

			int result = meetingRoomService.deleteReservation(reservationNo);
			String date = meetingRoomService.selectReserveDate(reservationNo);

			if (result > 0) {
				model.addAttribute("date", date);
				session.setAttribute("msg", "예약을 취소하였습니다.");
			} else {
				session.setAttribute("msg", "취소에 실패하였습니다.");
				//return "redirect:/reservationDetails.do";
				
				//String referer = request.getHeader("Referer");
				//return "redirect:" + referer;
				
				return "redirect:/roomReservingForm.do";
				
			}

		} else {
			
			session.setAttribute("msg", "해당 예약은 취소할 수 없습니다.");
			
			//String referer = request.getHeader("Referer");
			//return "redirect:" + referer;
			
			return "redirect:/roomReservingForm.do";
			
		}

		// 화면 이상하게 나옴; 체크
		// return "meetingRoom/roomReservation";
		// return "main";
		// model.addAttribute("date", "2022-06-10");
		return "redirect:/roomReservingForm.do";
	}
	
	@ResponseBody
	@PostMapping(value = "/selectreservedRoom", produces = "application/json; charset=utf-8")
	public String selectReservedRoom(Member m, Model model, String title, String time) { 

		Member loginUser = (Member) model.getAttribute("loginUser");
		
		ReserveRoom r = new ReserveRoom();
		r.setReserveNo(title);
		r.setStartTime(time);
		r.setmNo(loginUser.getMNo());
		r.setcNo(loginUser.getCNo());
		
		ReserveRoom room = meetingRoomService.selectreservedRoom(r);
		
		return new GsonBuilder().create().toJson(room);
	}
	
	
	/* public static String getURL(HttpServletRequest request) {
	    Enumeration<?> param = request.getParameterNames();

	    StringBuffer strParam = new StringBuffer();
	    StringBuffer strURL = new StringBuffer();

	    if (param.hasMoreElements())
	    {
	    	strParam.append("?");
	      //strParam.append(“?”);
	    }

	    while (param.hasMoreElements())
	    {
	      String name = (String) param.nextElement();
	      String value = request.getParameter(name);
	      strParam.append(name + "=" + value);
	      //strParam.append(name + “=” + value);

	      if (param.hasMoreElements())
	      {
	    	  strParam.append("&");
	    	  //strParam.append(“&”);
	      }
	  }

	  strURL.append(request.getRequestURI());
	  strURL.append(strParam);

	  return strURL.toString();
	} */
}
