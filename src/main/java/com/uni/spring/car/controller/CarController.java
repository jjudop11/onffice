package com.uni.spring.car.controller;

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
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.uni.spring.car.model.dto.Car;
import com.uni.spring.car.model.service.CarService;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.meetingRoom.model.dto.MeetingRoom;
import com.uni.spring.member.model.dto.Member;

@Controller
@SessionAttributes("loginUser")
public class CarController {

	@Autowired
	CarService carService;

	// 차량 예약
	@RequestMapping("carReservingForm.do")
	public String carReservingForm() {

		
		
		
		return "car/carReservation";
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
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		model.addAttribute("pi", pi);

		ArrayList<Car> carList = carService.selectCarList(pi, userCNo);
		System.out.println("차량 목록 : " + carList);
		model.addAttribute("carList", carList);

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
}
