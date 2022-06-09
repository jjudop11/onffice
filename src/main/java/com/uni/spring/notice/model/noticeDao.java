package com.uni.spring.notice.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;
import com.uni.spring.common.SearchCondition;


@Repository
public class noticeDao {

	public int selectListCount(SqlSessionTemplate sqlsession, int companyNo) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectListCount", companyNo);
	}
	
	public ArrayList<notice> selectList(SqlSessionTemplate sqlsession, PageInfo pi, int companyNo) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("noticeMapper.selectList", companyNo, rowBounds);
	}

	public int insertNotice(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.insert("noticeMapper.insertNotice", n);
	}

	public int deleteNotice(SqlSessionTemplate sqlsession, int No_Num) {
		return sqlsession.update("noticeMapper.deleteNotice", No_Num);
	}

	public int updateNotice(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.update("noticeMapper.updateNotice", n);
	}

	public notice selectNotice(SqlSessionTemplate sqlsession, int no_Num) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectNotice", no_Num);
	}

	public ArrayList<notice> searchList(SqlSessionTemplate sqlsession, SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("noticeMapper.searchList", sc, rowBounds);
	}

	public int getsearchList(SqlSessionTemplate sqlsession, SearchCondition sc) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.getListCount", sc);
	}


}
