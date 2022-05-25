package com.uni.spring.approval.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.formAtt;
import com.uni.spring.common.exception.CommException;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ApprovalDao approvalDao;

//	@Override
//	public void insertApproval(Approval ap, formAtt att) { // 기안작성 결재요청
//		
//		int result1 = approvalDao.insertApproval(sqlSession, ap); // 전자결재문서
//		
//		int result2 = 1;
//		if(att != null) {
//			result2 = approvalDao.insertApprovalAtt(sqlSession, att); // 첨부파일 
//		}
//		
//		if(result1 * result2 < 0) {
//			throw new CommException("게시글 등록 실패");
//		}
//		
//	}
	
	@Override
	public void insertApproval(Approval ap, ApprovalLine apline) { // 기안작성
		
		int result1 = approvalDao.insertApproval(sqlSession, ap);
		int result2 = approvalDao.insertApprovalLine(sqlSession, apline);
		
		System.out.println("SERVICE : " + ap);
		System.out.println("SERVICE : " + apline);
		
		if(result1 * result2 < 0) {
			throw new CommException("기안 작성 실패");
		}
		
	}

	@Override
	public void insertApprovalAtt(formAtt att) {
		
		int result = approvalDao.insertApprovalAtt(sqlSession, att);
		
		if(result < 0) {
			throw new CommException("첨부파일 등록 실패");
		}
		
	}
	
}
