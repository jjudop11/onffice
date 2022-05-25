package com.uni.spring.approval.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.formAtt;

@Repository
public class ApprovalDao {

	// 기안작성 - 전자결재문서 
	public int insertApproval(SqlSession sqlSession, Approval ap) {
		return sqlSession.insert("ApprovalMapper.insertApproval", ap);
	}

	// 기안작성 - 결재선 
	public int insertApprovalLine(SqlSession sqlSession, ApprovalLine apline) {
		return sqlSession.insert("ApprovalMapper.insertApprovalLine", apline);
	}

	// 기안작성 - 첨부파일 
	public int insertApprovalAtt(SqlSession sqlSession, formAtt att) {
		return sqlSession.insert("ApprovalMapper.insertApprovalAtt", att);
	}

}
