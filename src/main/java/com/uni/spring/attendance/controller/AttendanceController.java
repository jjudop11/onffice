package com.uni.spring.attendance.controller;

import java.time.LocalDateTime;
import java.time.Month;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.spi.LocaleServiceProvider;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.attendance.model.service.AttendanceService;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.Pagination;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.dept.model.service.DeptService;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.service.MemberService;

import oracle.net.aso.g;

@Controller
@SessionAttributes({"loginUser", "msg"})
public class AttendanceController {
	
	@Autowired
	private AttendanceService attendanceService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private DeptService deptService;
	
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
	
	@GetMapping("/managerAttendance")
	public String managerAttendance(Model model) {
		return "member/managerAttendanceForm";
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceCount",produces = "application/json; charset=utf-8")
	public String selectAttendanceCount(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		Attendance a = attendanceService.selectAttendanceCount(m.getCNo());
		int result = attendanceService.selectAttendanceACount(m.getCNo());		
		a.setACount(result);
		
		return new GsonBuilder().create().toJson(a);
		
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceAllM",produces = "application/json; charset=utf-8")
	public String selectAttendanceAllM(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		ArrayList<Attendance> list = attendanceService.selectAttendanceAllM(m.getCNo());

		for (Attendance a : list) {
	
			a.setAWtime(String.valueOf(Integer.parseInt(a.getAWtime()) / a.getACount()));
		
			int hour = Integer.parseInt(a.getAWtime())/(60*60);
	        int minute = Integer.parseInt(a.getAWtime())/60-(hour*60);
	        int second = Integer.parseInt(a.getAWtime())%60;
	        a.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second)); 
	
		}
				
		return new GsonBuilder().create().toJson(list);
		
	}
	

	@ResponseBody
	@PostMapping(value ="/selectAttendanceCountList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectAttendanceCountList(@RequestParam(value = "page", defaultValue = "1", required = false) int page, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member m = (Member) model.getAttribute("loginUser");
		
		int mListCount = memberService.selectMemListCount(m.getCNo());
		
		PageInfo pi = Pagination.getPageInfo(mListCount, page, 10, 5);
		ArrayList<Attendance> list = attendanceService.selectAttendanceCountList(pi, m.getCNo());
		ArrayList<Member> mList = memberService.selectMemList(pi, m.getCNo());
		
		for(Member mem : mList) {
			for (Attendance a : list) {
				if(mem.getMNo().equals(a.getMNo())) {
					if(a.getAAtime() != null) {
						mem.setAAtime(a.getAAtime().substring(10));
					}
					if(a.getALtime() != null) {
						mem.setALtime(a.getALtime().substring(10));
					}
					if(a.getAWtime() != null) {

						int hour = Integer.parseInt(a.getAWtime())/(60*60);
				        int minute = Integer.parseInt(a.getAWtime())/60-(hour*60);
				        int second = Integer.parseInt(a.getAWtime())%60;
				        mem.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second)); 
					}
					mem.setAState(a.getAState());
				}
			}
		}
		
		result.put("mList", mList);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());

		return result;
		
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceWList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectAttendanceWList(@RequestParam(value = "page", defaultValue = "1", required = false) int page, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member m = (Member) model.getAttribute("loginUser");
		
		int mListCount = memberService.selectMemListCount(m.getCNo());
		
		PageInfo pi = Pagination.getPageInfo(mListCount, page, 10, 5);
		ArrayList<Attendance> list = attendanceService.selectAttendanceWList(pi, m.getCNo());
		ArrayList<Member> mList = memberService.selectMemList(pi, m.getCNo());
		
		for(Member mem : mList) {
			for (Attendance a : list) {
				if(mem.getMNo().equals(a.getMNo())) {
					mem.setAllWtime(a.getAllWtime());
					
					if(a.getAllWtime() != null) {
						
						int hour = Integer.parseInt(a.getAllWtime())/(60*60);
				        int minute = Integer.parseInt(a.getAllWtime())/60-(hour*60);
				        int second = Integer.parseInt(a.getAllWtime())%60;
				        mem.setAllWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second)); 
					}
				}
			}
			
		}
		
		result.put("mList", mList);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());

		return result;
		
	}
	
	@ResponseBody
	@PostMapping(value ="/selectAttendanceMList",produces = "application/json; charset=utf-8")
	public Map<String, Object> selectAttendanceMList(@RequestParam(value = "page", defaultValue = "1", required = false) int page, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member m = (Member) model.getAttribute("loginUser");
		
		int mListCount = memberService.selectMemListCount(m.getCNo());
		
		PageInfo pi = Pagination.getPageInfo(mListCount, page, 10, 5);
		ArrayList<Member> mList = memberService.selectMemList(pi, m.getCNo());
		ArrayList<Attendance> list = attendanceService.selectAttendanceMList(pi, mList);


		for(Member mem : mList) {
			for (Attendance a : list) {
				if(mem.getMNo().equals(a.getMNo())) {
					mem.setWCount(a.getWCount());
					mem.setLCount(a.getLCount());
				}
			}
		}
		
		result.put("mList", mList);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());
		return result;
		
	}
	
	@ResponseBody
	@PostMapping(value ="/searchAttendanceList",produces = "application/json; charset=utf-8")
	public Map<String, Object> searchAttendanceList(@RequestParam(value = "page", defaultValue = "1", required = false) int page, String start, String end, Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member m = (Member) model.getAttribute("loginUser");
		Attendance a = Attendance.builder()
				.aAtime(start) // 시작일
				.aLtime(end) // 종료일
				.mNo(m.getMNo())
				.build();
		
		int mListCount = attendanceService.searchAttendanceListCount(a);
		PageInfo pi = Pagination.getPageInfo(mListCount, page, 10, 5);
		ArrayList<Attendance> list = attendanceService.searchAttendanceList(pi, a);
		
		for (Attendance at : list) {
			if(at.getAWtime() != null) {
				int hour = Integer.parseInt(at.getAWtime())/(60*60);
		        int minute = Integer.parseInt(at.getAWtime())/60-(hour*60);
		        int second = Integer.parseInt(at.getAWtime())%60;
		        at.setAWtime(String.format("%02d",hour)+":"+String.format("%02d",minute)+":"+String.format("%02d",second));
			}
		}
		result.put("list", list);
		result.put("page",  pi.getCurrentPage());
		result.put("startpage",  pi.getStartPage());
		result.put("endpage",  pi.getEndPage());
		result.put("maxpage",  pi.getMaxPage());
		
		return result;
	}
	
	@ResponseBody
	@PostMapping(value ="monthCount",produces = "application/json; charset=utf-8")
	public String monthCount(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		Attendance a = attendanceService.MonthCount(m.getMNo());
	
		return new GsonBuilder().create().toJson(a);
		
	}

}
