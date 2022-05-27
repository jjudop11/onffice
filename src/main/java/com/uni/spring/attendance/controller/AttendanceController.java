package com.uni.spring.attendance.controller;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.attendance.model.service.AttendanceService;
import com.uni.spring.member.model.dto.Member;

@Controller
@SessionAttributes({"loginUser", "msg"})
public class AttendanceController {
	
	@Autowired
	private AttendanceService attendanceService;
	
	@GetMapping("/attendanceForm")
	public String attendanceForm() {
		return "attendance/attendanceForm";
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendance",produces = "application/json; charset=utf-8")
	public String selectAttendance(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		Attendance a = Attendance.builder()
				.mNo(m.getMNo())
				.entDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")))
				.build();
		Attendance result = attendanceService.selectAttendance(a);

		return new GsonBuilder().create().toJson(result);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/insertAtime",produces = "application/json; charset=utf-8")
	public String insertAtime(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");

		Attendance a = Attendance.builder()
				.mNo(m.getMNo())
				.entDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")))
				.aAtime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
				.build();

		int result = attendanceService.insertAtime(a);

		return String.valueOf(result);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/insertLtime",produces = "application/json; charset=utf-8")
	public String insertLtime(Model model, HttpSession session) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		Attendance a = Attendance.builder()
				.mNo(m.getMNo())
				.entDate(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")))
				.aLtime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
				.build();
		int result = attendanceService.insertLtime(a);

		return String.valueOf(result);
		
	}
}
