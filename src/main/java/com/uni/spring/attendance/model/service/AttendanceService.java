package com.uni.spring.attendance.model.service;

import java.util.ArrayList;

import com.uni.spring.attendance.model.dto.Attendance;

public interface AttendanceService {

	Attendance selectAttendance(String mNo);

	int insertAtime(Attendance a);

	int insertLtime(Attendance a);

	ArrayList<Attendance> selectAttendanceW(String mNo);

	ArrayList<Attendance> selectAttendanceM(String mNo);

}
