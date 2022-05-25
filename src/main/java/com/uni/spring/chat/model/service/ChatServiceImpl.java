package com.uni.spring.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.chat.model.dao.ChatDao;
import com.uni.spring.chat.model.dto.Chat;



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

}
