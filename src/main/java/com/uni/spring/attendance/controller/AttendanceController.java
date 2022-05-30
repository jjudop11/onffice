package com.uni.spring.attendance.controller;

import java.time.LocalDateTime;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.spi.LocaleServiceProvider;

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

import oracle.net.aso.a;
import oracle.net.aso.p;

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
		
		Attendance result = attendanceService.selectAttendance(m.getMNo());
		
		if(result.getAWtime() != null) {
			if(Integer.parseInt(result.getAWtime()) > 32400) {
				result.setAWtime(String.valueOf(Integer.parseInt(result.getAWtime()) - 3600)); 
			}

			int hour = Integer.parseInt(result.getAWtime())/(60*60);
	        int minute = Integer.parseInt(result.getAWtime())/60-(hour*60);
	        int second = Integer.parseInt(result.getAWtime())%60;
	        
	        result.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second));
		}
		
		
        return new GsonBuilder().create().toJson(result);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceW",produces = "application/json; charset=utf-8")
	public String selectAttendanceW(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		ArrayList<Attendance> list = attendanceService.selectAttendanceW(m.getMNo());
		
		int all = 0;
		for (Attendance at : list) {
			if(at.getAWtime() != null) {
				all += Integer.parseInt(at.getAWtime());
			}
		}
		

		for (Attendance a : list) {
			
			if(a.getAWtime() != null) {
				if(Integer.parseInt(a.getAWtime()) > 32400) {
					a.setAWtime(String.valueOf(Integer.parseInt(a.getAWtime()) - 3600)); 
				}
				int hour = Integer.parseInt(a.getAWtime())/(60*60);
		        int minute = Integer.parseInt(a.getAWtime())/60-(hour*60);
		        int second = Integer.parseInt(a.getAWtime())%60;
		        a.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second));
		        
			}
			
	        int h = all/(60*60);
	        int min = all/60-(h*60);
	        int s = all%60;
	        a.setAllWtime(String.format("%02d",h)+":"+String.format("%02d",min)+":"+String.format("%02d",s));
		}
        return new GsonBuilder().create().toJson(list);
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceM",produces = "application/json; charset=utf-8")
	public String selectAttendanceM(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		ArrayList<Attendance> list = attendanceService.selectAttendanceM(m.getMNo());

		for (Attendance a : list) {
			
			if(a.getAWtime() != null) {
				int hour = Integer.parseInt(a.getAWtime())/(60*60);
		        int minute = Integer.parseInt(a.getAWtime())/60-(hour*60);
		        int second = Integer.parseInt(a.getAWtime())%60;
		        a.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second)); 
			}
			System.out.println(a);
		}
		
        return new GsonBuilder().create().toJson(list);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/insertAtime",produces = "application/json; charset=utf-8")
	public String insertAtime(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		int year = LocalDateTime.now().getYear();
		int Month = LocalDateTime.now().getMonthValue();
		int day = LocalDateTime.now().getDayOfMonth();
		int hour= LocalDateTime.now().getHour();
		int min = LocalDateTime.now().getMinute();
		int sencond = LocalDateTime.now().getSecond();
		LocalDateTime test = LocalDateTime.of(year, Month, day, 9, 00, 00);
		LocalDateTime today = LocalDateTime.of(year, Month, day, hour, min, sencond);
		
		Attendance a = null;
		if (today.isAfter(test)) {
		    a = Attendance.builder()
		    	.mNo(m.getMNo())
		    	.aAtime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
		    	.aState("지각")
		    	.build();
		    
		} else {
			a = Attendance.builder()
		    	.mNo(m.getMNo())
		    	.aAtime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
		    	.aState("정상출근")
		    	.build();
		}

		int result = attendanceService.insertAtime(a);

		return String.valueOf(result);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/insertLtime",produces = "application/json; charset=utf-8")
	public String insertLtime(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");

		Attendance a = Attendance.builder()
				.mNo(m.getMNo())
				.aLtime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
				.build();
		int result = attendanceService.insertLtime(a);

		return String.valueOf(result);
		
	}
}
