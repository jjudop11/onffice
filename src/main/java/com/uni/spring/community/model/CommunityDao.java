package com.uni.spring.community.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;


@Repository
public class CommunityDao {

	public int selectListCount(SqlSessionTemplate sqlsession) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CommunityMapper.selectListCount");
	}
	
	public ArrayList<Community> selectList(SqlSessionTemplate sqlsession) {
		return (ArrayList)sqlsession.selectList("CommunityMapper.selectList");
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

	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlsession, int rn) {
		return (ArrayList)sqlsession.selectList("CommunityMapper.selectReplyList", rn);
	}

	/*
	public int deleteNotice(SqlSessionTemplate sqlsession, int No_Num) {
		return sqlsession.update("CommunityMapper.deleteNotice", No_Num);
	}

	public int updateNotice(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.update("CommunityMapper.updateNotice", n);
	}

	public ArrayList<notice> selectList(SqlSessionTemplate sqlsession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("noticeMapper.selectList", null, rowBounds);
	}*/



}
