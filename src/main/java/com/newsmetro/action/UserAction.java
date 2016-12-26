package com.newsmetro.action;

import com.newsmetro.enumeration.SexEnum;
import com.newsmetro.enumeration.UserStatus;
import com.newsmetro.po.User;
import com.newsmetro.pojo.SignUpForm;
import com.newsmetro.service.UserService;
import com.newsmetro.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Controller
public class UserAction {
	static Logger logger = LoggerFactory.getLogger(UserAction.class.getName());
	private static String ROOT_PATH = "http://www.newsmetro.net/";
	//"http://localhost:8080/newsmetro/"
	static String key = "37d5aed075525d4fa0fe635231cba447";
	DESUtil desUtil = new DESUtil();
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/index.html")
	public String toIndex(HttpServletRequest request,Map errorMap,SignUpForm form){
		request.setAttribute("validateMap", errorMap);
		request.setAttribute("signUpForm", form);
		return "/index";
	}
	
	
	@RequestMapping(value="/signin.html")
	public ModelAndView signIn(HttpServletRequest request,User user){
		if(user==null||user.getEmail()==null||user.getEmail().equals("")||user.getPassword()==null||user.getPassword().equals("")){
			return new ModelAndView("redirect:/index.html","error","用户名或密码错误");
		}
		user.setPassword(MD5Util.md5(user.getPassword(), MD5Util._32_BIT));
		User signUser = userService.signIn(user.getEmail(),user.getPassword());
		if(signUser!=null&&signUser.getStatus().equals(User.STATUS_REGULAR)){
			request.getSession().setAttribute("user", signUser);
			return new ModelAndView("redirect:/toNewsCenter.html");
		}
		return new ModelAndView("redirect:/index.html","error","用户名或密码错误");
	}
	
