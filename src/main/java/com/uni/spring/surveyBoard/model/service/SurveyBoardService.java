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

	int selectAllListCount(SurveyBoard sb);

	ArrayList<SurveyBoard> selectAllList(PageInfo pi, SurveyBoard sb);

	int selectMyListCount(SurveyBoard sb);

	ArrayList<SurveyBoard> selectMyList(PageInfo pi, SurveyBoard sb);

	int selectEndListCount(SurveyBoard sb);

	ArrayList<SurveyBoard> selectEndList(PageInfo pi, SurveyBoard sb);

	ArrayList<SurveyBoard> selectBoardInfo(SurveyBoard sb);

	int selectDeptCount(SurveyBoard sb);

	int selectDeptAllCount(SurveyBoard sb);

	int selectComMemCount(int sbNo);

	ArrayList<SurveyBoard> selectDeptNoList(int sbNo);

	ArrayList<SurveyBoard> selectSBAnswerList(int sbNo);

	void insertAnswerInfo(int sbNo, int[] sbQuestion, int sbINo, String mNo);

	void deleteSurveyBoard(int sbNo);

}
