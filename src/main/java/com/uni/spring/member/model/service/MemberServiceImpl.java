package com.uni.spring.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.exception.CommException;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.member.model.dao.MemberDao;
import com.uni.spring.member.model.dto.Alram;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.dto.Photo;
import com.uni.spring.member.model.dto.RememberLogin;

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
		
		Member loginUser = memberDao.loginUser(sqlsession, m);
		
		if(loginUser == null) {
			throw new CommException("해당 ID로 가입한 계정이 없거나 잠긴계정입니다");
		} 
		
		if(!bCryptPasswordEncoder.matches(m.getMPwd(), loginUser.getMPwd())) { // 일치하지않을때
			
			int result = memberDao.updatePwd(sqlsession, m.getMId());
			
			if(result > 0) {
				loginUser.setMPwd("99");
			} else {
				throw new CommException("비밀번호 오류");
			}
		}
		
		return loginUser;
	}

	@Override
	public int selectMemListCount(int cNo) {
		
		return memberDao.selectMemListCount(sqlsession, cNo);
	}

	@Override
	public ArrayList<Member> selectMemList(PageInfo pi, int cNo) {
		// TODO Auto-generated method stub
		return memberDao.selectMemList(sqlsession, pi, cNo);
	}

	@Override
	public void insertMember(Member m) {
		
		int result = memberDao.insertMember(sqlsession, m);
		
		if(result < 0) { // 신규사원실패
			throw new CommException("사원등록에 실패하였습니다"); 
		}
		
	}

	@Override
	public Member selectMember(String mNo) {
		
		Member m = memberDao.selectMember(sqlsession, mNo);
		
		if(m != null) {
			return  m;
		} else {
			throw new CommException("사원 상세 조회 실패하였습니다");
		}
	}

	@Override
	public Member updateMember(Member m) {
		
		int result = memberDao.updateMember(sqlsession, m);
		
		if(result > 0) { 
			Member updateMem = memberDao.selectMember(sqlsession, m.getMNo());
			return updateMem;
		} else {
			throw new CommException("사원정보수정 실패하였습니다");
		}
	}

	@Override
	public void deleteMember(String mNo) {
		
		int result = memberDao.deleteMember(sqlsession, mNo);
		
		if(result < 0) { // 퇴사 등록실패
			throw new CommException("퇴사자 등록 실패하였습니다"); 
		}
	}

	@Override
	public Member updateMypage(Member m) {
		
		int result = memberDao.updateMypage(sqlsession, m);
		
		if(result > 0) { 
			Member loginUser = memberDao.loginUser(sqlsession, m);
			return loginUser;
		} else {
			throw new CommException("내정보수정 실패하였습니다");
		}
	}

	@Override
	public Member updatePassword(BCryptPasswordEncoder bCryptPasswordEncoder, Member loginUser, String pwd,
			String encPwd) {
		
		if(!bCryptPasswordEncoder.matches(pwd, loginUser.getMPwd())) {
			throw new CommException("기존 비밀번호 불일치");
			
		} else {
			loginUser.setMPwd(encPwd);
			int result = memberDao.updatePassword(sqlsession, loginUser);
			
			if(result > 0) { 
				Member updateMem = memberDao.loginUser(sqlsession, loginUser);
				return updateMem;	
			} else {
				throw new CommException("비밀번호변경 실패");
			}
		}
	}

	@Override
	public Member resetPwd(Member m) {
		
		int result = memberDao.resetPwd(sqlsession, m);
		
		if(result < 0) { 
			throw new CommException("비밀번호 초기화 실패하였습니다"); 
		} else {
			Member updateMem = memberDao.loginUser(sqlsession, m);
			return updateMem;	
		}
	}

	@Override
	public void insertPhoto(Photo p) {
		
		int result = memberDao.insertPhoto(sqlsession, p);
		
		if(result < 0) { 
			throw new CommException("사진등록에 실패하였습니다"); 
		}	
		
	}

	@Override
	public void updatePhoto(Photo p) {
		
		int result = memberDao.updatePhoto(sqlsession, p);
		
		if(result < 0) { 
			throw new CommException("사진변경에 실패하였습니다"); 
		}	
		
	}

	@Override
	public Member findPwd(Member m) {
		
		Member mem = memberDao.findPwd(sqlsession, m);
		
		if(mem != null) {
			return  mem;
		} else {
			throw new CommException("해당 ID와 EMAIL로 가입된 계정이 없습니다");
		}
	}

	@Override
	public int searchMemListCount(Member m) {
		// TODO Auto-generated method stub
		return memberDao.searchMemListCount(sqlsession, m);
	}

	@Override
	public ArrayList<Member> searchMemList(PageInfo pi, Member m) {
		// TODO Auto-generated method stub
		return memberDao.searchMemList(sqlsession, pi, m);
	}

	@Override
	public void insertAlram(ArrayList<Alram> aList) {
		// TODO Auto-generated method stub
		memberDao.insertAlram(sqlsession, aList);
		
	}

	@Override
	public ArrayList<Alram> selectAlramList(String mNo) {
		// TODO Auto-generated method stub
		return memberDao.selectAlramList(sqlsession, mNo);
	}

	@Override
	public int deleteAlram(Alram a) {
		// TODO Auto-generated method stub
		return memberDao.deleteAlram(sqlsession, a);
	}

	@Override
	public void insertRemember(RememberLogin r) {
		// TODO Auto-generated method stub
		memberDao.insertRemember(sqlsession, r);
	}

	@Override
	public Member selectRemember(String sessionId) {
		// TODO Auto-generated method stub
		return memberDao.selectRemember(sqlsession, sessionId);
	}

	@Override
	public void deleteRemember(Member loginUser) {
		// TODO Auto-generated method stub
		memberDao.deleteRemember(sqlsession, loginUser);
	}

}
