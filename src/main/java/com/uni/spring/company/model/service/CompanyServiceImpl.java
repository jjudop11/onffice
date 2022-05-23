package com.uni.spring.company.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.company.model.dao.CompanyDao;

import com.uni.spring.company.model.dto.Company;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private CompanyDao comapanyDao;
	
	@Override
	public void insertCompany(Company c) {
		
		int result = comapanyDao.insertCompany(sqlsession, c);
		
		if(result < 0) { // 회원가입실패
			throw new CommException("회사계정생성에 실패하였습니다"); 
		}
	}

	@Override
	public int idCheck(String id) {
		
		int result = comapanyDao.idCheck(sqlsession, id);
		
		if(result < 0) {
			throw new CommException("아이디 중복체크 실패");
		}
		return result;
	}

	@Override
	public int rNumCheck(String rNum) {
		
		int result = comapanyDao.rNumCheck(sqlsession, rNum);
		
		if(result < 0) {
			throw new CommException("사업자등록번호 중복체크 실패");
		}
		return result;
	}
	
	
}
