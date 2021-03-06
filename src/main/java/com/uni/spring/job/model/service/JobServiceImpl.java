package com.uni.spring.job.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.common.exception.CommException;
import com.uni.spring.job.model.dao.JobDao;
import com.uni.spring.job.model.dto.Job;

@Service
public class JobServiceImpl implements JobService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private JobDao jobDao;
	
	@Override
	public ArrayList<Job> selectJobList(int cNo) {
		// TODO Auto-generated method stub
		return jobDao.selectJobList(sqlsession, cNo);
	}

	@Override
	public int deletejd(Job job) {
		
		return jobDao.deletejd(sqlsession, job);
	}

	@Override
	public int insertjd(Job job) {
		
		return jobDao.insertjd(sqlsession, job);

	}

	@Override
	public int updatejd(Job job) {
		// TODO Auto-generated method stub
		return jobDao.updatejd(sqlsession, job);
	}

}