	@RequestMapping(value="/signup.html")
	public ModelAndView signUp(HttpServletRequest request,RedirectAttributes attr,SignUpForm form){
		Map<String,String> errorMap = new HashMap<String,String>();
		if(!validatSignUpForm(errorMap,form)){
			attr.addFlashAttribute("validateMap",errorMap);
			attr.addFlashAttribute("signUpForm",form);
			return new ModelAndView("redirect:/index.html");
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
		User formUser = new User();
		formUser.setEmail(form.getEmail());
		formUser.setName(form.getEmail().substring(0, form.getEmail().indexOf("@")));
		formUser.setPassword(MD5Util.md5(form.getPassword(), MD5Util._32_BIT));
		formUser.setSex(form.getSex()!=null?form.getSex():User.SEX_NULL);
		formUser.setPhoto(form.getPhoto()!=null?form.getPhoto():SystemParam.DEFAULT_PHOTO);
		formUser.setStatus(User.STATUS_NEW);
		formUser.setCreateTime(System.currentTimeMillis());
		String desCode = null;
		try {
			desCode = desUtil.getEncryptString(
					request.getRemoteHost()+"|"+
					form.getEmail()+"|"+
					sdf.format(formUser.getCreateTime()),key);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		String urlCode = null;
		try {
			urlCode = URLEncoder.encode(desCode,"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		formUser.setCode(desCode);
		User user = userService.signUp(formUser);
        if(user==null||user.getId()==null){
            return new ModelAndView("redirect:/index.html");
        }
		if (user != null) {
			clearSession(request, "user");
			// 组装激活链接
			String url = ROOT_PATH+"activeUser.html?"+
			"email="+user.getEmail()+"&code="+urlCode;
			// 发送激活邮件
			MailSenderInfo mailInfo = new MailSenderInfo();
			mailInfo.setMailServerHost("smtp.126.com");
			mailInfo.setMailServerPort("25");
			mailInfo.setValidate(true);
			mailInfo.setUserName("newsmetro@126.com");
			mailInfo.setPassword("<utf-8>");// 您的邮箱密码
			mailInfo.setFromAddress("newsmetro@126.com");
			mailInfo.setToAddress(user.getEmail());
			mailInfo.setSubject("newsmetro用户注册激活");
			mailInfo.setContent("感谢您注册newsmetro！<br/>请点击下面的链接以激活您的账号！<br/>"
					+ "<a href='"+url+"'>" +url+ "</a>");
			SimpleMailSender sms = new SimpleMailSender();
			sms.sendHtmlMail(mailInfo);
			logger.info("用户注册:" + user.getId() + "|"+ user.getEmail());
			Map<String,String> infoMap = new HashMap<String, String>();
			infoMap.put("info", "已发送激活邮件，请查收！");
			return new ModelAndView("/activeInfo",infoMap);
		}
		errorMap.put("user", "注册失败");
		logger.info("用户注册失败！");
		attr.addFlashAttribute("validateMap",errorMap);
		attr.addFlashAttribute("signUpForm",form);
		return new ModelAndView("redirect:/index.html");
	}
	
	@RequestMapping(value="/signout.html")
	public ModelAndView signOut(HttpServletRequest request){
		clearSession(request, "user");
		return new ModelAndView("redirect:/index.html");
	}
	
	@RequestMapping(value="/activeUser.html")
	public ModelAndView activeUser(HttpServletRequest request){
		clearSession(request, "user");
		String email = request.getParameter("email");
		String code = request.getParameter("code");
		boolean flag = userService.activeUser(email, code);
		Map<String,String> infoMap = new HashMap<String, String>();
		infoMap.put("info",flag?"激活成功！请登录。":"激活失败！请重新注册。" );
		return new ModelAndView("/activeInfo",infoMap);
	}
	
	@RequestMapping(value="/toSendResetPassMail.html")
	public ModelAndView toSendResetPassMail(HttpServletRequest request){
		clearSession(request, "user");
		return new ModelAndView("/sendResetPassMail");
	}
	
	@RequestMapping(value="/sendResetPassMail.html")
	public ModelAndView sendResetPassMail(HttpServletRequest request){
		clearSession(request, "user");
		String email = request.getParameter("email");
		Map<String,String> infoMap = new HashMap<String, String>();
		if(email==null||!ValidateAssert.matchRegex("[\\w_]+@[\\w\\-_]+\\.[^\\s]+", email)){
			infoMap.put("info","请输入正确的邮箱地址。" );
			return new ModelAndView("/activeInfo",infoMap);
		}
		User user = userService.findUserByEmail(email);
		if(user==null){
			infoMap.put("info","请输入正确的邮箱地址。" );
			return new ModelAndView("/activeInfo",infoMap);
		}
		String keyStr = null;
		try {
			keyStr = URLEncoder.encode(desUtil.getEncryptString(user.getEmail()+"||"+user.getPassword(),key),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 组装激活链接
		String url = ROOT_PATH+"toResetPassword.html?"+"&key="+keyStr;
		// 发送激活邮件
		MailSenderInfo mailInfo = new MailSenderInfo();
		mailInfo.setMailServerHost("smtp.126.com");
		mailInfo.setMailServerPort("25");
		mailInfo.setValidate(true);
		mailInfo.setUserName("newsmetro@126.com");
		mailInfo.setPassword("<utf-8>");// 您的邮箱密码
		mailInfo.setFromAddress("newsmetro@126.com");
		mailInfo.setToAddress(user.getEmail());
		mailInfo.setSubject("newsmetro用户修改密码");
		mailInfo.setContent("请点击下面的链接以完成密码重置操作！<br/>"
				+ "<a href='"+url+"'>" +url+ "</a>");
		SimpleMailSender sms = new SimpleMailSender();
		sms.sendHtmlMail(mailInfo);
		logger.info("用户修改密码:" + user.getId() + "|"+ user.getEmail());
		infoMap.put("info","已发送密码修改连接至您的邮箱，请查收！" );
		return new ModelAndView("/activeInfo",infoMap);
	}
	
	@RequestMapping(value="/toResetPassword.html")
	public ModelAndView toResetPassword(HttpServletRequest request){
		clearSession(request, "user");
		request.setAttribute("key", request.getParameter("key"));
		return new ModelAndView("/resetPassword");
	}
	
	@RequestMapping(value="/resetPassword.html")
	public ModelAndView resetPassword(HttpServletRequest request){
		Map<String,String> infoMap = new HashMap<String, String>();
		clearSession(request, "user");
		String newPass = request.getParameter("newPass");
		if(newPass==null||newPass.equals("")){
			infoMap.put("info", "请输入正确的密码");
			return new ModelAndView("/activeInfo",infoMap);
		}
		String md5Pass = MD5Util.md5(newPass, MD5Util._32_BIT);
		String signInKey = request.getParameter("key");
		String decodeKey = null;
		String array[] = null;
		try {
			decodeKey = desUtil.getDecryptString(URLDecoder.decode(signInKey,"utf-8"),key);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(decodeKey==null){	
			infoMap.put("info", "用户信息未通过验证，请重新获取密码修改地址.");
			return new ModelAndView("/activeInfo",infoMap);
		}
		array = decodeKey.split("\\|\\|");
		String email = null;
		String password = null;
		if(array.length!=2){
			infoMap.put("info", "用户信息未通过验证，请重新获取密码修改地址.");
			return new ModelAndView("/activeInfo",infoMap);
		}
		email = array[0];
		password = array[1];
		User user = userService.signIn(email, password);
		if(user==null){
			infoMap.put("info", "用户信息未通过验证，请重新获取密码修改地址.");
			return new ModelAndView("/activeInfo",infoMap);
		}
		user.setPassword(md5Pass);
		userService.updateUser(user);
		infoMap.put("info", "密码修改成功！请登录。");
		return new ModelAndView("/activeInfo",infoMap);
	}
	
	
	private boolean validatSignUpForm(Map<String,String> errorMap,SignUpForm form){
		
		boolean flag = true;
		if(!ValidateAssert.notEmpty(form.getEmail())){
			errorMap.put("email", ValidateAssert.NULL_ERROR);
			flag = false;
		}
		if(!ValidateAssert.notEmpty(form.getPassword())){
			errorMap.put("password", ValidateAssert.NULL_ERROR);
			flag = false;
		}
		if(!ValidateAssert.notEmpty(form.getRepassword())){
			errorMap.put("repassword", ValidateAssert.NULL_ERROR);
			flag = false;
		}
		if(!flag){
			return false;
		}
		
		if(!ValidateAssert.matchRegex("[\\w_\\.]+@[\\w\\-_]+\\.[^\\s]+", form.getEmail())){
			if(errorMap.get("email")==null){
				errorMap.put("email", "请输入正确的email地址");
			}
			flag = false;
		}
		if(!ValidateAssert.matchRegex(".{6,20}", form.getPassword())){
			if(errorMap.get("password")==null){
				errorMap.put("password", "密码是6~20位字符");
			}
			flag = false;
		}
		
		if(!form.getPassword().equals(form.getRepassword())){
			errorMap.put("repassword", "两次密码不一致");
			flag=false;
		}
		return flag;
	}
	private void clearSession(HttpServletRequest request,String key) {
		if(request.getSession().getAttribute(key)!=null){
			request.getSession().removeAttribute(key);
		}
	}
}
