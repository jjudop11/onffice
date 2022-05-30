package com.uni.spring.attendance.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.member.model.dto.Member;

@Repository
public class AttendanceDao {
	
	public Attendance selectAttendance(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AttendanceMapper.selectAttendance", mNo);
	}

	public int insertAtime(SqlSessionTemplate sqlSession, Attendance a) {
		// TODO Auto-generated method stub
		return sqlSession.insert("AttendanceMapper.insertAtime", a);
	}

	public int insertLtime(SqlSessionTemplate sqlSession, Attendance a) {
		// TODO Auto-generated method stub
		return sqlSession.update("AttendanceMapper.insertLtime", a);
	}

	public int insertWtime(SqlSessionTemplate sqlSession, Attendance a) {
		// TODO Auto-generated method stub
		return sqlSession.update("AttendanceMapper.insertWtime", a);
	}

	public ArrayList<Attendance> selectAttendanceW(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceW", mNo);
	}

	public ArrayList<Attendance> selectAttendanceM(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceM", mNo);
	}


}
