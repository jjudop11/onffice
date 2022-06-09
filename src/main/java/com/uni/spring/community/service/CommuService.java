package com.uni.spring.community.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.SearchCondition;
import com.uni.spring.community.model.Community;
import com.uni.spring.community.model.Reply;
import com.uni.spring.notice.model.notice;

public interface CommuService  {

	int selectListCount(int companyNo);

	ArrayList<Community> selectList(PageInfo pi, int companyNo);

	void insertCommu(Community c);

	Community selectCommu(int cn);

	ArrayList<Reply> selectReplyList(int cn);

	int insertReply(Reply r);

	void deleteCommu(int comNum);

	void updateCommu(Community c);

	int searchListCount(SearchCondition sc);

	ArrayList<notice> searchList(SearchCondition sc, PageInfo pi);

	void deleteReply(int cn);

}
