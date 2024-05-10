package com.one.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.one.san.board.BoardService;
import com.one.san.board.BoardVO;
import com.one.san.user.UserVO;
import com.one.san.util.Pagination;

// @Component
@Controller
@SessionAttributes({ "board", "faq" })
public class BoardController {

	// 스프링 컨테이너
	@Autowired
	private BoardService boardService;

	String realPath = "c:/swork/sandlim/src/main/webapp/resources/bimg/";

//   request에 attribute 세션보다 메모리 처리가 빠르다.
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		Map<String, String> conditionMap = new HashMap<String, String>();
		// 키가 내용, 값이 "CONTENT"
		conditionMap.put("카테고리", "B_CAT");
		conditionMap.put("내용", "B_CONTENT");
		conditionMap.put("제목", "B_TITLE");
		return conditionMap;
	}

	// 파일 다운로드
	@GetMapping(value = "/download.do")
	public void fileDownLoad(@RequestParam(value = "filename", required = false) String filename,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		System.out.println("파일 다운로드");
		if (!(filename == null || filename.equals(""))) {
			// 요청 파일정보 불러오기
//         realPath = request.getSession().getServletContext().getRealPath("/img/");
			File file = new File(realPath + filename);

			String fn = new String(file.getName().getBytes(), "iso_8859_1");

			// 파일 다운로드 설정문
			byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
			response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
			response.setContentLength(bytes.length);

			response.getOutputStream().write(bytes);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
	}

	// 공지사항 글 목록
	@RequestMapping("/getBoardList.do")
	public ModelAndView getBoardListPost(BoardVO vo, ModelAndView mav) {
		System.out.println("ctrl vo : " + vo);
		if (vo.getB_title() == null)
			vo.setB_title("");

		mav.addObject("boardList", boardService.getBoardList(vo));
		mav.setViewName("board/getBoardList");
		return mav;
	}

	// FAQ 목록 보기
	@RequestMapping("/getFaq.do")
	public ModelAndView getFaqPost(BoardVO vo, ModelAndView mav) {
		if (vo.getB_title() == null)
			vo.setB_title("");
		List<BoardVO> boardList1 = boardService.getFaqList(vo);

		mav.addObject("faq", boardService.getFaqList(vo));
		mav.setViewName("board/getFaq");
		return mav;
	}

	// 글 상세 조회
	// Model addAttribute에서 request.set이 된다.
	@RequestMapping("/getBoard.do")
	public String getVoard(BoardVO vo, Model model) {
		System.out.println(vo);
		model.addAttribute("board", boardService.getBoard(vo));
		return "board/getBoard";
	}

	// 소개글
	@RequestMapping("/getAbout.do")
	public String getAboutPage() {
		return "board/getAbout";
	}
	
	// REVIEW
	@RequestMapping("/getReview.do")
	public ModelAndView getReview(BoardVO vo, ModelAndView mav) {
		System.out.println("리뷰 게시판 불러오기 실행");
		if (vo.getB_title() == null)
			vo.setB_title("");

		mav.addObject("boardList", boardService.getReview(vo));
		mav.setViewName("board/getReview");
		return mav;
	}
	
	// REVIEW 상세
	@RequestMapping("/getReviewDetail.do")
	public String getReviewDetail(BoardVO vo, Model model) {
		System.out.println("REVIEW 상세" + vo);
		model.addAttribute("board", boardService.getReviewDetail(vo));
		return "board/getReviewDetail";
	}

//   =================================================================
//   관리자 페이지 관련
//   =================================================================

	// 관리자페이지
	@RequestMapping("/adminWork.do")
	public String adminWork() {
		return "admin/adminWork";
	}

	// 상대경로 추가시 공지사항 등록
	@PostMapping(value = "/insertBoard.do")
	public String insertBoard(BoardVO vo) throws IllegalStateException, IOException {
		System.out.println(vo);
		MultipartFile uploadFile = vo.getUploadB_file();
		// 상대 경로 추가시 realPath 추가
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		String fileName = uploadFile.getOriginalFilename();
		if (!uploadFile.isEmpty()) {
			vo.setB_file(fileName);
			uploadFile.transferTo(new File(realPath + fileName));
		}

		boardService.insertBoard(vo);
		return "redirect:getBoardList.do";
	}
	
	   // [ADMIN] NOTICE 목록 > NOTICE 등록
	   @RequestMapping("/getinsertBoard.do")
	   public String getinsertBoard() {
	      return "board/insertBoard";
	   }

// 공지사항 글 수정
	@RequestMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute("board") BoardVO vo, HttpSession session) {
		System.out.println("vo : " + vo);
		if (vo.getB_nick().equals(session.getAttribute("userName").toString())) {
			boardService.updateBoard(vo);
			return "redirect:getBoardList.do";
		} else {
			return "getBoard.do?error=1";
		}
	}

	// 공지사항 글 삭제
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(BoardVO vo) {
		boardService.deleteBoard(vo);
		return "redirect:getBoardList.do";
	}

	// 관리자 faq 페이지
