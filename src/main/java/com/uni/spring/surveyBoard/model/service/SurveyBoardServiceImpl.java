package com.uni.spring.surveyBoard.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.surveyBoard.model.dao.SurveyBoardDao;

@Service
public class SurveyBoardServiceImpl {

	@Autowired
	private SurveyBoardDao surveyBoardDao;
}
