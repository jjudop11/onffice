package com.uni.spring.notice.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.common.PageInfo;


@Repository
public class noticeDao {

	public int selectListCount(SqlSessionTemplate sqlsession) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectListCount");
	}

	public notice selectNotice(SqlSessionTemplate sqlsession, int bno) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectNotice", bno);
	}

	public void updateCount(SqlSessionTemplate sqlsession, int bno) {
		sqlsession.update("noticeMapper.updateCount", bno);
	}

	public int insertNotice(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.insert("noticeMapper.insertNotice", n);
	}

	public int deleteNotice(SqlSessionTemplate sqlsession, int bno) {
		return sqlsession.update("noticeMapper.deleteNotice", bno);
	}

	public int updateNotice(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.update("noticeMapper.updateNotice", n);
	}

	public ArrayList<notice> selectList(SqlSessionTemplate sqlsession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("noticeMapper.selectList", null, rowBounds);
	}


}
