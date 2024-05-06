package com.one.san.board.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.one.san.board.BoardService;
import com.one.san.board.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

//	@Autowired
//	private BoardDAO dao;

//	@Autowired
//	private BoardDAODBCP dao;

	@Autowired
	private BoardDAOMybatis boardDAO;

	@Override
	public int insertBoard(BoardVO vo) {
		return boardDAO.insertBoard(vo);
	}
	@Override
	public int insertFaq(BoardVO vo) {
		return boardDAO.insertFaq(vo);
	}

	@Override
	public void updateBoard(BoardVO vo) {
		boardDAO.updateBoard(vo);
	}

	@Override
	public void deleteBoard(BoardVO vo) {
		boardDAO.deleteBoard(vo);
	}

	
	//공지 글 상세
	@Override
	public BoardVO getBoard(BoardVO vo) {
		return boardDAO.getBoard(vo);
	}

	//공지 리스트
	@Override
	public List<BoardVO> getBoardList(BoardVO vo) {
		return boardDAO.getBoardList(vo);
	}

//	faq리스트 가져오기(공용)
	@Override
	public List<BoardVO> getFaqList(BoardVO vo) {
		return boardDAO.getFaqList(vo);
	}

//	faq리스트 가져오기(어드민)
	@Override
	public List<BoardVO> adminFaqList(BoardVO vo) {
		return boardDAO.adminFaqList(vo);
	}

//	faq리스트 상세글 가져오기(어드민)
	@Override
	public BoardVO adminFaqDetail(BoardVO vo) {
		return boardDAO.adminFaqDetail(vo);
	}
	
//	faq리스트 글 삭제하기(어드민)
	@Override
	public void deleteFaq(BoardVO vo) {
		boardDAO.deleteBoard(vo);
	}


	@Override
	public List<BoardVO> getReview(BoardVO vo) {
		return boardDAO.getReview(vo);
	}

	@Override
	public int insertReview(BoardVO vo) {
		return boardDAO.insertReview(vo);

	}

//	@Override
//	public void updateFaq(BoardVO vo) {
//		boardDAO.updateFaq(vo);
//	}

}