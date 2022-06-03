package com.uni.spring.timetable.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.timetable.model.dto.Timetable;
import com.uni.spring.timetable.model.service.TimetableService;

@Controller
@SessionAttributes({"loginUser", "msg"})
public class TimetableController {
	
	@Autowired
	private TimetableService timetableService;
	
	@GetMapping("/timetableForm")
	public String timetableForm() {
		return "timetable/timetableForm";
	}
	
	@ResponseBody
	@PostMapping(value ="/selecttimetableList",produces = "application/json; charset=utf-8")
	public ArrayList<Timetable> selecttimetableList(Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		ArrayList<Timetable> list = timetableService.selectTimetableList(m.getMNo());
		//Map<String, Object> hash = new HashMap<String, Object>();
		//List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
		
		
        return list;
	}
}
