package com.uni.spring.surveyBoard.model.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

public interface SurveyBoardService {

	int insertSurveyBoard(SurveyBoard sb, int[] target, String[] questionContent);

	ArrayList<Member> selectDeptList(int cNo);

	int selectHomeListCount(SurveyBoard sb);

	ArrayList<SurveyBoard> selectHomeList(PageInfo pi, SurveyBoard sb);

}
