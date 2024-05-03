package com.one.san.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class Interceptor implements HandlerInterceptor{

//	static final String[] EXCLUDE_URL_LIST = { "/login", "/join", "/home" };
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) 
			throws Exception {
		String reqUrl = request.getRequestURL().toString(); 
		System.out.println("reqUrl: "+reqUrl); 
		
//		로그인체크 제외 리스트 
//		for (String target : EXCLUDE_URL_LIST) { //{ "/login", "/join", "/home" };
//			  
//			if (reqUrl.indexOf(target) > -1) return true;
//		}
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		if(userId == null || userId.trim().equals("")) {
			session.invalidate();	
//			세션을 유효하지 않은 상태로 하는 법 (로그아웃)
			response.sendRedirect(request.getContextPath() + "/login.do");
//			url이 바뀌고 , 데이터 전송이 되지 않는다. 
			return false;
		}
		
		return true;
	}
}
