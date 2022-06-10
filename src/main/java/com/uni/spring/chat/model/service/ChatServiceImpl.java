package com.uni.spring.chat.model.service;

import java.util.ArrayList;
import java.util.Date;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.chat.model.dao.ChatDao;
import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.dto.Message;
import com.uni.spring.member.model.dto.Member;



@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private ChatDao chatDao;
	
	@Override
	public ArrayList<Chat> selectChatRoomList(int cNo) {
		// TODO Auto-generated method stub
		return chatDao.selectChatRoomList(sqlSession, cNo);
	}

	@Override
	public ArrayList<Chat> selectCount(int cNo) {
		// TODO Auto-generated method stub
		return chatDao.selectCount(sqlSession, cNo);
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

	@Override
	public Chat findRoomUser(Chat chat) {
		Chat user = chatDao.findRoomUser(sqlSession, chat);
		return user;
	}

	@Override
	public void insertChatUser(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.insertChatUser(sqlSession, chat);
	}

	@Override
	public void deleteRoom(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.deleteRoom(sqlSession, chat);
	}

	@Override
	public ArrayList<Chat> findRoomUserList(Chat chat) {
		// TODO Auto-generated method stub
		
		return chatDao.findRoomUserList(sqlSession, chat);
	}

	@Override
	public Chat findCAUser(Chat chat) {
		// TODO Auto-generated method stub
		return chatDao.findCAUser(sqlSession, chat);
	}

	@Override
	public void insertCAUser(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.insertCAUser(sqlSession, chat);
	}

	@Override
	public void updateCAUser(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.updateCAUser(sqlSession, chat);
	}

	@Override
	public Chat findCHSeq(Chat chat) {
		// TODO Auto-generated method stub
		return chatDao.findCHSeq(sqlSession, chat);
	}

	@Override
	public void saveChat(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.saveChat(sqlSession, chat);
	}

	@Override
	public Member loginUser(Chat chat) {
		// TODO Auto-generated method stub
		return chatDao.loginUser(sqlSession, chat);
	}

	@Override
	public ArrayList<Message> selectCHList(Chat chat) {
		// TODO Auto-generated method stub
		return chatDao.selectCHList(sqlSession, chat);
	}

	@Override
	public void exitChatRoom(Chat chat) {
		// TODO Auto-generated method stub
		chatDao.exitChatRoom(sqlSession, chat);
	}

	@Override
	public void disconnect(Chat mem) {
		// TODO Auto-generated method stub
		chatDao.disconnect(sqlSession, mem);
	}

}
