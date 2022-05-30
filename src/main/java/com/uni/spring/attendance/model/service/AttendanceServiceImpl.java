package com.uni.spring.attendance.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.attendance.model.dao.AttendanceDao;
import com.uni.spring.attendance.model.dto.Attendance;
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
		
		return result * result2;
	}


	
}
