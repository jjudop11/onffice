package com.uni.spring.surveyBoard.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.surveyBoard.model.dao.SurveyBoardDao;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

@Service
public class SurveyBoardServiceImpl implements SurveyBoardService{

	@Autowired
	private SurveyBoardDao surveyBoardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertSurveyBoard(SurveyBoard sb, int[] target, String[] questionContent) {
		// TODO Auto-generated method stub
		
		int result = surveyBoardDao.insertSurveyBoard(sqlSession, sb);
		
		if(result > 0 ) {
	
			long date = new Date().getTime();
			String ran = String.valueOf(date).substring(5);
			int sbINo = Integer.parseInt(ran);
			
			sb.setSbINo(sbINo);
			
			insertSBTargetDept(target, sb);
			insertSBInquiry(sb);
			insertSBQuestion(questionContent, sb);
			
		}else {
			return 0;
		}
		
		
		
		
		return 0;
	}

	private void insertSBQuestion(String[] questionContent, SurveyBoard sb) {
		// TODO Auto-generated method stub
		
		//ArrayList<SurveyBoard> list = new ArrayList<>();
		
		/*
		for(int q = 0; q < questionContent.length; q++) {
			System.out.println(" q  ========= " + q);
			if(questionContent[q] != "") {
				
				SurveyBoard sb1 = new SurveyBoard();
				
				sb1.setSbINo(sb.getSbINo());
				sb1.setSqContent(questionContent[q]);

				System.out.println("qsb ====== " + sb);
				list.add(sb1);
				System.out.println("qList ==== " + list);
			}
			
			
		}
		*/
		
		for(int q = 0; q < questionContent.length; q++) {

			if(questionContent[q] != "") {
				
				sb.setSqContent(questionContent[q]);

				surveyBoardDao.insertSBQuestion(sqlSession, sb);
			}
			
			
		}
		
	}

	private void insertSBInquiry(SurveyBoard sb) {
		// TODO Auto-generated method stub
	
		surveyBoardDao.insertSBInquiry(sqlSession, sb);
	}

	private void insertSBTargetDept(int[] target, SurveyBoard sb) {
		// TODO Auto-generated method stub
		
		ArrayList<SurveyBoard> list = new ArrayList<>();
		
		for(int t = 0; t < target.length; t++) {
			
			SurveyBoard sb1 = new SurveyBoard();
			
			sb1.setSbNo(sb.getSbNo());
			sb1.setSbTDNo(target[t]);
			
			list.add(sb1);
		}
		
		surveyBoardDao.insertSBTargetDept(sqlSession, list);
	}

	@Override
	public ArrayList<Member> selectDeptList(int cNo) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectDeptList(sqlSession, cNo);
	}

	@Override
	public int selectHomeListCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectHomeListCount(sqlSession, sb);
	}

	@Override
	public ArrayList<SurveyBoard> selectHomeList(PageInfo pi, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectHomeList(sqlSession, sb, pi);
	}
}
