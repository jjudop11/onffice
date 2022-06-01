package com.uni.spring.approval.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;
import com.uni.spring.common.PageInfo;
import com.uni.spring.member.model.dto.Member;

@Repository
public class ApprovalDao {

	// 전자결재문서 
	public int insertApproval(SqlSession sqlSession, Approval ap) {
		return sqlSession.insert("ApprovalMapper.insertApproval", ap);
	}

	// 결재선 
	public int insertApprovalLine(SqlSession sqlSession, ApprovalLine apline) {
		return sqlSession.insert("ApprovalMapper.insertApprovalLine", apline);
	}

	// 첨부파일 
	public int insertFormAtt(SqlSession sqlSession, FormAtt att) {
		return sqlSession.insert("ApprovalMapper.insertFormAtt", att);
	}

	// 휴가신청서 
	public int insertDayoffForm(SqlSession sqlSession, DayoffForm doForm) {
		return sqlSession.insert("ApprovalMapper.insertDayoffForm", doForm);
	}

	// 사업기획서 
	public int insertProposalForm(SqlSession sqlSession, ProposalForm prForm) {
		return sqlSession.insert("ApprovalMapper.insertProposalForm", prForm);
	}

	// 지출결의서 
	public int insertPaymentForm(SqlSession sqlSession, PaymentForm payForm) {
		return sqlSession.insert("ApprovalMapper.insertPaymentForm", payForm);
	}

	// 결재선 사원 검색
	public ArrayList<Member> selectMemberList(SqlSession sqlSession, Map<String, Object> memberMap) {
		return (ArrayList)sqlSession.selectList("ApprovalMapper.selectMemberList", memberMap);
	}

}
