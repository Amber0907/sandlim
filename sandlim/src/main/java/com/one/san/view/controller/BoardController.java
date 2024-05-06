package com.one.san.view.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.one.san.board.BoardService;
import com.one.san.board.BoardVO;

// @Component
@Controller
@SessionAttributes("board")
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
   public void fileDownLoad(@RequestParam(value="filename", required=false) String filename, HttpServletRequest request, HttpServletResponse response) throws IOException {
      System.out.println("파일 다운로드");
      if (!(filename == null || filename.equals(""))) {
         // 요청 파일정보 불러오기
//         realPath = request.getSession().getServletContext().getRealPath("/img/");
         File file = new File(realPath + filename);
         
         // 한글은 http 헤더에 사용할 수 없기 때문에 파일명은 영문으로 인코딩하여 헤더에 적용한다.
         String fn = new String(file.getName().getBytes(), "iso_8859_1");
         
         // ContentType설정
         // 파일 다운로드 설정문
         byte[] bytes = org.springframework.util.FileCopyUtils.copyToByteArray(file);
         response.setHeader("Content-Disposition", "attachment; filename=\"" + fn + "\"");
         response.setContentLength(bytes.length);
//         response.setContentType("image/jpeg");
         
         response.getOutputStream().write(bytes);
         response.getOutputStream().flush();
         response.getOutputStream().close();
      }
   }
   
   // 공지사항 글 목록
   @RequestMapping("/getBoardList.do")
   public ModelAndView getBoardListPost(BoardVO vo, ModelAndView mav) {
	    System.out.println("ctrl vo : " + vo);
	    if (vo.getB_title() == null) vo.setB_title("");
//	    List<BoardVO> boardList = boardService.getBoardList(vo); // List<Board>를 반환하도록 수정
	    
	    mav.addObject("boardList", boardService.getBoardList(vo));
	    mav.setViewName("board/getBoardList");
	    return mav;
	}

   // FAQ 목록 보기
   @RequestMapping("/getFaq.do")
   public ModelAndView getFaqPost(BoardVO vo, ModelAndView mav) {
	   if(vo.getB_title() == null) vo.setB_title("");
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
   
   // 소개글 //0503
   @RequestMapping("/getAbout.do")
   public String getAboutPage() {
	   return "board/getAbout";
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
//   public String insertBoard(MultipartHttpServletRequest, BoardVO vo) throws IllegalStateException, IOException {
      MultipartFile uploadFile = vo.getUploadB_file();
      // 상대 경로 추가시 realPath 추가
      // realPath = request.getSession().getServletContext().getRealPath("/img/");
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
   
// 공지사항 글 수정
   @RequestMapping("/updateBoard.do")
   public String updateBoard(@ModelAttribute("board") BoardVO vo, HttpSession session) {
      System.out.println("vo : " + vo);
      if(vo.getB_nick().equals(session.getAttribute("userName").toString())) {
         boardService.updateBoard(vo);
         return "redirect:getBoardList.do";
      }else {
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
   @RequestMapping("/adminGetFaq.do")
   public ModelAndView adminGetFaq(BoardVO vo, ModelAndView mav) {
	   if(vo.getB_title() == null) vo.setB_title("");
	   List<BoardVO> boardList1 = boardService.getFaqList(vo);
	   
	   mav.addObject("faq", boardService.getFaqList(vo));
	   mav.setViewName("board/adminGetFaq");      
	   return mav;
   }
   
   // 관리자 faq 글 상세 조회 
   @RequestMapping("/adminFaqDetail.do")
   public String adminFaqList(BoardVO vo, Model model) {
	   System.out.println(vo);
	   List<BoardVO> boardList1 = boardService.getFaqList(vo);
	   model.addAttribute("faq", boardService.getBoard(vo));
	   return "board/adminFaqDetail";
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
   public String handleRequest(BoardVO vo){
	   return "board/adminInsertFaq";
   }
   
   
   // 공지사항 글 삭제
   @RequestMapping("/deleteFaq.do")
   public String deleteFaq(BoardVO vo) {
      boardService.deleteFaq(vo);
      return "redirect:getBoardList.do";
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
   
}