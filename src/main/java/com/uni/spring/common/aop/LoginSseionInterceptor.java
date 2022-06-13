package com.uni.spring.common.aop;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.uni.spring.member.model.dto.Member;
import com.uni.spring.member.model.service.MemberService;

public class LoginSseionInterceptor extends HandlerInterceptorAdapter{
	
	@Inject
	private MemberService memberService;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
         
        HttpSession session = request.getSession();

        Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
        if (loginCookie != null) { // 쿠기있으면
        	Member loginUser = memberService.selectRemember(loginCookie.getValue()); // 쿠기값으로 로그인 정보 갖고오기
            if (loginUser != null) {
            	session.setAttribute("loginUser", loginUser);
            	response.sendRedirect(request.getContextPath()+"/main");
            }
        }
        return true;
    }
	
	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }

}
