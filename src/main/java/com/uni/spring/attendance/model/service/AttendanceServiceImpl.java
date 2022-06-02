package com.uni.spring.attendance.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.attendance.model.dao.AttendanceDao;
import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.exception.CommException;
import com.uni.spring.member.model.dto.Member;

@Service
public class AttendanceServiceImpl implements AttendanceService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private AttendanceDao attendanceDao;
	
	@Override
	public Attendance selectAttendance(String mNo) {
		
		return attendanceDao.selectAttendance(sqlsession, mNo);
	}
	
	@Override
	public ArrayList<Attendance> selectAttendanceW(String mNo) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceW(sqlsession, mNo);
	}
	
	@Override
	public ArrayList<Attendance> selectAttendanceM(String mNo) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceM(sqlsession, mNo);
	}



	@Override
	public int insertAtime(Attendance a) {
		
		int result = attendanceDao.insertAtime(sqlsession, a);
		
		if(result < 1) {
			throw new CommException("출근 등록 실패");
		}
		return result;
		
	}

	@Override
	public int insertLtime(Attendance a) {
		
		int result = attendanceDao.insertLtime(sqlsession, a);
		int result2 = attendanceDao.insertWtime(sqlsession, a);
		
		if(result * result2 < 1) {
			throw new CommException("퇴근 등록 실패");
		}
		
		return result * result2;
	}
	
	@Override
	public int selectAttendanceACount(int cNo) {
	
		return attendanceDao.selectAttendanceACount(sqlsession, cNo);
	}

	@Override
	public Attendance selectAttendanceCount(int cNo) {
	
		return attendanceDao.selectAttendanceCount(sqlsession, cNo);
	}

	@Override
	public ArrayList<Attendance> selectAttendanceCountList(PageInfo pi, int cNo) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceCountList(sqlsession, pi, cNo);
	}

	@Override
	public ArrayList<Attendance> selectAttendanceCountList(int cNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Attendance> selectAttendanceAllM(int cNo) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceAllM(sqlsession, cNo);
	}

	@Override
	public ArrayList<Attendance> selectAttendanceWList(PageInfo pi, int cNo) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceWList(sqlsession, cNo);
	}

	@Override
	public ArrayList<Attendance> selectAttendanceMList(PageInfo pi, ArrayList<Member> mList) {
		// TODO Auto-generated method stub
		return attendanceDao.selectAttendanceMList(sqlsession, mList);
	}



	
}
