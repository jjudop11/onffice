package com.uni.spring.car.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.car.model.dao.CarDao;
import com.uni.spring.car.model.dto.Car;
import com.uni.spring.common.PageInfo;

@Service
public class CarServiceImple implements CarService {
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	@Autowired
	private CarDao carDao;

	@Override
	public int selectCarSetUser(String carSetUserId) {
		// TODO Auto-generated method stub
		int result = carDao.selectCarSetUser(sqlsession, carSetUserId);
		return result;
	}

	/* @Override
	public ArrayList<Car> selectCarList(int userCNo) {
		// TODO Auto-generated method stub	
		return carDao.selectCarList(sqlsession, userCNo);
	} */
	
	@Override
	public int selectCarListCount(int userCNo) {
		// TODO Auto-generated method stub
		return carDao.selectCarListCount(sqlsession, userCNo);
	}
	
	@Override
	public ArrayList<Car> selectCarList(PageInfo pi, int userCNo) {
		// TODO Auto-generated method stub	
		return carDao.selectCarList(sqlsession, pi, userCNo);
	}

	@Override
	public int carNoCheck(String carNo) {
		// TODO Auto-generated method stub
		return carDao.carNoCheck(sqlsession, carNo);
	}

	@Override
	public int insertCar(Car c) {
		// TODO Auto-generated method stub
		return carDao.insertCar(sqlsession, c);
	}

	@Override
	public int deleteCars(String carNo) {
		// TODO Auto-generated method stub
		return carDao.deleteCars(sqlsession, carNo);
	}

	@Override
	public ArrayList<Car> selectList(int userCNo) {
		// TODO Auto-generated method stub
		return carDao.selectList(sqlsession, userCNo);
	}

	

}
