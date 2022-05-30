package com.uni.spring.community.service;

import java.util.ArrayList;

import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.Reply;

public interface CommuService  {

	int selectListCount();

	ArrayList<Community> selectList();

	void insertCommu(Community c);

	Community selectCommu(int cn);

	ArrayList<Reply> selectReplyList(int rn);

	int insertReply(Reply r);

}
