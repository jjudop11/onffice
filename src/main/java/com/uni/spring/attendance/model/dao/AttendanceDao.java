package com.uni.spring.attendance.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.common.PageInfo;
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

	public Attendance selectAttendanceCount(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AttendanceMapper.selectAttendanceCount", cNo);
	}

	public int selectAttendanceACount(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AttendanceMapper.selectAttendanceACount", cNo);
	}
	
	public ArrayList<Attendance> selectAttendanceCountList(SqlSessionTemplate sqlSession, PageInfo pi ,int cNo) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceCountList", cNo, rowBounds);
	}

	public ArrayList<Attendance> selectAttendanceAllM(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceAllM", cNo);
	}

	public ArrayList<Attendance> selectAttendanceWList(SqlSessionTemplate sqlSession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceWList", cNo);
	}

	public ArrayList<Attendance> selectAttendanceMList(SqlSessionTemplate sqlSession, ArrayList<Member> mList) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("AttendanceMapper.selectAttendanceMList", mList);
	}

	public ArrayList<Attendance> searchAttendanceList(SqlSessionTemplate sqlSession, PageInfo pi, Attendance a) {
		// TODO Auto-generated method stub
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("AttendanceMapper.searchAttendanceList", a, rowBounds);
	}

	public int searchAttendanceListCount(SqlSessionTemplate sqlSession, Attendance a) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AttendanceMapper.searchAttendanceListCount", a);
	}

	public Attendance MonthCount(SqlSessionTemplate sqlSession, String mNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AttendanceMapper.MonthCount", mNo);
	}


}
