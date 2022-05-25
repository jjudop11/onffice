package com.uni.spring.chat.model.service;

import java.util.ArrayList;

import com.uni.spring.chat.model.dto.Chat;

public interface ChatService {

	ArrayList<Chat> selectChatRoomList();

	ArrayList<Chat> selectCount();

}
