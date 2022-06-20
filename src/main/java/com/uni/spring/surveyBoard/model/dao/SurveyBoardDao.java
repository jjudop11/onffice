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

	public int selectAllListCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBAllListCount", sb);
	}

	public ArrayList<SurveyBoard> selectAllList(SqlSessionTemplate sqlSession, SurveyBoard sb, PageInfo pi) {
		// TODO Auto-generated method stub
		if(pi == null) {
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBAllList", sb);
		} else {
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBAllList", sb, rowBounds);
		}
	}

	public int selectMyListCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBMyListCount", sb);
	}

	public ArrayList<SurveyBoard> selectMyList(SqlSessionTemplate sqlSession, SurveyBoard sb, PageInfo pi) {
		// TODO Auto-generated method stub
		if(pi == null) {
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBMyList", sb);
		} else {
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBMyList", sb, rowBounds);
		}
	}

	public int selectEndListCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBEndListCount", sb);
	}

	public ArrayList<SurveyBoard> selectEndList(SqlSessionTemplate sqlSession, SurveyBoard sb, PageInfo pi) {
		// TODO Auto-generated method stub
		if(pi == null) {
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBEndList", sb);
		} else {
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
			RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
			return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBEndList", sb, rowBounds);
		}
	}

	public ArrayList<SurveyBoard> selectAnswerMemList(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBAnswerMemList" , mNo);
	}

	public ArrayList<SurveyBoard> selectBoardInfo(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectBoardInfo" , sb);
	}

	public int selectDeptCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBDeptCount", sb);
	}

	public int selectDeptAllCount(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectSBDeptAllCount", sb);
	}

	public int selectComMemCount(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("surveyBoardMapper.selectComMemCount", sbNo);
	}

	public ArrayList<SurveyBoard> selectDeptNoList(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectDeptNoList" , sbNo);
	}

	public ArrayList<SurveyBoard> selectSBAnswerList(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("surveyBoardMapper.selectSBAnswerList" , sbNo);
	}

	public void insertAnswerInfo(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertAnswerInfo", sb);
	}

	public void insertAnswerState(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.insert("surveyBoardMapper.insertAnswerState", sb);
	}

	public void deleteSurveyBoard(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("surveyBoardMapper.deleteSurveyBoard", sbNo);
	}

	public void deleteSurveyBoardTD(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("surveyBoardMapper.deleteSurveyBoardTD", sbNo);
	}

	public void deleteSurveyBoardInfo(SqlSessionTemplate sqlSession, int sbNo) {
		// TODO Auto-generated method stub
		sqlSession.delete("surveyBoardMapper.deleteSurveyBoardInfo", sbNo);
	}

	public void deleteSurveyBoardAnswer(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.delete("surveyBoardMapper.deleteSurveyBoardAnswer", sb);
	}

	public void deleteSurveyBoardAnswerInfo(SqlSessionTemplate sqlSession, SurveyBoard sb) {
		// TODO Auto-generated method stub
		sqlSession.delete("surveyBoardMapper.deleteSurveyBoardAnswerInfo", sb);
	}

}
