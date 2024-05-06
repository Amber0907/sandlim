package com.one.san.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.one.san.moc.CartService;
import com.one.san.moc.CartVO;
import com.one.san.moc.MdService;
import com.one.san.moc.MdVO;

@Controller
public class MdController {

	@Autowired
	private MdService mdService;
	@Autowired
	private CartService cartService;

	String realPath = "C:/swork/sandlim/src/main/webapp/resources/img/";

//	 전체메뉴 출력
	@RequestMapping("/adminMd.san")
	public ModelAndView adminMd(MdVO vo, ModelAndView model) {

		if (vo.getSearchKeyword() == null) {
			vo.setSearchKeyword("");
		}
		model.addObject("mdList", mdService.selectList(vo));
		model.setViewName("admin/adminMd");
		return model;
	}

//	 전체메뉴 출력
	@RequestMapping("/selectList.san")
	public ModelAndView selectList(MdVO vo, ModelAndView model) {

		if (vo.getSearchKeyword() == null) {
			vo.setSearchKeyword("");
		}
		model.addObject("mdList", mdService.selectList(vo));
		model.setViewName("md/selectMdList");
		return model;
	}

// 	키워드 별로 출력 -> 관리자일때만 메뉴수정 버튼 보이게하기(현재는 키워드 선택 시 둘 다 보임, 클릭은 안됨)
	@RequestMapping("/kind.san")
	@ResponseBody
	public Object selectkind(MdVO vo) {
		List<MdVO> kindList = mdService.selectkind(vo);
		Map<String, Object> kList = new HashMap<String, Object>();
		kList.put("kindList", kindList);
		return kList;
	}

// 	검색기능
	@RequestMapping("/search.san")
	@ResponseBody
	public Object search(MdVO vo) {
		List<MdVO> searchList = mdService.searchList(vo);
		Map<String, Object> sList = new HashMap<String, Object>();
		sList.put("searchList", searchList);
		return sList;
	}

//	관리자: 메뉴 추가(인풋) 페이지로 이동
	@RequestMapping("/insert.san")
	public String insert(MdVO vo) {
		return "/admin/insertMd";
	}

// 	관리자 : 메뉴 추가
	@PostMapping(value = "/insertmd.san")
	public String insertMd(MdVO vo) throws IllegalStateException, IOException {
		MultipartFile uploadFile = vo.getUploadfile();
		File f = new File(realPath);

		if (!f.exists()) {
			f.mkdirs();
		}
		String fileName = uploadFile.getOriginalFilename();

		if (!uploadFile.isEmpty()) {
			vo.setM_img(fileName);
			uploadFile.transferTo(new File(realPath + fileName));
		}
		mdService.insertMd(vo);
		return "redirect:adminMd.san";

	}

//	관리자 : 메뉴 수정 클릭 시 한 줄 데이터 받아오는 
	@GetMapping("/upgetMd.san")
	public ResponseEntity<MdVO> upgetMd(@RequestParam("m_no") int mNo) {
		MdVO md = mdService.upgetMd(mNo);
		if (md != null) {
			return new ResponseEntity<>(md, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

// 	관리자 : 메뉴 수정
	@RequestMapping("/updateMd.san")
	public String updateMd(MdVO vo) throws IllegalStateException, IOException {
		if (!(vo.getUploadfile() == null)) {
			MultipartFile uploadFile = vo.getUploadfile();
			File f = new File(realPath);

			if (!f.exists()) {
				f.mkdirs();
			}
			String fileName = uploadFile.getOriginalFilename();

			if (!uploadFile.isEmpty()) {
				vo.setM_img(fileName);
				uploadFile.transferTo(new File(realPath + fileName));
			}
		}
		mdService.updateMd(vo);
		return "redirect:adminMd.san";
	}

// 	관리자 : 메뉴 삭제 
	@RequestMapping("/deleteMd.san")
	public String deleteMd(MdVO vo) {
		mdService.deleteMd(vo);
		return "redirect:adminMd.san";
	}

// 메뉴 상세보기 
	@RequestMapping("/getMd.san")
	public ResponseEntity<MdVO> getMd(MdVO vo) {
		MdVO md = mdService.getMd(vo);
		if (md != null) {
			return new ResponseEntity<>(md, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

//메뉴 영양정보
	@RequestMapping("/getContent.san")
	public ResponseEntity<MdVO> getContent(MdVO vo) {
		MdVO md = mdService.getContent(vo);
		if (md != null) {
			return new ResponseEntity<>(md, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	// 장바구니에 담기
	@RequestMapping(value = "/insertCart.san", method = RequestMethod.POST)
	public ResponseEntity<Boolean> insertCart(CartVO vo) {
		Boolean bo = false;
		int cnt = cartService.insertCart(vo);
		if (cnt > 0) {
			bo = true;
			return new ResponseEntity<>(bo, HttpStatus.OK);
		}
		return new ResponseEntity<>(bo, HttpStatus.OK);
	}

	// 장바구니 리스트 가져오기
	@RequestMapping(value = "/getCartList.san")
	public ModelAndView getCartList(CartVO vo, ModelAndView mv) {
		System.out.println("vo :" + vo.getC_id());
		mv.addObject("cartList", cartService.getCartList(vo));
		mv.setViewName("md/cartRoom");

		return mv;
	}
	   // 카트에 담긴 상품이 있는지 확인
	   @RequestMapping("/ListCheck.san")
	   public ResponseEntity<CartVO> CartListCheck(CartVO vo) {
	      CartVO cv = cartService.CartListCheck(vo);
	         return new ResponseEntity<>(cv, HttpStatus.OK);
	   }
	   
	   // 카트에 담긴 상품이 있으면 상품 업데이트
	   @RequestMapping("/UpdateCart.san")
	   public ResponseEntity<Boolean> UpdateCart(CartVO vo) {
	      System.out.println("vo : " + vo);
	      Boolean bo = false;
	      int cnt = cartService.UpdateCart(vo);
	      if (cnt > 0) {
	         System.out.println("if문 안");
	         bo = true;
	         return new ResponseEntity<>(bo, HttpStatus.OK);
	      }
	      return new ResponseEntity<>(bo, HttpStatus.OK);
	   }
	

}
