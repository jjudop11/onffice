package com.uni.spring.car.model.service;

import java.util.ArrayList;

import com.uni.spring.car.model.dto.Car;
import com.uni.spring.car.model.dto.ReserveCar;
import com.uni.spring.common.PageInfo;

public interface CarService {

	int selectCarSetUser(String carSetUserId);

	int selectCarListCount(int userCNo);
	
	ArrayList<Car> selectCarList(PageInfo pi, int userCNo);

	int carNoCheck(String carNo);

	int insertCar(Car c);

	int deleteCars(String carNo);

	ArrayList<Car> selectList(int userCNo);

	int reserveingCar(ReserveCar car);

	void updateStatus(String reserveCarNo);

	ReserveCar selectReserveMNo(String reserveCarNo);

	void updateReturn(String reserveCarNo);

	ReserveCar selectReserveCar(String reserveCarNo);

	String selectUserName(String userNo);

	String selectUserJobName(String userNo);

	

}
