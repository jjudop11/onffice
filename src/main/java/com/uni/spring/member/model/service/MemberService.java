package com.uni.spring.member.model.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.attendance.model.dto.Attendance;
import com.uni.spring.common.PageInfo;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.job.model.dto.Job;
import com.uni.spring.member.model.dto.Alram;
import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.dto.Photo;
import com.uni.spring.member.model.dto.RememberLogin;


public interface MemberService {

	void insertCMember(Company c);

	Member loginUser(BCryptPasswordEncoder bCryptPasswordEncoder, Member m);

	int selectMemListCount(int cNo);

	ArrayList<Member> selectMemList(PageInfo pi, int cNo);

	void insertMember(Member m);

	Member selectMember(String mNo);

	Member updateMember(Member m);

	void deleteMember(String mNo);

	Member updateMypage(Member m);

	Member updatePassword(BCryptPasswordEncoder bCryptPasswordEncoder, Member loginUser, String pwd, String encPwd);

	Member resetPwd(Member m);

	void insertPhoto(Photo p);

	void updatePhoto(Photo p);

	Member findPwd(Member m);

	int searchMemListCount(Member m);

	ArrayList<Member> searchMemList(PageInfo pi, Member m);

	void insertAlram(ArrayList<Alram> aList);

	ArrayList<Alram> selectAlramList(String mNo);

	int deleteAlram(Alram a);

	void insertRemember(RememberLogin r);

	Member selectRemember(String sessionId);

	void deleteRemember(Member loginUser);

}
