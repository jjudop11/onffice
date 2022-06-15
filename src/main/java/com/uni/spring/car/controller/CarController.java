package com.uni.spring.car.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

@Controller
@SessionAttributes("loginUser")
public class CarController {

	//차량 예약
	@RequestMapping("carReservingForm.do")
	public String carReservingForm() {

		return "car/carReservation";
	}
	
	//차량 관리
	@RequestMapping("carSetting.do")
	public String carSetting() {

		return "car/carSetting";
	}
}
