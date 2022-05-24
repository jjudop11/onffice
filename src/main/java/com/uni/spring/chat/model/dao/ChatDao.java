package com.uni.spring.chat.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.chat.model.dto.Chat;

@Repository
public class ChatDao {

	public ArrayList<Chat> selectChatRoomList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatRoomList");
	}

}
