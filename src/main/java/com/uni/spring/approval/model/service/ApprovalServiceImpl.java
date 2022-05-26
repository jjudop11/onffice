package com.uni.spring.approval.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;
import com.uni.spring.common.exception.CommException;

@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private ApprovalDao approvalDao;
	
	// 전자결재문서 
	@Override
	public void insertApproval(Approval ap) { 
		
		int result = approvalDao.insertApproval(sqlSession, ap);
		
		if(result < 0) {
			throw new CommException("기안 작성 실패");
		}
		
	}
	
	// 결재선 
	@Override
	public void insertApprovalLine(ApprovalLine apline) {
		
		int result = approvalDao.insertApprovalLine(sqlSession, apline);
		
		if(result < 0) {
			throw new CommException("결재선 등록 실패");
		}
		
	}

	// 첨부파일 
	@Override
	public void insertFormAtt(FormAtt att) {
		
		int result = approvalDao.insertFormAtt(sqlSession, att);
		
		if(result < 0) {
			throw new CommException("첨부파일 등록 실패");
		}
		
	}

	// 휴가신청서 
	@Override
	public void insertDayoffForm(DayoffForm doForm) {
		
		int result = approvalDao.insertDayoffForm(sqlSession, doForm);
		
		if(result < 0) {
			throw new CommException("휴가신청서 등록 실패");
		}
		
	}

	// 사업기획서
	@Override
	public void insertProposalForm(ProposalForm prForm) {
		
		int result = approvalDao.insertProposalForm(sqlSession, prForm);
		
		if(result < 0) {
			throw new CommException("사업기획서 등록 실패");
		}
		
	}

	// 지출결의서 
	@Override
	public void insertPaymentForm(PaymentForm payForm) {
		
		int result = approvalDao.insertPaymentForm(sqlSession, payForm);
		
		if(result < 0) {
			throw new CommException("지출결의서 등록 실패");
		}
		
	}
	
}
