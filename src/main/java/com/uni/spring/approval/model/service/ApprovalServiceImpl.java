package com.uni.spring.approval.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.uni.spring.approval.model.dao.ApprovalDao;
import com.uni.spring.approval.model.dto.ApList;
import com.uni.spring.approval.model.dto.Approval;
import com.uni.spring.approval.model.dto.ApprovalLine;
import com.uni.spring.approval.model.dto.DayoffForm;
import com.uni.spring.approval.model.dto.FormAtt;
import com.uni.spring.approval.model.dto.PaymentForm;
import com.uni.spring.approval.model.dto.ProposalForm;
import com.uni.spring.common.PageInfo;
import com.uni.spring.common.exception.CommException;
import com.uni.spring.member.model.dto.Member;

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
	public void insertApprovalLine(Map<String, Object> apprLineMap) {
		
		int result = approvalDao.insertApprovalLine(sqlSession, apprLineMap);
		
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

	// 결재선 사원 검색
	@Override
	public ArrayList<Member> selectMemberList(Map<String, Object> memberMap) {
		return approvalDao.selectMemberList(sqlSession, memberMap);
	}

	@Override
	public int selectListCount() {
		return approvalDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<ApList> selectList(PageInfo pi, Map<String, Object> listMap) {
		return approvalDao.selectList(sqlSession, pi, listMap);
	}

	@Override
	public DayoffForm selectApprovalOngoingDo(int apNo) {
		return approvalDao.selectApprovalOngoingDo(sqlSession, apNo);
	}

	@Override
	public ProposalForm selectApprovalOngoingPr(int apNo) {
		return approvalDao.selectApprovalOngoingPr(sqlSession, apNo);
	}

	@Override
	public PaymentForm selectApprovalOngoingPay(int apNo) {
		return approvalDao.selectApprovalOngoingPay(sqlSession, apNo);
	}
	
	@Override
	public FormAtt selectApprovalOngoingAtt(int apNo) {
		return approvalDao.selectApprovalOngoingAtt(sqlSession, apNo);
	}
	
	@Override
	public Member selectApprovalOngoingApLine(int apNo) {
		return approvalDao.selectApprovalOngoingApLine(sqlSession, apNo);
	}

	@Override
	public void deleteApproval(int apNo) {
		
		int result = approvalDao.deleteApproval(sqlSession, apNo);
		
		if(result < 0) {
			throw new CommException("전자결재문서 삭제 실패");
		}
		
	}

	@Override
	public void updateDayoffForm(DayoffForm doForm) {
		
		int result = approvalDao.updateDayoffForm(sqlSession, doForm);
		
		if(result < 0) {
			throw new CommException("휴가신청서 수정 실패");
		}
	}

	@Override
	public void updateProposalForm(ProposalForm prForm) {
		
		int result = approvalDao.updateProposalForm(sqlSession, prForm);
		
		if(result < 0) {
			throw new CommException("프로젝트기획서 수정 실패");
		}
	}

	@Override
	public void updatePaymentForm(PaymentForm payForm) {
		
		int result = approvalDao.updatePaymentForm(sqlSession, payForm);
		
		if(result < 0) {
			throw new CommException("지출결의서 수정 실패");
		}
	}

	@Override
	public void updateFormAtt(FormAtt att) {
		
		int result = approvalDao.updateFormAtt(sqlSession, att);
		
		if(result < 0) {
			throw new CommException("첨부파일 수정 실패");
		}
	}
	
	@Override
	public int selectRequestListCount(String mNo) {
		return approvalDao.selectRequestListCount(sqlSession, mNo);
	}

	@Override
	public ArrayList<ApList> selectRequestList(PageInfo pi, Map<String, Object> listMap) {
		return approvalDao.selectRequestList(sqlSession, pi, listMap);
	}

	@Override
	public int selecetApprovalStatus(int apNo) {
		return approvalDao.selecetApprovalStatus(sqlSession, apNo);
	}

	@Override
	public Member selectApprovalWriter(int apNo) {
		return approvalDao.selectApprovalWriter(sqlSession, apNo);
	}

	@Override
	public void updateApprPermit(Map<String, Object> apprMap) {
		int result = approvalDao.updateApprPermit(sqlSession, apprMap);
		
		if(result < 0) {
			throw new CommException("승인 실패");
		}
	}
	
	@Override
	public void updateApprRefuse(Map<String, Object> apprMap) {
		
		int result = approvalDao.updateApprRefuse(sqlSession, apprMap);
		
		if(result < 0) {
			throw new CommException("승인 실패");
		}
		
	}

	@Override
	public int selectCompleteListCount() {
		return approvalDao.selectCompleteListCount(sqlSession);
	}

	@Override
	public ArrayList<ApList> selectCompleteList(PageInfo pi, Map<String, Object> listMap) {
		return approvalDao.selectCompleteList(sqlSession, pi, listMap);
	}

	@Override
	public Member selecetApLineStatus(Map<String, Object> apprMap) {
		return approvalDao.selecetApLineStatus(sqlSession, apprMap);
	}

	@Override
	public void updateApStatus(int apNo) {
		int result = approvalDao.updateApStatus(sqlSession, apNo);
		
		if(result < 0) {
			throw new CommException("최종 결재 상태 업데이트 실패");
		}
	}

	@Override
	public int selectAllowListCount() {
		return approvalDao.selectAllowListCount(sqlSession);
	}

	@Override
	public ArrayList<ApList> selectAllowList(PageInfo pi, Map<String, Object> listMap) {
		return approvalDao.selectAllowList(sqlSession, pi, listMap);
	}

}
