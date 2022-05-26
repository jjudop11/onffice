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

	public ArrayList<Member> selectMemList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectMemList", cNo);
	}

}
