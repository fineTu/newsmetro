<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>NewsMetro ——你最懂自己</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/base-min.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="shortcut icon" href="img/newsmetro_logo_blue_16.ico" type="image/x-icon" />
  </head>
  
  <body style="font-family:微软雅黑;">
  	<div class="container cf">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="content">
			<div>
				<div class="fl" style="margin-left: 100px; margin-top:150px; ">
					<div>
						<div class="fl f36 mt30">
							<b>News</b><img src="img/newsmetro_logo_blue.png" style="height:40px;" /><b>etro</b>
						</div>
						<div class="fl ml10 f12" style="color:#ccc;margin-top:55px;">—你最懂自己</div>
					</div>
					<div class="cb mb10"></div>
					<div style="font-size: 16px;">
						提供自助的web，以及Rss资源订阅服务。
					</div>
				</div>
				<div class="fl" style="margin-left: 100px;">
					<form action='<c:url value="/signup.html"/>' method="post" style="margin:200px 0 200px 0;">
						<div class="mb10">
							<span class="w70 fl">邮箱：</span>
							<div class="fr">
								<input class="fl" value="<c:out value='${requestScope.signUpForm.email }' />" name="email" type="text" />
								<span class="fr alertLabel w100"><c:out value="${requestScope.validateMap['email'] }" /></span>
							</div>
						</div>
						<div class="cb mb10"></div>
						<div class="mb10">
							<span class="w70 fl">密码：</span>
							<div class="fr">
								<input class="fl" value="<c:out value='${requestScope.signUpForm.password }' />" name="password" type="password" />
								<span class="fr alertLabel w100"><c:out value="${requestScope.validateMap['password'] }" /></span>
							</div>
						</div>
						<div class="cb mb10"></div>
						<div class="mb10">
							<span class="w70 fl">确认密码：</span>
							<div class="fr">
								<input class="fl" value="<c:out value='${requestScope.signUpForm.repassword }' />" name="repassword" type="password" />
								<span class="fr alertLabel w100 "><c:out value="${requestScope.validateMap['repassword'] }" /></span>
							</div>
						</div>
						<div class="cb mb10"></div>
						<div style="font-size:16px;">
							<input class="signup_btn" type="submit" value="注册" />
							<span><a href='<c:url value="/toHelper.html" />' class="a_link_blue" style="font-size:12px;">newsmetro是什么？</a></span>
						</div>
					</form>
				</div>
			</div>
		</div>
		
	</div>
  </body>
</html>
