package com.uni.spring.attendance.model.service;

import java.util.ArrayList;

import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;

public interface AttendanceService {

	Attendance selectAttendance(String mNo);

	int insertAtime(Attendance a);

	int insertLtime(Attendance a);

	ArrayList<Attendance> selectAttendanceW(String mNo);

	ArrayList<Attendance> selectAttendanceM(String mNo);

	Attendance selectAttendanceCount(int cNo);

	int selectAttendanceACount(int cNo);

	ArrayList<Attendance> selectAttendanceCountList(PageInfo pi, int cNo);

	ArrayList<Attendance> selectAttendanceAllM(int cNo);

	ArrayList<Attendance> selectAttendanceWList(PageInfo pi, int cNo);

	ArrayList<Attendance> selectAttendanceMList(PageInfo pi, ArrayList<Member> mList);

	ArrayList<Attendance> searchAttendanceList(PageInfo pi, Attendance a);

	int searchAttendanceListCount(Attendance a);

	Attendance MonthCount(String mNo);

}
