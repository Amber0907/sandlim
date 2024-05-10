package com.one.san.board.impl;

import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.one.san.board.BoardVO;
import com.one.san.util.Pagination;

// DAO클래스를 만들고 객체화를 시키려면 Repository
@Repository
public class BoardDAOMybatis {

	@Autowired
	private SqlSessionTemplate mybatis;

	// 글 등록
	public int insertBoard(BoardVO vo) {
		return mybatis.insert("boardDAO.insertBoard", vo);
	}

	// 글 수정
	public void updateBoard(BoardVO vo) {
		mybatis.update("boardDAO.updateBoard", vo);
	}

	// 글삭제
	public void deleteBoard(BoardVO vo) {
		mybatis.delete("boardDAO.deleteBoard", vo);
	}

	// 공지글 상세 조회
	public BoardVO getBoard(BoardVO vo) {
		return mybatis.selectOne("boardDAO.getBoard", vo);
	}

	// 공지글 목록 조회
	public List<BoardVO> getBoardList(BoardVO vo) {
		return mybatis.selectList("boardDAO.getBoardList", vo);
	}

	// faq글 목록 조회 (유저)
	public List<BoardVO> getFaqList(BoardVO vo) {
		return mybatis.selectList("boardDAO.getFaqList", vo);
	}

	// faq글 목록 조회 (어드민)
	public List<BoardVO> adminFaqList(BoardVO vo) {
		return mybatis.selectList("boardDAO.adminFaqList", vo);
	}

	// faq 상세 조회(어드민)
	public BoardVO adminFaqDetail(BoardVO vo) {
		return mybatis.selectOne("boardDAO.adminFaqDetail", vo);
	}

	// Faq 등록
	public int insertFaq(BoardVO vo) {
		return mybatis.insert("boardDAO.insertFaq", vo);
	}

	// Faq 수정
	public void updateFaq(BoardVO vo) {
		mybatis.update("boardDAO.updateFaq", vo);
	}

	// Faq 삭제
//	public void deleteFaq(BoardVO vo) {
//		mybatis.delete("boardDAO.deleteFaq", vo);
//	}
	public int deleteFaq(BoardVO vo) {
		return mybatis.delete("boardDAO.deleteFaq", vo);
	}

	// 리뷰 가져오기
	public List<BoardVO> getReview(BoardVO vo) {
		return mybatis.selectList("boardDAO.getReview", vo);
	}

	// 리뷰 등록
	public int insertReview(BoardVO vo) {
		return mybatis.insert("boardDAO.insertReview", vo);
	}

	// 리뷰 상세보기
	public Object getReviewDetail(BoardVO vo) {
		return mybatis.selectOne("boardDAO.getReviewDetail", vo);
	}

	// REVIEW 수정
	public void updateReview(BoardVO vo) {
		mybatis.update("boardDAO.updateReview", vo);
	}

	// REVIEW 삭제
	public void deleteReview(BoardVO vo) {
		mybatis.update("boardDAO.deleteReview", vo);
	}
	
	//페이지네이션
	public int boardTotalCnt(Pagination pg) {
		return mybatis.selectOne("boardDAO.boardTotalCnt", pg);
	}
	
	public List<BoardVO> selectList(Pagination pg) {
		System.out.println("dao에서의 pg값: "+pg);
		return mybatis.selectList("boardDAO.selectList", pg);
	}
}
