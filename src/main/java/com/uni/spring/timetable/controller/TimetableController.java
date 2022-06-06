package com.uni.spring.timetable.controller;

import java.nio.Buffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.databind.deser.impl.ExternalTypeHandler.Builder;
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
	public ArrayList<Timetable> selecttimetableList(Model model, @RequestParam(value = "fil[]", defaultValue = "", required = false) List<String> fil, String start, String end) {
		
		Member m = (Member) model.getAttribute("loginUser");
		
		ArrayList<Timetable> list = null;
		if(fil.isEmpty()) {
			ArrayList<Timetable> tList = new ArrayList<Timetable>();
			Timetable t = Timetable.builder()
					.mNo(m.getMNo())
					.tStart(start)
					.tEnd(end)
					.build();
			tList.add(t);
			list = timetableService.selectTimetableListFilter(tList);
		} else {
			ArrayList<Timetable> tList = new ArrayList<Timetable>();
			for (String s : fil) {
				Timetable t = Timetable.builder()
						.mNo(m.getMNo())
						.tStart(start)
						.tEnd(end)
						.tCategory(s)
						.build();
				tList.add(t);
			}
			list = timetableService.selectTimetableListFilter(tList);
		}

        return list;
	}
	
	@ResponseBody
	@PostMapping(value ="/insertTimetable",produces = "application/json; charset=utf-8")
	public String insertTimetable(@RequestBody Timetable t, Model model) {
		
		Member m = (Member) model.getAttribute("loginUser");
		t.setMNo(m.getMNo());
		
		int result = timetableService.insertTimetable(t);
		
        return String.valueOf(result);
	}
	
	@ResponseBody
	@PostMapping(value ="/deleteTimetable",produces = "application/json; charset=utf-8")
	public String deleteTimetable(String tNo, Model model) {

		int result = timetableService.deleteTimetable(tNo);
		
        return String.valueOf(result);
	}
	
	@ResponseBody
	@PostMapping(value ="/updateTimetable",produces = "application/json; charset=utf-8")
	public String updateTimetable(@RequestBody Timetable t, Model model) {

		int result = timetableService.updateTimetable(t);
		
        return String.valueOf(result);
	}
}
