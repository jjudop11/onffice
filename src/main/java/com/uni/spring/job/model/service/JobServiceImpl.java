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
	public ArrayList<Job> deletejd(Job job) {
		
		int result = jobDao.deletejd(sqlsession, job);
		
		if(result > 0) {
			return jobDao.selectJobList(sqlsession, job.getCNo());
		} else {
			throw new CommException("직급 삭제 실패했습니다");
		}
	}

	@Override
	public ArrayList<Job> insertjd(Job job) {
		
		int result = jobDao.insertjd(sqlsession, job);
		
		if(result > 0) {
			return jobDao.selectJobList(sqlsession, job.getCNo());
		} else {
			throw new CommException("직급 추가 실패했습니다");
		}
	}

}
