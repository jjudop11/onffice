package com.uni.spring.notice.service;

import java.util.ArrayList;

import com.uni.spring.notice.model.notice;

public interface noticeService  {

	int selectListCount();

	ArrayList<notice> selectList();

	void insertNotice(notice n);

	void deleteNotice(int bno);

	void updateNotice(notice n);

	notice selectNotice(int bno);

}
