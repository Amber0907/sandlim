package com.one.san.board;

import java.util.List;

public interface BoardService {

	// CRUD 기능의 메소드 구현
	// 글 등록
	int insertBoard(BoardVO vo);
	
	// Admin Faq 등록
	int insertFaq(BoardVO vo);

	// 글 수정
	void updateBoard(BoardVO vo);
	

	// 글삭제
	void deleteBoard(BoardVO vo);
	
	// 공지 상세 조회
	BoardVO getBoard(BoardVO vo);

	// 공지 목록 조회
	List<BoardVO> getBoardList(BoardVO vo);
	
	// 유저 FAQ글 목록 조회
	List<BoardVO> getFaqList(BoardVO vo);
	
	// 어드민 FAQ글 목록 조회
	List<BoardVO> adminFaqList(BoardVO vo);
	
	// 어드민 FAQ글 상세 조회
	BoardVO adminFaqDetail(BoardVO vo);
	
	// 어드민 FAQ글 삭제
	void deleteFaq(BoardVO vo);

	int insertReview(BoardVO vo);

	Object getReview(BoardVO vo);
	
	// faq 글 수정
//	void updateFaq(BoardVO vo);
}
