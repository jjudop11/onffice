package com.uni.spring.job.model.service;

import java.util.ArrayList;

import com.uni.spring.job.model.dto.Job;

public interface JobService {

	ArrayList<Job> selectJobList(int cNo);

	int deletejd(Job job);

	int insertjd(Job job);

	int updatejd(Job job);

}
