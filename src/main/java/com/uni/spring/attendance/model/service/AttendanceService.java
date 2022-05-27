package com.uni.spring.attendance.model.service;

import com.uni.spring.attendance.model.dto.Attendance;

public interface AttendanceService {

	Attendance selectAttendance(Attendance a);

	int insertAtime(Attendance a);

	int insertLtime(Attendance a);

}
