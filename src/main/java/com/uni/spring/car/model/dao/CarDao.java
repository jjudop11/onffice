package com.uni.spring.car.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.car.model.dto.Car;
import com.uni.spring.car.model.dto.ReserveCar;
import com.uni.spring.common.PageInfo;

@Repository
public class CarDao {

	public int selectCarSetUser(SqlSessionTemplate sqlsession, String carSetUserId) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapper.selectCarSetUser", carSetUserId);
	}

	public int selectCarListCount(SqlSessionTemplate sqlsession, int userCNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapper.selectCarListCount", userCNo);
	}
	
	public ArrayList<Car> selectCarList(SqlSessionTemplate sqlsession,  PageInfo pi, int userCNo) {
		// TODO Auto-generated method stub
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("CarMapper.selectCarList", userCNo, rowBounds);
	}

	public int carNoCheck(SqlSessionTemplate sqlsession, String carNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapper.carNoCheck", carNo);
	}

	public int insertCar(SqlSessionTemplate sqlsession, Car c) {
		// TODO Auto-generated method stub
		return sqlsession.insert("CarMapper.insertCar", c);
	}

	public int deleteCars(SqlSessionTemplate sqlsession, String carNo) {
		// TODO Auto-generated method stub
		return sqlsession.delete("CarMapper.deleteCars", carNo);
	}

	public ArrayList<Car> selectList(SqlSessionTemplate sqlsession, int userCNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlsession.selectList("CarMapper.selectCarList", userCNo);
	}

	public int reserveingCar(SqlSessionTemplate sqlsession, ReserveCar car) {
		// TODO Auto-generated method stub
		return sqlsession.insert("CarMapper.reserveingCar", car);
	}

	public void updateStatus(SqlSessionTemplate sqlsession, String reserveCarNo) {
		// TODO Auto-generated method stub
		sqlsession.update("CarMapper.updateStatus", reserveCarNo);
	}

	public ReserveCar selectReserveMNo(SqlSessionTemplate sqlsession, String reserveCarNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapper.selectReserveMNo", reserveCarNo);
	}

	public void updateReturn(SqlSessionTemplate sqlsession, String reserveCarNo) {
		// TODO Auto-generated method stub
		sqlsession.update("CarMapper.updateReturn", reserveCarNo);
	}

	public ReserveCar selectReserveCar(SqlSessionTemplate sqlsession, String reserveCarNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapeer.selectReserveCar", reserveCarNo);
	}

	public String selectUserName(SqlSessionTemplate sqlsession, String userNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapeer.selectUserName", userNo);
	}

	public String selectUserJobName(SqlSessionTemplate sqlsession, String userNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("CarMapeer.selectUserJobName", userNo);
	}

	

}
