package com.uni.spring.notice.model;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.uni.spring.notice.model.notice;


@Repository
public class noticeDao {

	public int selectListCount(SqlSessionTemplate sqlsession) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectListCount");
	}

	/*public ArrayList<notice> selectList(SqlSessionTemplate sqlsession, noticeInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlsession.selectList("noticeMapper.selectList", null, rowBounds);
	}*/

	public notice selectBoard(SqlSessionTemplate sqlsession, int bno) {
		// TODO Auto-generated method stub
		return sqlsession.selectOne("noticeMapper.selectNotice", bno);
	}

	public void updateCount(SqlSessionTemplate sqlsession, int bno) {
		sqlsession.update("noticeMapper.updateCount", bno);
	}

	public int insertBoard(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.insert("noticeMapper.insertNotice", n);
	}

	public int deleteBoard(SqlSessionTemplate sqlsession, int bno) {
		return sqlsession.update("noticeMapper.deleteNotice", bno);
	}

	public int updateBoard(SqlSessionTemplate sqlsession, notice n) {
		return sqlsession.update("noticeMapper.updateNotice", n);
	}


}
