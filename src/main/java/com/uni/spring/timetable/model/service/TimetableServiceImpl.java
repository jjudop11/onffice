package com.uni.spring.timetable.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.timetable.model.dao.TimetableDao;
import com.uni.spring.timetable.model.dto.Timetable;

@Service
public class TimetableServiceImpl implements TimetableService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private TimetableDao timetabelDao;

	@Override
	public ArrayList<Timetable> selectTimetableList(String mNo) {
		// TODO Auto-generated method stub
		return timetabelDao.selectTimetableList(sqlsession, mNo);
	}

}
