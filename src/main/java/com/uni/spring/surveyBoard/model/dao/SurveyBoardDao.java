package com.uni.spring.surveyBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.surveyBoard.model.dto.SurveyBoard;

@Repository
public class SurveyBoardDao {

	public int insertSurveyBoard(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.insert("surveyBoardMapper.insertSurveyBoard" , sb);
	}

	public ArrayList<Member> selectDeptList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectDeptList", cNo);
	}

	public void insertSBTargetDept(SqlSessionTemplate sqlSession, ArrayList<SurveyBoard> list) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertSBTargetDept" , list);
	}

	public void insertSBInquiry(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertSBInquiry" , sb);
	}

	/*
	public void insertSBQuestion(SqlSessionTemplate sqlSession, ArrayList<SurveyBoard> list) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertSBQuestion" , list);
	}
	 */
	public void insertSBQuestion(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertSBQuestion" , sb);
	}

	public int selectHomeListCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBHomeListCount", sb);
	}

	public ArrayList<SurveyBoard> selectHomeList(SqlSessionTemplate sqlSession, SurveyBoard sb, PageInfo pi) {
		// TODO Auto-generated method stub
		if(pi == null) {
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBHomeList", sb);
		} else {
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBHomeList", sb, rowBounds);
		}
	}

}
