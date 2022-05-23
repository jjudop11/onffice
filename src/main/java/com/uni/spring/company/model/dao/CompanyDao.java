package com.uni.spring.company.model.dao;

import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.company.model.dto.Company;

@Repository 
public class CompanyDao {

	public int insertCompany(SqlSessionTemplate sqlsession, Company c) {
		
		return sqlsession.insert("companyMapper.insertCompany", c);
	}

	public int idCheck(SqlSessionTemplate sqlsession, String id) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("companyMapper.idCheck", id);
	}

	public int rNumCheck(SqlSessionTemplate sqlsession, String rNum) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("companyMapper.rNumCheck", rNum);
	}

}
