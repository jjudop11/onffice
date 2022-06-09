package com.uni.spring.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.dto.Message;
import com.uni.spring.member.model.dto.Member;

@Repository
public class ChatDao {

	public ArrayList<Chat> selectChatRoomList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatRoomList", cNo);
	}

	public ArrayList<Chat> selectCount(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectCount", cNo);
	}

	public ArrayList<Member> selectMemList(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectMemList", m);
	}

	public ArrayList<Member> checkedUserList(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.checkedUserList", m);
	}

	public void insertSelectUserList(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		sqlSession.insert("chatMapper.insertSelectUserList" , m);
		
	}

	public void deleteCheckedUser(SqlSessionTemplate sqlSession, Member m) {
		// TODO Auto-generated method stub
		sqlSession.delete("chatMapper.deleteCheckedUser" , m);
	}

	public int createChatRoom(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return sqlSession.insert("chatMapper.createChatRoom" , chat);
	}

	public void insertChatUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		sqlSession.insert("chatMapper.insertChatUser" , chat);
	}

	public Chat findRoomUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("chatMapper.findRoomUser" , chat);
	}

	public void deleteRoom(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		sqlSession.delete("chatMapper.deleteRoom", chat);
	}

	public ArrayList<Chat> findRoomUserList(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.findRoomUserList", chat);
	}

	public Chat findCAUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("chatMapper.findCAUser" , chat);
	}

	public void insertCAUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		sqlSession.insert("chatMapper.insertCAUser" , chat);
	}

	public void updateCAUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		sqlSession.update("chatMapper.updateCAUser" , chat);
	}

	public Chat findCHSeq(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("chatMapper.findCHSeq", chat);
	}

	public void saveChat(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		sqlSession.insert("chatMapper.saveChat" , chat);
	}

	public Member loginUser(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("chatMapper.loginUser", chat);
	}

	public ArrayList<Message> selectCHList(SqlSessionTemplate sqlSession, Chat chat) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectCHList", chat);
	}

}
