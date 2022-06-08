package com.uni.spring.approval.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.uni.spring.approval.model.dto.ApList;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;
import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;

public interface ApprovalService {

	void insertApproval(Approval ap); // 전자결재문서
	
	void insertApprovalLine(ApprovalLine apline); // 결재선 

	void insertFormAtt(FormAtt att); // 첨부파일 

	void insertDayoffForm(DayoffForm doForm); // 휴가신청서

	void insertProposalForm(ProposalForm prForm); // 사업기획서 

	void insertPaymentForm(PaymentForm payForm); // 지출결의서 

	ArrayList<Member> selectMemberList(Map<String, Object> memberMap); // 결재선 사원 검색

	int selectListCount();

	ArrayList<ApList> selectList(PageInfo pi, Map<String, Object> listMap);

	DayoffForm selectApprovalOngoingDo(int apNo);
	
	ProposalForm selectApprovalOngoingPr(int apNo);
	
	PaymentForm selectApprovalOngoingPay(int apNo);

	FormAtt selectApprovalOngoingAtt(int apNo);
	
	ArrayList<Member> selectApprovalOngoingApLine(int apNo);
	
	void deleteApproval(int apNo);

	void updateDayoffForm(DayoffForm doForm);

	void updateProposalForm(ProposalForm prForm);

	void updatePaymentForm(PaymentForm payForm);

	void updateFormAtt(FormAtt att);

	int selectRequestListCount(String mNo);
	
	ArrayList<ApList> selectRequestList(PageInfo pi, Map<String, Object> listMap); // 결재요청 리스트
	
}
