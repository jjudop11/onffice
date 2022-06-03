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

}
