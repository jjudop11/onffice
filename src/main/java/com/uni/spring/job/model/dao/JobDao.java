package com.uni.spring.job.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.job.model.dto.Job;

@Repository
public class JobDao {

	public ArrayList<Job> selectJobList(SqlSessionTemplate sqlsession, int cNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("JobMapper.selectJobList", cNo);
	}

	public int deletejd(SqlSessionTemplate sqlsession, Job job) {
		// TODO Auto-generated method stub
		return sqlsession.delete("JobMapper.deletejd", job);
	}

	public int insertjd(SqlSessionTemplate sqlsession, Job job) {
		// TODO Auto-generated method stub
		return sqlsession.insert("JobMapper.insertjd", job);
	}

	public int updatejd(SqlSessionTemplate sqlsession, Job job) {
		// TODO Auto-generated method stub
		return sqlsession.update("JobMapper.updatejd", job);
	}

}
