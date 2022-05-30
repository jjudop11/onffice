package com.uni.spring.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.chat.model.dao.ChatDao;
import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.member.model.dto.Member;



@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public ArrayList<Chat> selectChatRoomList() {
		// TODO Auto-generated method stub
		return chatDao.selectChatRoomList(sqlSession);
	}

	@Override
	public ArrayList<Chat> selectCount() {
		// TODO Auto-generated method stub
		return chatDao.selectCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectMemList(Member m) {
		// TODO Auto-generated method stub
		return chatDao.selectMemList(sqlSession, m);
	}

	@Override
	public ArrayList<Member> checkedUserList(Member m) {
		// TODO Auto-generated method stub
		return chatDao.checkedUserList(sqlSession, m);
	}

	@Override
	public void insertSelectUserList(Member m) {
		// TODO Auto-generated method stub
		chatDao.insertSelectUserList(sqlSession, m);
		
	}

	@Override
	public void deleteCheckedUser(Member m) {
		// TODO Auto-generated method stub
		chatDao.deleteCheckedUser(sqlSession, m);
		
	}

}
