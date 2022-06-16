package com.uni.spring.surveyBoard.model.service;

import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

public interface SurveyBoardService {

	int insertSurveyBoard(SurveyBoard sb, String[] target, String[] questionContent);

}
