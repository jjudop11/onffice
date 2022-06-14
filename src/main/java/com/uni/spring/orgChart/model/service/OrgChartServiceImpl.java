package com.uni.spring.orgChart.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.orgChart.model.dao.OrgChartDao;
import com.uni.spring.orgChart.model.dto.OrgChart;

@Service
public class OrgChartServiceImpl implements OrgChartService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private OrgChartDao orgChartDao;
	
	
	@Override
	public ArrayList<OrgChart> selectOrgChartList(int cNo) {
		// TODO Auto-generated method stub
		return orgChartDao.selectOrgChartList(sqlSession, cNo);
	}


	@Override
	public ArrayList<OrgChart> selectOrgChartMList(int cNo) {
		// TODO Auto-generated method stub
		return orgChartDao.selectOrgChartMList(sqlSession, cNo);
	}


	@Override
	public ArrayList<String> selectDeptList(int cNo) {
		// TODO Auto-generated method stub
		return orgChartDao.selectDeptList(sqlSession, cNo);
	}


	@Override
	public OrgChart selectMemInfo(OrgChart org) {
		// TODO Auto-generated method stub
		return orgChartDao.selectMemInfo(sqlSession, org);
	}


	@Override
	public ArrayList<OrgChart> selectSearchMemList(int cNo) {
		// TODO Auto-generated method stub
		return orgChartDao.selectSearchMemList(sqlSession, cNo);
	}

}