//	@RequestMapping("/adminGetFaq.do")
//	public ModelAndView adminGetFaq(BoardVO vo, ModelAndView mav) {
//		if (vo.getB_title() == null)
//			vo.setB_title("");
//		mav.addObject("faq", boardService.getFaqList(vo));
//		mav.setViewName("admin/adminGetFaq");
//		return mav;
//	}
	
	// 관리자 faq 페이지
		@RequestMapping("/adminGetFaq.do")
		public String adminGetFaq(
				@RequestParam(value = "searchType", defaultValue = "", required = false) String searchType,
				@RequestParam(value = "keyword", defaultValue = "", required = false) String keyword,
				@RequestParam(value = "currPageNo", required = false, defaultValue = "1") int currPageNo,
				@RequestParam(value = "range", required = false, defaultValue = "1") int range,
				BoardVO vo, Model model, ModelAndView mav) {
			
			// 페이징을 위한 객체 생성
			Pagination pg = new Pagination();
			// 검색 카테고리
			pg.setSearchType(searchType);
			// 검색어
			pg.setKeyword(keyword);
			// 현재페이지
			pg.setCurrPageNo(currPageNo);
			// 보여줄 페이지 범위
			pg.setRange(range);
			
			// 검색된 데이터의 총 갯수
			int totalCnt = boardService.boardTotalCnt(pg);
			System.out.printf("currPageNo : %d/ range : %d / totalCnt : %d %n ", currPageNo, range, totalCnt );
			// 페이징 처리 시작
			pg.pageInfo(currPageNo, range, totalCnt);
			
			model.addAttribute("pagination", pg);
			model.addAttribute("faq", boardService.selectList(pg));
			return "admin/adminGetFaq";
			
		}

	// 관리자 faq 글 상세 조회
	@RequestMapping("/adminFaqDetail.do")
	public String adminFaqList(BoardVO vo, Model model) {
		System.out.println(vo);
		model.addAttribute("faq", boardService.adminFaqDetail(vo));
		return "admin/adminFaqDetail";
	}

	// faq 등록하기
	@RequestMapping(value = "/insertFaq.do")
	public String adminInsertFaq(BoardVO vo) throws IllegalStateException, IOException {
		System.out.println(vo);
		boardService.insertFaq(vo);
		return "redirect:adminGetFaq.do";
	}

	// faq 등록 양식 페이지 (새글쓰기 클릭)
	@RequestMapping(value = "/adminInsertFaq.do")
	public String handleRequest(BoardVO vo) {
		return "admin/adminInsertFaq";
	}

// faq 글 수정
	@RequestMapping("/updateFaq.do")
	public String updateFaq(@ModelAttribute("faq") BoardVO vo, Model model) {
		boardService.updateFaq(vo);
		return "redirect:adminGetFaq.do";
	}

	// faq 글 삭제
	@RequestMapping("/deleteFaq.do")
	public String deleteFaq(BoardVO vo) {
		System.out.println("삭제 vo : " + vo);
		boardService.deleteFaq(vo);
		return "redirect:adminGetFaq.do";
	}



	// 리뷰 등록 이동하기
	@RequestMapping("/getinsertReview.do")
	public String getinsertReview() {
		return "board/insertReview";
	}

	// 리뷰 등록
	@PostMapping(value = "/insertReview.do")
	public String insertReview(BoardVO vo) throws IllegalStateException, IOException {
		System.out.println("insertReview : " + vo);
		MultipartFile uploadFile = vo.getUploadB_file();
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}

		String fileName = uploadFile.getOriginalFilename();
		if (!uploadFile.isEmpty()) {
			vo.setB_file(fileName);
			uploadFile.transferTo(new File(realPath + "rimg/" + fileName));
		}
		boardService.insertReview(vo);
		return "redirect:getReview.do";
	}



	// REVIEW 수정
	@RequestMapping("/updateReview.do")
	public String updateReview(@ModelAttribute("board") BoardVO vo, HttpSession session) {
		System.out.println("REVIEW 수정 : " + vo);
		if (vo.getB_nick().equals(session.getAttribute("userName").toString())) {
			boardService.updateReview(vo);
			return "redirect:getReview.do";
		} else {
//         return "getReviewDetail.do?error=1";
			return "getReview.do?error=1";
		}
	}

	// REVIEW 삭제
	@RequestMapping("/deleteReview.do")
	public String deleteReview(BoardVO vo) {
		System.out.println("REVIEW 삭제완료 : " + vo);
		boardService.deleteReview(vo);
		return "redirect:getReview.do";
	}


}