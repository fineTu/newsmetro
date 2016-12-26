package com.newsmetro.interceptor;

import com.newsmetro.enumeration.AuthorExceptEnum;
import com.newsmetro.enumeration.UserStatus;
import com.newsmetro.exception.AuthorizationException;
import com.newsmetro.po.User;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SignInInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		Object obj = request.getSession().getAttribute("user");
		User user = (User)obj;
		if(user!=null&&user.getStatus()==User.STATUS_REGULAR){
			return true;
		}
		return false;
	}

}
