package com.uni.spring.member.model.service;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.uni.spring.company.model.dto.Company;
import com.uni.spring.member.model.dto.Member;

public interface MemberService {

	void insertCMember(Company c);

	Member loginUser(BCryptPasswordEncoder bCryptPasswordEncoder, Member m);

}
