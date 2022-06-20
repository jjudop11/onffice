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
		//ArrayList<SurveyBoard> list = surveyBoardDao.selectHomeList(sqlSession, sb, pi);
		
		//String mNo = sb.getSbFounderNo();
		
		
		//ArrayList<SurveyBoard> answerMemList = selectAnswerMemList(mNo, list);

		return surveyBoardDao.selectHomeList(sqlSession, sb, pi);
	}
	
	
/*
	private ArrayList<SurveyBoard> selectAnswerMemList(String mNo, ArrayList<SurveyBoard> list) {
		// TODO Auto-generated method stub
		
		ArrayList<SurveyBoard> answerMemList = surveyBoardDao.selectAnswerMemList(sqlSession, mNo);
		
		if(answerMemList != null) {
			
			for(int i = 0; i < list.size(); i++) {
				
				if(list.get(i).getSbNo() == answerMemList.get(i).getSbNo()) {
					
					list.get(i).setSbAState("참여 완료");
		
				}else {
					list.get(i).setSbAState("미참여");
				}
			}
			
		}
		
		return "";
	}
*/
	
	@Override
	public int selectAllListCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectAllListCount(sqlSession, sb);
	}

	@Override
	public ArrayList<SurveyBoard> selectAllList(PageInfo pi, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectAllList(sqlSession, sb, pi);
	}

	@Override
	public int selectMyListCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectMyListCount(sqlSession, sb);
	}

	@Override
	public ArrayList<SurveyBoard> selectMyList(PageInfo pi, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectMyList(sqlSession, sb, pi);
	}

	@Override
	public int selectEndListCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectEndListCount(sqlSession, sb);
	}

	@Override
	public ArrayList<SurveyBoard> selectEndList(PageInfo pi, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectEndList(sqlSession, sb, pi);
	}

	@Override
	public ArrayList<SurveyBoard> selectBoardInfo(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectBoardInfo(sqlSession, sb);
	}

	@Override
	public int selectDeptCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectDeptCount(sqlSession, sb);
	}

	@Override
	public int selectDeptAllCount(SurveyBoard sb) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectDeptAllCount(sqlSession, sb);
	}

	@Override
	public int selectComMemCount(int sbNo) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectComMemCount(sqlSession, sbNo);
	}

	@Override
	public ArrayList<SurveyBoard> selectDeptNoList(int sbNo) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectDeptNoList(sqlSession, sbNo);
	}

	@Override
	public ArrayList<SurveyBoard> selectSBAnswerList(int sbNo) {
		// TODO Auto-generated method stub
		return surveyBoardDao.selectSBAnswerList(sqlSession, sbNo);
	}

	@Override
	public void insertAnswerInfo(int sbNo, int[] sbQuestion, int sbINo, String mNo) {
		// TODO Auto-generated method stub
		
		SurveyBoard sb = new SurveyBoard();
		sb.setSbNo(sbNo);
		sb.setSbINo(sbINo);
		sb.setMNo(mNo);
		
		surveyBoardDao.deleteSurveyBoardAnswer(sqlSession, sb);
		surveyBoardDao.deleteSurveyBoardAnswerInfo(sqlSession, sb);
		
		for(int b : sbQuestion) {
			
			sb.setSqNo(b);
			surveyBoardDao.insertAnswerInfo(sqlSession, sb);
		}
		
		
		surveyBoardDao.insertAnswerState(sqlSession, sb);
		
	}

	@Override
	public void deleteSurveyBoard(int sbNo) {
		// TODO Auto-generated method stub
		surveyBoardDao.deleteSurveyBoard(sqlSession, sbNo);
		surveyBoardDao.deleteSurveyBoardTD(sqlSession, sbNo);
		surveyBoardDao.deleteSurveyBoardInfo(sqlSession, sbNo);
	}

}
