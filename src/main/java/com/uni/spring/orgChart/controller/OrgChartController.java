package com.uni.spring.orgChart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.GsonBuilder;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.orgChart.model.dto.OrgChart;
import com.uni.spring.orgChart.model.service.OrgChartService;

@Controller
//@RequiredArgsConstructor
@SessionAttributes({"loginUser", "msg"})
public class OrgChartController {

	
	@Autowired
	private OrgChartService orgChartService;
	
	
	

	@ResponseBody
	@RequestMapping(value="orgChartList", produces="application/json; charset=utf-8")
	public Map<String, Object> orgChartList(Model model) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		int cNo = loginUser.getCNo();
		
		
		ArrayList<OrgChart> chartList = orgChartService.selectOrgChartList(cNo);
		ArrayList<OrgChart> chartMList = orgChartService.selectOrgChartMList(cNo);
		ArrayList<String> deptList = orgChartService.selectDeptList(cNo);
		
		result.put("cList", chartList);
		result.put("cMList", chartMList);
		result.put("dList", deptList);
		
		
		
		return result;
		
	}
	
	@ResponseBody
	@RequestMapping(value="selectMemProfile", produces="application/json; charset=utf-8")
	public String selectMemProfile(Model model, OrgChart org) {
		

		OrgChart mem = orgChartService.selectMemInfo(org);
		System.out.println("mem ==== " + mem);
		return new GsonBuilder().create().toJson(mem);
		
	}
	
	@ResponseBody
	@RequestMapping(value="searchMemList", produces="application/json; charset=utf-8")
	public String searchMemList(Model model, String key) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		int cNo = loginUser.getCNo();
		
		ArrayList<OrgChart> searchList = orgChartService.selectSearchMemList(cNo);
		
		ArrayList<OrgChart> resultList = new ArrayList<>(); System.out.println(searchList);
		
		for(int i = 0; i < searchList.size(); i++) {
			
			if(searchList.get(i).getAState().contains(key)) {
				
				resultList.add(searchList.get(i));
			}
			
			if(searchList.get(i).getMName().contains(key)) {
				
				resultList.add(searchList.get(i));
			}
			
			if(searchList.get(i).getDName().contains(key)) {
				
				resultList.add(searchList.get(i));
			}
			
			if(searchList.get(i).getJName().contains(key)) {
				
				resultList.add(searchList.get(i));
			}
			
			
		}
		
		System.out.println("resultList =====  " + resultList);
		return new GsonBuilder().create().toJson(resultList);
		
	}
	
	
	

/*
	@RequestMapping("orgChartList")
	public void orgChartList(Model model) {
		
		Member loginUser = (Member)model.getAttribute("loginUser");
		
		int cNo = loginUser.getCNo();
		
		
		ArrayList<OrgChart> chartList = orgChartService.selectOrgChartList(cNo);
		ArrayList<OrgChart> chartMList = orgChartService.selectOrgChartMList(cNo);
		
		System.out.println("chartList ==== " + chartList);
		System.out.println("chartMList ==== " + chartMList);
		
		model.addAttribute("cList", chartList);
		model.addAttribute("cMList", chartMList);
		
		
	}
	*/
}

