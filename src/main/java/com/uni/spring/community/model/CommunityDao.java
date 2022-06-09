package com.uni.spring.community.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.SearchCondition;
import com.uni.spring.notice.model.notice;


@Repository
public class CommunityDao {

	public int selectListCount(SqlSessionTemplate sqlsession, int companyNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CommunityMapper.selectListCount", companyNo);
	}
	
	public ArrayList<Community> selectList(SqlSessionTemplate sqlsession, PageInfo pi, int companyNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("CommunityMapper.selectList", companyNo, rowBounds);
	}

	public int insertCommu(SqlSessionTemplate sqlsession, Community c) {
		return sqlsession.insert("CommunityMapper.insertCommunity", c);
	}

	public Community selectCommu(SqlSessionTemplate sqlsession, int cn) {
		return sqlsession.selectOne("CommunityMapper.selectCommunity", cn);
	}

	public int insertReply(SqlSessionTemplate sqlsession, Reply r) {
		return sqlsession.insert("CommunityMapper.insertReply", r);
	}

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlsession, int cn) {
		return (ArrayList)sqlsession.selectList("CommunityMapper.selectReplyList", cn);
	}

	public int deleteCommu(SqlSessionTemplate sqlsession, int comNum) {
		return sqlsession.update("CommunityMapper.deleteCommunity", comNum);
	}

	public int updateCommu(SqlSessionTemplate sqlsession, Community c) {
		return sqlsession.update("CommunityMapper.updateCommunity", c);
	}

	public int getsearchCount(SqlSessionTemplate sqlsession, SearchCondition sc) {
		return sqlsession.selectOne("CommunityMapper.getsearchCount", sc);
	}

	public ArrayList<notice> searchList(SqlSessionTemplate sqlsession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("CommunityMapper.searchList", sc, rowBounds);
	}

	public int deleteReply(SqlSessionTemplate sqlsession, int cn) {
		return sqlsession.update("CommunityMapper.deleteReply", cn);
		
	}


}
