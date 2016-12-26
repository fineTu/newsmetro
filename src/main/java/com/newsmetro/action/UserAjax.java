package com.newsmetro.action;

import com.newsmetro.po.User;
import com.newsmetro.service.TargetService;
import com.newsmetro.service.UserService;
import com.newsmetro.util.DESUtil;
import com.newsmetro.util.MD5Util;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Controller
@Scope("prototype")
public class UserAjax {
	static String key = "37d5aed075525d4fa0fe635231cba447";
	DESUtil desUtil = new DESUtil();
	@Autowired
	private TargetService tpService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/getSignInKeyAjax.html")
	public void addTarget(HttpServletRequest request,HttpServletResponse response){
		boolean flag = true;
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		User signUser = null;
		if(email!=null&&!email.equals("")&&password!=null&&!password.equals("")){
			String passMd5 = MD5Util.md5(password, MD5Util._32_BIT);
			signUser = userService.signIn(email,passMd5);
			if(signUser==null){
				flag = false;
			}
		}else{
			flag= false;
		}
		
		JSONObject res = new JSONObject();
		res.put("res", flag?true:false);
		if(flag){
			res.put("userName",signUser.getName());
			res.put("email",signUser.getEmail());
			String keyString = signUser.getEmail()+"||"+signUser.getPassword();
			String urlString = null;;
			try {
				urlString = URLEncoder.encode(desUtil.getEncryptString(keyString,key),"utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
			res.put("signInKey",urlString);
		}
		response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(res.toString());  
        } catch (IOException e) {  
            e.printStackTrace();  
        }
	}
}
