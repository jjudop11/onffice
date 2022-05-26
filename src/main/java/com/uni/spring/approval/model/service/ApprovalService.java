package com.uni.spring.approval.model.service;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;

public interface ApprovalService {

	void insertApproval(Approval ap); // 전자결재문서
	
	void insertApprovalLine(ApprovalLine apline); // 결재선 

	void insertFormAtt(FormAtt att); // 첨부파일 

	void insertDayoffForm(DayoffForm doForm); // 휴가신청서

	void insertProposalForm(ProposalForm prForm); // 사업기획서 

	void insertPaymentForm(PaymentForm payForm); // 지출결의서 
	
}
