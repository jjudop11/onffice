package com.uni.spring.notice.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.notice.model.notice;

public interface noticeService  {

	int selectListCount();

	ArrayList<notice> selectList(PageInfo pi);

	notice selectNotice(int bno);

	void insertNotice(notice n);

	void deleteNotice(int bno);

	void updateNotice(notice n);

}
