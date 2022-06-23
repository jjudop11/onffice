package com.uni.spring.meetingRoom.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

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

		// 페이징
		int listCount = meetingRoomService.selectRoomListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		// 페이지 들어왔을 때 오늘날짜 예약내역 보여주기
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

	//신규예약
	private boolean isValidTime(String roomNo, String date, String startTime, String endTime) {

		return isValidTime(roomNo, date, startTime, endTime, "");
	}

	//예약수정
	private boolean isValidTime(String roomNo, String date, String startTime, String endTime, String exceptNo) {

		ArrayList<ReserveRoom> reservedRooms = meetingRoomService.checkReservedRooms(roomNo, date);

		int startTimeCal = getTime(startTime);
		int endTimeCal = getTime(endTime);

		for (ReserveRoom r : reservedRooms) {

			if (r.getReserveNo().equals(exceptNo))
				continue;

			int rStartTime = getTime(r.getStartTime());
			int rEndTime = getTime(r.getEndTime());

			// 예약된 시작시간 <= 예약할 시작시간 && 예약된 종료시간 > 예약할 시작시간 ||
			// 예약된 시작시간 < 예약할 종료시간 && 예약된 종료시간 >= 예약할 종료시간
			// 새로 예약할 시간의 사이에 이미 예약된 시간이 포함되어 있어도 안 됨
			if (rStartTime <= startTimeCal && rEndTime > startTimeCal || 
				rStartTime < endTimeCal && rEndTime >= endTimeCal || 
				startTimeCal < rStartTime && startTimeCal < rEndTime 
				&& endTimeCal > rStartTime && endTimeCal > rEndTime) {

				return false;
			}

		}
		return true;
	}

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
			@RequestParam("selectRoom") String selectRoom, @RequestParam("title") String title, HttpSession session) {

		String roomNo = meetingRoomService.selectRoomNo(selectRoom);
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		String mNo = loginUser.getMNo();
		int cNo = loginUser.getCNo();

		if (!isValidTime(roomNo, date, startTime, endTime)) {
			return -1;

		} else {
			room.setRoomNo(roomNo);
			room.setReserveDate(date);
			room.setStartTime(startTime);
			room.setEndTime(endTime);
			room.setReserveTitle(title);
			room.setmNo(mNo);
			room.setcNo(cNo);

			int result = meetingRoomService.reserveRoom(room);

			return result;
		}

	}

	// 예약일정 화면에 뿌리기
	@RequestMapping(value = "reservedRoomList.do", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String reserveRoomList(@RequestParam("date") String date, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		int cNo = loginUser.getCNo();

		ArrayList<ReserveRoom> rooms = meetingRoomService.selectReservedRooms(cNo, date);

		JsonObject obj = new JsonObject();
		JsonArray jsonRooms = new JsonArray();

		ArrayList<MeetingRoom> roomList = meetingRoomService.selectList(cNo);

		for (var room : roomList) {

			JsonObject roomObj = new JsonObject();
			var reservedRoomArray = new JsonArray();
			
			roomObj.addProperty("name", room.getRoomNo());

			for (var reservedRoom : rooms) {
				if (reservedRoom.getRoomNo().equals(room.getRoomNo())) {
					
					var innerArr = new JsonArray();

					int startTime = getCellTime(reservedRoom.getStartTime());
					int endTime = getCellTime(reservedRoom.getEndTime());

					innerArr.add(startTime);
					innerArr.add(endTime);

					reservedRoomArray.add(innerArr);

				}
			}

			roomObj.add("times", reservedRoomArray);
			
			jsonRooms.add(roomObj);
		}

		obj.add("rooms", jsonRooms);
		String str = obj.toString();

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

	// 회의실 수정용 정보조회
	@RequestMapping(value = "roomInfo.do", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String roomInfo(@RequestParam("roomNo") String roomNo, HttpSession session) {

		// 전달받은 roomNo로 해당 회의실 정보 select
		MeetingRoom room = meetingRoomService.selectRoomInfo(roomNo);

		JsonObject roomObj = new JsonObject();
		roomObj.addProperty("roomNo", room.getRoomNo());
		roomObj.addProperty("roomName", room.getRoomName());
		roomObj.addProperty("roomCapa", room.getRoomCapa());
		roomObj.addProperty("roomNote", room.getRoomNote());

		String str = roomObj.toString();

		return str;
	}

	// 회의실 수정
	@RequestMapping("modifyRoom.do")
	@ResponseBody
	public String modifyRoom(@RequestParam("roomNo") String roomNo, @RequestParam("roomName") String roomName,
			@RequestParam("roomCapa") int roomCapa, @RequestParam("roomNote") String roomNote, HttpSession session) {

		MeetingRoom r = new MeetingRoom();
		r.setRoomNo(roomNo);
		r.setRoomName(roomName);
		r.setRoomCapa(roomCapa);
		r.setRoomNote(roomNote);

		int result = meetingRoomService.modifyRoom(r);

		return "";
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
	@RequestMapping(value = "updateReservation.do", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String updateReservation(@RequestParam Map<String, Object> params, HttpSession session, Model model) {

		// 예약번호
		String reserveNoUpdate = (String) params.get("reserveNoUpdate");

		System.out.println(reserveNoUpdate);

		// 룸 이름으로 룸 번호 가져오기
		String selectRoomUpdate = (String) params.get("selectRoomUpdate");
		String roomNo = meetingRoomService.selectRoomNo(selectRoomUpdate);

		String dateUpdate = (String) params.get("dateUpdate");

		String startTimeUpdate = (String) params.get("startTimeUpdate");
		String endTimeUpdate = (String) params.get("endTimeUpdate");

		String reserveTitleUpdate = (String) params.get("reserveTitleUpdate");
		String reserveUserNoUpdate = (String) params.get("reserveUserNoUpdate");

		Member loginUser = (Member) session.getAttribute("loginUser");
		String mNo = loginUser.getMNo(); // 예약자랑 비교
		int cNo = loginUser.getCNo();

		if (mNo.equals(reserveUserNoUpdate)) {
			// 예약일, 시간 검사
			if (!isValidTime(roomNo, dateUpdate, startTimeUpdate, endTimeUpdate, reserveNoUpdate)) {
				// false

				return "이미 예약된 시간입니다.";
			} else {
				// true

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

				if (result > 0) {
					return "예약을 수정하였습니다.";
				} else {
					return "예약 수정에 실패하였습니다.";
				}
			}
		} else {
			return "해당 예약은 수정할 수 없습니다.";
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
				// return "redirect:/reservationDetails.do";

				// String referer = request.getHeader("Referer");
				// return "redirect:" + referer;

				return "redirect:/roomReservingForm.do";

			}

		} else {

			session.setAttribute("msg", "해당 예약은 취소할 수 없습니다.");

			// String referer = request.getHeader("Referer");
			// return "redirect:" + referer;

			return "redirect:/roomReservingForm.do";

		}

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

	/*
	 * public static String getURL(HttpServletRequest request) { Enumeration<?>
	 * param = request.getParameterNames();
	 * 
	 * StringBuffer strParam = new StringBuffer(); StringBuffer strURL = new
	 * StringBuffer();
	 * 
	 * if (param.hasMoreElements()) { strParam.append("?"); //strParam.append(“?”);
	 * }
	 * 
	 * while (param.hasMoreElements()) { String name = (String) param.nextElement();
	 * String value = request.getParameter(name); strParam.append(name + "=" +
	 * value); //strParam.append(name + “=” + value);
	 * 
	 * if (param.hasMoreElements()) { strParam.append("&"); //strParam.append(“&”);
	 * } }
	 * 
	 * strURL.append(request.getRequestURI()); strURL.append(strParam);
	 * 
	 * return strURL.toString(); }
	 */
}
