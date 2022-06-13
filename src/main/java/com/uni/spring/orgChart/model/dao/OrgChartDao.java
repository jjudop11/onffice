package com.uni.spring.orgChart.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.orgChart.model.dto.OrgChart;

@Repository
public class OrgChartDao {

	public ArrayList<OrgChart> selectOrgChartList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("orgChartMapper.selectOrgChartList", cNo);
	}

	public ArrayList<OrgChart> selectOrgChartMList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("orgChartMapper.selectOrgChartMList", cNo);
	}

	public ArrayList<String> selectDeptList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("orgChartMapper.selectDeptList", cNo);
	}

	public OrgChart selectMemInfo(SqlSessionTemplate sqlSession, OrgChart org) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("orgChartMapper.selectMemInfo", org);
	}

}
