package com.uni.spring.community.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.Reply;

public interface CommuService  {

	int selectListCount();

	ArrayList<Community> selectList(PageInfo pi);

	void insertCommu(Community c);

	Community selectCommu(int cn);

	ArrayList<Reply> selectReplyList(int cn);

	int insertReply(Reply r);

	void deleteCommu(int comNum);

	void updateCommu(Community c);

}
