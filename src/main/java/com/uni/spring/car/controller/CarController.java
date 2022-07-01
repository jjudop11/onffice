package com.uni.spring.car.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.uni.spring.car.model.dto.Car;
import com.uni.spring.car.model.dto.CarNotice;
import com.uni.spring.car.model.dto.ReserveCar;
import com.uni.spring.car.model.service.CarService;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.member.model.dto.Member;

@Controller
@SessionAttributes("loginUser")
public class CarController {

	@Autowired
	CarService carService;

	// 차량 예약 진입
	@RequestMapping("carReservingForm.do")
	public String carReservingForm(HttpSession session, Model model) {

		//차량 리스트
		//예약용 직원명, 오늘 날짜
		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		String userName = loginUser.getMName();
		String userJob = loginUser.getJName();
		String userNo = loginUser.getMNo();
		model.addAttribute("userName", userName);
		model.addAttribute("userJob", userJob);
		model.addAttribute("userNo", userNo);
				
		ArrayList<Car> carList = carService.selectList(userCNo);
		model.addAttribute("carList", carList);
			
		Date date = new Date();
		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
		String today = simpleDate.format(date);
		model.addAttribute("today", today);
		
		CarNotice cn = carService.selectCarNotice(userCNo);
		
		if(cn == null) {
			CarNotice n = new CarNotice();
			n.setNotice("");
			String notice = n.getNotice();
			model.addAttribute("notice", notice);
			
		}else {
			String notice = cn.getNotice();
			System.out.println("불러온 공지 : " + notice);
			notice = notice.replace("\n", "<br>");
			model.addAttribute("notice", notice);
		}
		
		return "car/carReservation";
	}
	
	//차량예약
	@RequestMapping("reservingCar")
	@ResponseBody
	public String reservingCar(@ModelAttribute ReserveCar car, @RequestParam("reserveDate") String reserveDate, @RequestParam("reserveCarNo") String reserveCarNo, 
				@RequestParam("useDate") String useDate, @RequestParam(value = "note", required = false) String useNote, HttpSession session, Model model) {
		
		//예약시 reserve_car 테이블에 예약 내역도 남기고
		//car 테이블의 대여상태도 update 해주기
		
		//예약시 회사번호도 넘기기
		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		String userNo = loginUser.getMNo();
		
		//예약번호는 시퀀스로
		car.setReserveDate(reserveDate);
		car.setReserveCarNo(reserveCarNo);
		car.setReserveMNo(userNo);
		car.setUseDate(useDate);
		car.setUseNote(useNote);
		car.setcNo(userCNo);
		
		int result = carService.reserveingCar(car);
		System.out.println("차량예약 : " + result);
		carService.updateStatus(reserveCarNo); //해당 번호를 가진 차량 상태 업데이트
		
		//return new GsonBuilder().create().toJson(userNo);
		return "";
	}
	
	//차량대여 상세정보 조회
	@RequestMapping(value="/reserveDetails.do", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String reserveDetails(@RequestParam("reserveCarNo") String reserveCarNo, HttpSession session) {
		
		//해당 차량번호로 예약된 내역 중 가장 최근것 하나 select 
		ReserveCar car = carService.selectReserveCar(reserveCarNo);
		String userNo = car.getReserveMNo();
		String userName = carService.selectUserName(userNo);
		String userJobName = carService.selectUserJobName(userNo);
		
		JsonObject carObj = new JsonObject();
		carObj.addProperty("reserveDate", car.getReserveDate());
		carObj.addProperty("reserveCarNo", car.getReserveCarNo());
		carObj.addProperty("userNo", userNo);
		carObj.addProperty("reserveMName", userName);
		carObj.addProperty("reserveJName", userJobName);
		carObj.addProperty("useDate", car.getUseDate());
		carObj.addProperty("useNote", car.getUseNote());
		
		/* JsonObject obj = carObj;
		String str = obj.toString();
		System.out.println("str : " + str); */
		
		String str = carObj.toString();
		System.out.println("str : " + str);
		
		return str; 
		
	}
	
	//차량 예약내용 수정
	//가장 최근 예약내역 불러와서 데이터 수정하기
	@RequestMapping("updateReserveCar.do")
	@ResponseBody
	public String updateReserveCar(@RequestParam("reserveCarNo") String reserveCarNo, @RequestParam("updateUseDate") String updateUseDate, @RequestParam("updateUseNote") String updateUseNote, HttpSession session) {
		
		//해당 차량번호로 예약된 내역 중 가장 최근것 하나 select 
		ReserveCar car = carService.selectReserveCar(reserveCarNo);
		int reserveNo = car.getReserveNo();
		
		ReserveCar c = new ReserveCar();
		c.setReserveNo(reserveNo);
		c.setUseDate(updateUseDate);
		c.setUseNote(updateUseNote);
		
		int result = carService.updateReserveCar(c);
		System.out.println("수정완료 : " + result);
			
		return ""; 
		
	}
	
	//차량반납
	@RequestMapping("returnCar.do")
	@ResponseBody
	public String returnCar(@RequestParam("reserveCarNo") String reserveCarno) {
		
		carService.updateReturn(reserveCarno);
		
		return "";
	}
	
	
	// 차량 관리 진입
	@RequestMapping("carSetting.do")
	public String carSetting(HttpSession session, Model model,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		String carSetUserId = loginUser.getMId();
		int result = carService.selectCarSetUser(carSetUserId);

		int userCNo = loginUser.getCNo();

		// 페이징 처리
		int listCount = carService.selectCarListCount(userCNo);
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);
		model.addAttribute("pi", pi);

		ArrayList<Car> carList = carService.selectCarList(pi, userCNo);
		System.out.println("차량 목록 : " + carList);
		model.addAttribute("carList", carList);

		CarNotice newCn = carService.selectCarNotice(userCNo);
		
		//등록된 공지가 없으면 빈 문자열로 설정해서 출력해줌
		if(newCn == null) {
			CarNotice n = new CarNotice();
			n.setNotice("");
			String noticeView = n.getNotice();
			model.addAttribute("noticeView", noticeView);
		}else {
			String noticeView = newCn.getNotice();
			System.out.println("불러온 공지 : " + noticeView);
			noticeView = noticeView.replace("<br>", "\n");
			model.addAttribute("noticeView", noticeView);
		}
			
		if (result > 0) {
			return "car/carSetting";

		} else {
			model.addAttribute("msg", "접근권한이 없습니다.");
			return "main";
			
		}
	}
	
