package com.uni.spring.surveyBoard.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.surveyBoard.model.dao.SurveyBoardDao;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

@Service
public class SurveyBoardServiceImpl implements SurveyBoardService{

	@Autowired
	private SurveyBoardDao surveyBoardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertSurveyBoard(SurveyBoard sb, String[] target, String[] questionContent) {
		// TODO Auto-generated method stub
		surveyBoardDao.insertSurveyBoard(sqlSession, sb);
		
		
		
		return 0;
	}
}
