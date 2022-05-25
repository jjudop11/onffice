package com.uni.spring.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.dto.Photo;


@Repository
public class MemberDao {

	public int insertCMember(SqlSessionTemplate sqlsession, Company c) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MemberMapper.insertCMember", c);
	}

	public Member loginUser(SqlSessionTemplate sqlsession, Member m) {
		
		Member loginUser = sqlsession.selectOne("MemberMapper.loginUser", m);
		
		return loginUser;
	}

	public int updatePwd(SqlSessionTemplate sqlsession, String mId) {
		
		return sqlsession.update("MemberMapper.updatePwd", mId);
		
	}

	public int selectMemListCount(SqlSessionTemplate sqlsession, int cNo) {
	
		return sqlsession.selectOne("MemberMapper.selectMemListCount", cNo);
	}

	public ArrayList<Member> selectMemList(SqlSessionTemplate sqlsession, PageInfo pi, int cNo) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("MemberMapper.selectMemList", cNo, rowBounds);
	}

	public int insertMember(SqlSessionTemplate sqlsession, Member m) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MemberMapper.insertMember", m);
	}

	public Member selectMember(SqlSessionTemplate sqlsession, String mNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("MemberMapper.selectMember", mNo);
	}

	public int updateMember(SqlSessionTemplate sqlsession, Member m) {
		// TODO Auto-generated method stub
		return sqlsession.update("MemberMapper.updateMember", m);
	}

	public int deleteMember(SqlSessionTemplate sqlsession, String mNo) {
		// TODO Auto-generated method stub
		return sqlsession.update("MemberMapper.deleteMember", mNo);
	}

	public int updateMypage(SqlSessionTemplate sqlsession, Member m) {
		// TODO Auto-generated method stub
		return sqlsession.update("MemberMapper.updateMypage", m);
	}

	public int updatePassword(SqlSessionTemplate sqlsession, Member loginUser) {
		// TODO Auto-generated method stub
		return sqlsession.update("MemberMapper.updatePassword", loginUser);
	}

	public int resetPwd(SqlSessionTemplate sqlsession, Member m) {
		// TODO Auto-generated method stub
		return sqlsession.update("MemberMapper.resetPwd", m);
	}

	public int insertPhoto(SqlSessionTemplate sqlsession, Photo p) {
		// TODO Auto-generated method stub
		return sqlsession.insert("MemberMapper.insertPhoto", p);
	}

}
