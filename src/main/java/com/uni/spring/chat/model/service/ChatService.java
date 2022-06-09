package com.uni.spring.chat.model.service;

import java.util.ArrayList;

import com.uni.spring.chat.model.dto.Chat;
import com.uni.spring.chat.model.dto.Message;
import com.uni.spring.member.model.dto.Member;

public interface ChatService {

	ArrayList<Chat> selectChatRoomList(int cNo);

	ArrayList<Chat> selectCount(int cNo);

	ArrayList<Member> selectMemList(Member m);

	ArrayList<Member> checkedUserList(Member m);

	void insertSelectUserList(Member m);

	void deleteCheckedUser(Member m);

	Chat selectRoom(int crNo);

	int createChatRoom(Chat chat);

	void insertChatUser(Chat chat, ArrayList<Member> mList, Member m);

	Chat findRoomUser(Chat chat);

	void insertChatUser(Chat chat);

	void deleteRoom(Chat chat);

	ArrayList<Chat> findRoomUserList(Chat chat);

	Chat findCAUser(Chat chat);

	void insertCAUser(Chat chat);

	void updateCAUser(Chat chat);

	Chat findCHSeq(Chat chat);

	void saveChat(Chat chat);

	Member loginUser(Chat chat);

	ArrayList<Message> selectCHList(Chat chat);

}
