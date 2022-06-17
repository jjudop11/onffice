package com.uni.spring.surveyBoard.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SurveyBoard {

	private long sbNo; 				// 설문 게시글 번호
	private String sbTitle; 		// 설문 게시글 제목
	private String sbSurveyInfo;    // 설문 게시글 설명
	private String sbStartDate;		// 설문 게시글 시작 날짜
	private String sbEndDate;		// 설문 게시글 끝 날짜
	private String sbResultState;	// 설문 게시글 결과 공개 상태 ('Y' , 'N')
	private String sbFounderNo;		// 설문 게시글 작성자 번호
	private int cNo;				// 회사번호
	private int dNo;				// 부서번호
	private int sbTDNo;				// 설문 게시글 공개 대상 부서 번호
	private int sbINo;				// 설문 문항 번호
	private String sbITitle; 		// 설문 문항 제목
	private String sbIType;			// 설문 답변 선택 타입 ('S' , 'M')
	private int sqNo; 				// 설문 질문 번호
	private int sqSeq; 				// 설문 질문 순서
	private String sqContent; 		// 설문 질문 내용
	private String mNo;				// 사원 번호
	private String sbAState;		// 답변 유무
	
}
