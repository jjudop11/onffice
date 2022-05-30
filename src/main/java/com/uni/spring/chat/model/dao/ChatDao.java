package com.uni.spring.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.member.model.dto.Member;

@Repository
public class ChatDao {

	public ArrayList<Chat> selectChatRoomList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatRoomList");
	}

	public ArrayList<Chat> selectCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectCount");
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

}
