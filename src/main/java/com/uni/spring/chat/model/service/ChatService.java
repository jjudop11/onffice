package com.uni.spring.chat.model.service;

import java.util.ArrayList;

import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.member.model.dto.Member;

public interface ChatService {

	ArrayList<Chat> selectChatRoomList();

	ArrayList<Chat> selectCount();

	ArrayList<Member> selectMemList(Member m);

	ArrayList<Member> checkedUserList(Member m);

	void insertSelectUserList(Member m);

	void deleteCheckedUser(Member m);

}