	//차량번호 중복체크
	@RequestMapping("carNoCheck.do")
	@ResponseBody
	public String carNoCheck(@RequestParam("carNo") String carNo) {
		
		int count = carService.carNoCheck(carNo);
		return String.valueOf(count);
	}
	
	//차량 추가
	@RequestMapping("insertCar.do")
	@ResponseBody
	public String insertCar(@ModelAttribute Car c, @RequestParam("addCarName") String carName, 
			@RequestParam("addCarNo") String carNo, Model model, HttpSession session) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		
		c.setCarName(carName);
		c.setCarNo(carNo);
		c.setcNo(userCNo);
		
		int result = carService.insertCar(c);
		System.out.println("차량추가 : " + result);
		
		return new GsonBuilder().create().toJson(c);
	}
	
	//차량 삭제
	@RequestMapping("deleteCars.do")
	@ResponseBody
	public String deleteCars(@RequestParam(value = "checkedArr[]") List<String> checkedArr, HttpSession session,
			Model model) {
		
		for (int i = 0; i < checkedArr.size(); i++) {
			String carNo = checkedArr.get(i);
			int result = carService.deleteCars(carNo);
			System.out.println("삭제완료 : " + result);
		}

		Member loginUser = (Member) session.getAttribute("loginUser");
		int userCNo = loginUser.getCNo();
		ArrayList<Car> carList = carService.selectList(userCNo);

		return new GsonBuilder().create().toJson(carList);
	}
	
	//차량공지등록
	/* @RequestMapping("carNotice.do")
	public String carNotice(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		String notice = request.getParameter("carNotice");
		notice = notice.replace("\r\n","<br>");
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		int cNo = loginUser.getCNo();
		
		//공지 저장
		CarNotice cn = new CarNotice();
		cn.setNotice(notice);
		cn.setcNo(cNo);
		
		int insertResult = carService.insertNotice(cn);
		System.out.println("공지저장완료 : " + insertResult);
		
		//저장한 공지 화면에 뿌리기
		//가장 최근 등록된 공지 가져와서 공지내용만 뿌리기
		CarNotice newCn = carService.selectCarNotice();
		String noticeView = newCn.getNotice();
		System.out.println("불러온 공지 : " + noticeView);
		
		request.setAttribute("notice", noticeView);
		
		//return "car/carSetting";
		return "redirect:/carSetting.do";
	} */
	
	@RequestMapping(value = "carNotice.do", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String carNotice(@RequestParam("notice") String notice, HttpSession session, Model model) {
			
		notice = notice.replace("\n", "<br>");
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		int cNo = loginUser.getCNo();
		
		//공지 저장
		CarNotice cn = new CarNotice();
		cn.setNotice(notice);
		cn.setcNo(cNo);
		
		int insertResult = carService.insertNotice(cn);
		System.out.println("공지저장완료 : " + insertResult);
		
		//저장한 공지 화면에 뿌리기
		//가장 최근 등록된 공지 가져와서 공지내용만 뿌리기
		CarNotice newCn = carService.selectCarNotice(cNo);
		String noticeView = newCn.getNotice();
		System.out.println("불러온 공지 : " + noticeView);
		noticeView = noticeView.replace("<br>", "\n");
		model.addAttribute("noticeView", noticeView);
		
		return new GsonBuilder().create().toJson(noticeView);
	}
}
