package com.uni.spring.notice.service;

import java.util.ArrayList;

import com.uni.spring.notice.model.notice;
import com.uni.spring.notice.model.noticeInfo;

public interface noticeService  {

	int selectListCount();

	ArrayList<notice> selectList(noticeInfo pi);

	notice selectBoard(int bno);

	void insertBoard(notice n);

	void deleteBoard(int bno);

	void updateBoard(notice n);

}
