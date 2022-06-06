package com.uni.spring.chat.model.service;

import java.util.ArrayList;
import java.util.Date;

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

	@Override
	public Chat selectRoom(int crNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int createChatRoom(Chat chat) {
		int result = chatDao.createChatRoom(sqlSession, chat);
		return result;
		
	}
	

	@Override
	public void insertChatUser(Chat chat, ArrayList<Member> mList, Member m) {
		// TODO Auto-generated method stub
		
		
		for(int i = 0; i < mList.size(); i++){
			   
			chat.setMNo(mList.get(i).getMNo());
			chatDao.insertChatUser(sqlSession, chat);
		
		  }
		
		chat.setMNo(m.getMNo());
		chatDao.insertChatUser(sqlSession, chat);
		
	}

}
