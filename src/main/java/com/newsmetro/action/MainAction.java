package com.newsmetro.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class MainAction {
	
	@RequestMapping(value="/page404.html")
	public String toPage404(HttpServletRequest request){
		return "page404";
	}
	
	@RequestMapping(value="/page500.html")
	public String toPage500(HttpServletRequest request){
		return "page500";
	}
	
	@RequestMapping(value="/toHelper.html")
	public String toHelper(HttpServletRequest request){
		return "helper";
    }
	}
