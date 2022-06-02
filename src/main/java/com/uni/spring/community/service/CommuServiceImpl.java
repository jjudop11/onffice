package com.uni.spring.community.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.CommunityDao;
import com.uni.spring.community.model.Reply;

@Service
public class CommuServiceImpl implements CommuService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private CommunityDao communityDao;
	
	@Override
	public int selectListCount() {
		// TODO Auto-generated method stub
		return communityDao.selectListCount(sqlsession);
	}

	@Override
	public ArrayList<Community> selectList() {
		// TODO Auto-generated method stub
		return communityDao.selectList(sqlsession);
	}

	@Override
	public void insertCommu(Community c) {
		int result = communityDao.insertCommu(sqlsession, c);
		
		if(result < 0) {
			throw new CommException("게시글 추가 실패");
		}
	}

	@Override
	public Community selectCommu(int cn) {
		return communityDao.selectCommu(sqlsession, cn);
	}

	@Override
	public ArrayList<Reply> selectReplyList(int cn) {
		return communityDao.selectReplyList(sqlsession, cn);
	}

	@Override
	public int insertReply(Reply r) {
		int result = communityDao.insertReply(sqlsession, r);
		
		if(result < 0) {
			throw new CommException("댓글 등록 실패");
		}
		return result;
	}

	@Override
	public void deleteNotice(int comNum) {
		int result = communityDao.deleteNotice(sqlsession, comNum);
		
		if(result < 0) {
			throw new CommException("게시글 삭제 실패");
		}
	}

	/*
	@Override
	public void updateNotice(notice n) {
		int result = noticedao.updateNotice(sqlsession, n);
		
		if(result < 0) {
			throw new CommException("게시글 수정 실패");
		}
	}*/

}
