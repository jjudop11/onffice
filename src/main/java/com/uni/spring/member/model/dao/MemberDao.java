package com.uni.spring.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.member.model.dto.Member;


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

}
