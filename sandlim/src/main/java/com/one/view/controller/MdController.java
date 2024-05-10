package com.one.view.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.one.san.moc.CartService;
import com.one.san.moc.CartVO;
import com.one.san.moc.MdService;
import com.one.san.moc.MdVO;
import com.one.san.moc.OdService;
import com.one.san.moc.OdVO;
import com.one.san.util.Pagination;

@Controller
@SessionAttributes("staod")
public class MdController {

	@Autowired
	private MdService mdService;
	@Autowired
	private CartService cartService;
	@Autowired
	private OdService odService;

	String realPath = "C:/swork/sandlim/src/main/webapp/resources/img/";

	//해당회원 주문내역 
	

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

// 	키워드 별로 출력 
	@RequestMapping("/kind.san")
	@ResponseBody
	public Object selectkind(MdVO vo) {
		List<MdVO> kindList = mdService.selectkind(vo);
		Map<String, Object> kList = new HashMap<String, Object>();
		kList.put("kindList", kindList);
		return kList;
	}
	
	//품절 메뉴 출력
	@RequestMapping("/sold.san")
	@ResponseBody
	public Object soldList(MdVO vo) {
		List<MdVO> soldList = mdService.soldList(vo);
		Map<String, Object> sList = new HashMap<String, Object>();
		sList.put("soldList", soldList);
		return sList;
	}

// 	메뉴 검색기능
	@RequestMapping("/search.san")
	@ResponseBody
	public Object search(MdVO vo) {
		List<MdVO> searchList = mdService.searchList(vo);
		Map<String, Object> sList = new HashMap<String, Object>();
		sList.put("searchList", searchList);
		return sList;
	}
	//관리자 주문 검색
	@RequestMapping("/odsearch.san")
	@ResponseBody
	public Object odsearch(OdVO vo) {
		List<OdVO> odsearch = odService.odsearch(vo);
		Map<String, Object> oList = new HashMap<String, Object>();
		oList.put("odsearch", odsearch);
		return oList;
	}
	//관리자 날짜로 검색
	@RequestMapping("/dateSearch.san")
	@ResponseBody
	public Object oddate(OdVO vo) {
		List<OdVO> ddsearch = odService.ddsearch(vo);
		Map<String, Object> dList = new HashMap<String, Object>();
		dList.put("ddsearch", ddsearch);
		return dList;
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
	
// 	관리자 : 메뉴 상태변경 (주문 접수 - 제조중 - 제조완료 - 픽업완료)
	@RequestMapping("/updateOd.san")
	public String updateOd(OdVO vo, HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		odService.updateOd(vo);
		    return "redirect:"+ referer;
//		return "redirect:odAllList.san";
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
	public ModelAndView getCartList(CartVO vo, ModelAndView mv, HttpSession session) {
		String c_id = (String) session.getAttribute("userId");
	      vo.setC_id(c_id);
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
	   
	   // 장바구니 메뉴삭제
	   @RequestMapping("/deleteCart.san")
	         public String deleteCart(CartVO vo) {
	            int cnt = cartService.deleteCart(vo);
	            if (cnt > 0) {
	               return "md/cartRoom";
	            }
	            return "md/cartRoom";
	         }

//		관리자 : 전체 주문 내역 
		@RequestMapping("/odAllList.san")
		public ModelAndView odAllList(
				@RequestParam(value = "searchCondition", defaultValue = "", required = false) String searchType,
				@RequestParam(value = "searchKeyword", defaultValue = "", required = false) String keyword,
				@RequestParam(value = "currPageNo", required = false, defaultValue = "1") int currPageNo,
				@RequestParam(value = "range", required = false, defaultValue = "1") int range ,OdVO vo, ModelAndView model) {

			Pagination pg = new Pagination();
			pg.setSearchType(searchType);
			pg.setKeyword(keyword);
			pg.setCurrPageNo(currPageNo);
			pg.setRange(range);
			
			int totalCnt = odService.countProductList(pg);
			
			pg.pageInfo(currPageNo, range, totalCnt);
			
			
			model.addObject("pagination", pg);
			model.addObject("odList", odService.getProductListPaging(pg));
			model.setViewName("admin/adminOd");
			return model;
		}
//		관리자 : 전체 주문 내역 
		@RequestMapping("/odSelect.san")
		@ResponseBody
		public Object odSelect(
				@RequestParam(value = "searchCondition", defaultValue = "", required = false) String searchType,
				@RequestParam(value = "searchKeyword", defaultValue = "", required = false) String keyword, OdVO vo) {
			
			List<OdVO> odsearch = odService.odsearch(vo);
			Map<String, Object> oList = new HashMap<String, Object>();
			int length = odsearch.size();
			System.out.println(length);
			oList.put("odsearch", odsearch);
			oList.put("length", length);
			return oList;
		}
		
		   // 전자영수증 페이지 이동
	      @RequestMapping("/payList.san")
	      public String payList(HttpSession session) {
	         CartVO ov = new CartVO();
	         String c_id = (String) session.getAttribute("userId");
	         ov.setC_id(c_id);
	         int cnt = cartService.deleteCart(ov);
	         if(cnt > 0){
	            return "md/pay";
	         }
	         return "md/pay";
	      }
	      
	      // 전자 영수증 데이터 가져옴
	      @RequestMapping("/receipt.san")
	      public ResponseEntity<OdVO> receipt(OdVO vo) {
	         OdVO ov = odService.receipt(vo);
	         if (ov != null) {
	            return new ResponseEntity<>(ov, HttpStatus.OK);
	         } else {
	            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
	         }
	      }
	      // 나의 전체 주문 내역
	        @RequestMapping(value = "/odMyAllList.san")
	      public ModelAndView odMyAllList(OdVO vo, ModelAndView oma, HttpSession session) {
	         String o_id = (String) session.getAttribute("userId");
	          vo.setO_id(o_id);
	          System.out.println("o_id : " + o_id);
	          oma.addObject("odMyAllList", odService.odMyAllList(vo));
	          oma.setViewName("md/odAllList");
	         return oma;
	      }       
	        
	        // 나의 주문 진행중 내역
	        @RequestMapping(value = "/odMyList.san")
	        public ModelAndView odMyList(OdVO vo, ModelAndView oma, HttpSession session) {
	           String o_id = (String) session.getAttribute("userId");
	           vo.setO_id(o_id);
	           System.out.println("o_id : " + o_id);
	           oma.addObject("odMyList", odService.odMyList(vo));
	           oma.setViewName("md/odMyList");
	           return oma;
	        }
	      
	      
	      
}
