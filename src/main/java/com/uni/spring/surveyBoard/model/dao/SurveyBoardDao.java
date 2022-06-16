package com.uni.spring.surveyBoard.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

@Repository
public class SurveyBoardDao {

	public int insertSurveyBoard(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.insert("surveyBoardMapper.insertSurveyBoard" , sb);
	}

}
