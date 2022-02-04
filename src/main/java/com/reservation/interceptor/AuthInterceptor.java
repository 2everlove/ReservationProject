package com.reservation.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.reservation.dto.UserDTO;
import com.reservation.utils.TableStatus;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private final UserDTO ADMIN = UserDTO.builder().name("Admin").passwd("admin").role("ROLE_ADMIN").build();

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		UserDTO user = (UserDTO)session.getAttribute("user");
		
		
		session.setAttribute("loginFlg",TableStatus.Y.getCode());
		
		
		if(user != null) {
			if(user.getRole().equals("ROLE_ADMIN")) {
				session.setAttribute("loginFlg",TableStatus.N.getCode());
				return true;
			}
			return false;
		}
		
		FlashMap flashMap = new FlashMap();
		flashMap.put("interceptorMsg", TableStatus.Y.getCode());
		FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
		flashMapManager.saveOutputFlashMap(flashMap, request, response);
		
		System.out.println("user==========="+user);
		System.out.println("url==========="+request.getRequestURI());
		System.out.println("query==========="+request.getQueryString());
		
		StringBuilder uri = new StringBuilder();
		System.out.println("builderurl==========="+uri);
		uri.append(request.getRequestURI());
		String query = request.getQueryString();
		
		if(query != null) {
			uri.append("?").append(query);
		}
		System.out.println("changedUri============="+uri.toString());
		
		String res = "";
		
		if(uri != null) {
			System.out.println("auth============"+uri.toString());
			session.setAttribute("tempUri", uri.toString());
			res = (String)session.getAttribute("tempUri");
		}
		System.out.println("contation?=========="+res);
		
		System.out.println("check3");
		response.sendRedirect("/main");
		return false;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}
	
	
}
