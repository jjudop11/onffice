package com.uni.spring.approval.model.service;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.formAtt;

public interface ApprovalService {

	void insertApproval(Approval ap, ApprovalLine apline); // 기안작성 

	void insertApprovalAtt(formAtt att); // 기안작성 - 첨부파일 
	
}
