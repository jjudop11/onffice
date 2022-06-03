package com.uni.spring.timetable.model.service;

import java.util.ArrayList;

import com.uni.spring.timetable.model.dto.Timetable;

public interface TimetableService {

	ArrayList<Timetable> selectTimetableList(String mNo);

}
