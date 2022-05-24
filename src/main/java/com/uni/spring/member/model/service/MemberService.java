package com.uni.spring.member.model.service;

import java.util.ArrayList;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.common.PageInfo;
import com.uni.spring.company.model.dto.Company;
import com.uni.spring.dept.model.dto.Dept;
import com.uni.spring.job.model.dto.Job;
import com.uni.spring.member.model.dto.Member;


public interface MemberService {

	void insertCMember(Company c);

	Member loginUser(BCryptPasswordEncoder bCryptPasswordEncoder, Member m);

	int selectMemListCount(int cNo);

	ArrayList<Member> selectMemList(PageInfo pi, int cNo);

}
