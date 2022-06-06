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
	public int insertTimetable(Timetable t) {
		// TODO Auto-generated method stub
		return timetabelDao.insertTimetable(sqlsession, t);
	}

	@Override
	public int deleteTimetable(String tNo) {
		// TODO Auto-generated method stub
		return timetabelDao.deleteTimetable(sqlsession, tNo);
	}

	@Override
	public int updateTimetable(Timetable t) {
		// TODO Auto-generated method stub
		return timetabelDao.updateTimetable(sqlsession, t);
	}

	@Override
	public ArrayList<Timetable> selectTimetableListFilter(ArrayList<Timetable> tList) {
		// TODO Auto-generated method stub
		return timetabelDao.selectTimetableListFilter(sqlsession, tList);
	}

}
