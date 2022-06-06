package com.uni.spring.timetable.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.timetable.model.dto.Timetable;

@Repository
public class TimetableDao {

	public ArrayList<Timetable> selectTimetableList(SqlSessionTemplate sqlsession, String mNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("TimetableMapper.selectTimetableList", mNo);
	}

	public int insertTimetable(SqlSessionTemplate sqlsession, Timetable t) {
		// TODO Auto-generated method stub
		return sqlsession.insert("TimetableMapper.insertTimetable", t);
	}

	public int deleteTimetable(SqlSessionTemplate sqlsession, String tNo) {
		// TODO Auto-generated method stub
		return sqlsession.delete("TimetableMapper.deleteTimetable", tNo);
	}

	public int updateTimetable(SqlSessionTemplate sqlsession, Timetable t) {
		// TODO Auto-generated method stub
		return sqlsession.update("TimetableMapper.updateTimetable", t);
	}

	public ArrayList<Timetable> selectTimetableListFilter(SqlSessionTemplate sqlsession, ArrayList<Timetable> tList) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("TimetableMapper.selectTimetableListFilter", tList);
	}

}
