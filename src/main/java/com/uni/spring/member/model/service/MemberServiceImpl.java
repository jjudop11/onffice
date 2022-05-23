package com.uni.spring.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.member.model.dao.MemberDao;
import com.uni.spring.member.model.dto.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public void insertCMember(Company c) {
		
		int result = memberDao.insertCMember(sqlsession, c);
		
		if(result < 0) { // 회원가입실패
			throw new CommException("회사계정 회원등록에 실패하였습니다"); 
		}
		
	}

	@Override
	public Member loginUser(BCryptPasswordEncoder bCryptPasswordEncoder, Member m) {
		
		Member logUser = memberDao.loginUser(sqlsession, m);
		
		if(logUser == null) {
			throw new CommException("해당 ID로 가입한 계정이 없거나 잠긴계정입니다");
		}
		
		if(!bCryptPasswordEncoder.matches(m.getMPwd(), logUser.getMPwd())) { // 일치하지않을때
			
			int result = memberDao.updatePwd(sqlsession, m.getMId());
			
			if(result > 0) {
				int pwdError = Integer.parseInt(logUser.getMPwdError()) + 1;
				throw new CommException("비밀번호를" + pwdError +"회 틀렸습니다");
			}
			
		}
		
		return logUser;
	}

}
