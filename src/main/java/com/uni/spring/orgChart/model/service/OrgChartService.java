package com.uni.spring.orgChart.model.service;

import java.util.ArrayList;

import com.uni.spring.orgChart.model.dto.OrgChart;

public interface OrgChartService {

	ArrayList<OrgChart> selectOrgChartList(int cNo);

	ArrayList<OrgChart> selectOrgChartMList(int cNo);

	ArrayList<String> selectDeptList(int cNo);

	OrgChart selectMemInfo(OrgChart org);

	ArrayList<OrgChart> selectSearchMemList(int cNo);

}
