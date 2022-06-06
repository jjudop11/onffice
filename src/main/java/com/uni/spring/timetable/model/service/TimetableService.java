package com.uni.spring.timetable.model.service;

import java.util.ArrayList;

import com.uni.spring.timetable.model.dto.Timetable;

public interface TimetableService {

	int insertTimetable(Timetable t);

	int deleteTimetable(String tNo);

	int updateTimetable(Timetable t);

	ArrayList<Timetable> selectTimetableListFilter(ArrayList<Timetable> tList);

}
