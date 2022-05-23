package com.uni.spring.company.model.service;

import com.uni.spring.company.model.dto.Company;

public interface CompanyService {

	void insertCompany(Company c);

	int idCheck(String id);

	int rNumCheck(String rNum);

}
