package com.uni.spring.notice.service;

import java.util.ArrayList;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.SearchCondition;
import com.uni.spring.notice.model.notice;

public interface noticeService  {

	int selectListCount(int companyNo);

	ArrayList<notice> selectList(PageInfo pi, int companyNo);

	void insertNotice(notice n);

	void deleteNotice(int No_Num);

	void updateNotice(notice n);

	notice selectNotice(int no_Num);

	ArrayList<notice> searchList(SearchCondition sc, PageInfo pi);

	int searchListCount(SearchCondition sc);


}
