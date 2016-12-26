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
    
    <title>NewsMetro是什么？</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/base-min.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="shortcut icon" href="img/newsmetro_logo_blue_16.ico" type="image/x-icon" />
	<style type="text/css">
		p{margin-top:10px; font-size:14px; }
		b{font-size:16px; }
	</style>
  </head>
  
  <body style="font-family:微软雅黑;">
  	<div class="container cf">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="content">
			<p>&nbsp;</p>
			<p>
				<b>写在前面：</b>
			</p>
			<p>
				newsmetro是本人个人业余时间所开发，目前只是一个产品原型，所以如果你看到这篇教程，那你不是我朋友就是有缘人，对于这个简陋的网站的任何建议都可以发送到我的邮箱sklxz@qq.com或者QQ联系：125463585。
			</p>
			<p>
				chrome扩展开发质量之差，体验之渣，真的非常抱歉，网上chrome扩展资料非常少，在此感谢360对官方文档的翻译。到目前为止我还是不知道如何设定全局的记住登录状态，以及如何正常关闭扩展。如果有高手知道，请联系我！
			</p>
			<p>
				------------------------------------------------------------------------------------------------------------------------
			</p>
			<p>&nbsp;</p>
			<p>
				<b>什么是newsmetro？</b>
			</p>
			<p>
				newsmetro致力于为每个用户提供自助的网络资讯订阅服务。日复一日，你有没有发现自己的网络阅读变得很有规律？早上打开电脑先上新浪、搜狐看看头条，随后打开36kr、虎嗅阅读业界新闻，最后开始刷微博，逛知乎...在这个过程中我们切换了如此多的网站，偌大的网页只有那一块是我们关注的。那何不把这些拼在一起？newsmetro致力于解决这一问题，为每个人打造属于自己的资讯主页！
如何使用newsmetro？
			</p>
			<p>&nbsp;</p>
			<p>
				<b>如何使用newsmetro？</b>
			</p>
			<p>
				1.注册/登录。注册账号并激活后就可以登入newsmetro为你准备的新闻中心，这里是newsmetro的主要功能区。
			</p>
			<p>
				2.添加网络资源。newmetro中有两种网络资源——传统的Rss订阅、web页面的定位资源。
			</p>
			<p>
				对于Rss资源我们通过url添加：
			</p>
			<p>
				<img src="resource/1.png" />
			</p>
			<p>
				下面介绍web资源的添加，web资源是展示在web页面上的资讯位置，比如各大门户的新闻头条、体育版块、经济板块等等，我们利用newsmetro配套的chrome插件对这些资源进行定位，这样就可以把这种web资源加入到自己的新闻中心。因本人精力有限，目前只支持chrome的插件，不便之处还请谅解！
			</p>
			<p>
				使用插件定位资源的步骤如下：
			</p>
			<p>
				1.在网站首页下载插件。
			</p>
			<p>
				<img src="resource/2.png" />
			</p>
			<p>
				下载成功后chrome会报无法执行用户脚本的提示，因为这个插件目前非常的简陋，还未入驻chrome的app storechrome为安全期间没有直接安装。
			</p>
			<p>
				首先打开chrome的扩展程序管理页面。
			</p>
			<p>
				<img src="resource/3.png" />
			</p>
			<p>
				然后在下载路径下找到刚才下载的newsmetro.crx扩展包。
			</p>
			<p>
				<img src="resource/4.png" />
			</p>
			<p>
				把扩展包拖动进扩展管理页面即可。（like a boss ah？不自觉开始吐槽了呢-_-|）
			</p>
			<p>
				这时候扩展列表中会出现一个无图标，非app store的山寨扩展，不要在意这些细节！
			</p>
			<p>
				<img src="resource/5.png" />
			</p>
			<p>
				这时候在chrome的扩展栏上出现newsmetro的图标。标志着我们的渣体验才刚刚开始。
			</p>
			<p>
				<img src="resource/6.png" />
			</p>
			
			<p>
				OK，假设我们想持续关注搜狐主页上的头条版，首先进入搜狐首页，输入用户名密码，登录newsmetro。
			</p>
			<p>
				什么？点登陆没反应？那就对了，刷新页面你会发现你已经登录上了。
			</p>
			<p>
				然后我们发现扩展正在跟随鼠标指针解析页面元素，进而出现红色的方框，我们通过shift键调节所选元素的层次，调节时注意方框的颜色，方框变蓝时说明此位置是可以被newsmetro解析并记录的，按alt键锁定，然后我们输入位置的名字，把这个位置提交到newsmetro。
			</p>
			<p>
				<img src="resource/7.png" />
			</p>
			<p>
				<img src="resource/8.png" />
			</p>
			<p>
				提交后提示提交成功，那么整个资源采集流程圆满结束。
			</p>
			<p>
				<img src="resource/9.png" />
			</p>
			<p>
				刷新你的新闻中心页面，搜狐头条已经尽在掌握！
			</p>
			<p>
				<img src="resource/10.png" />
			</p>
			<p>
				3.管理资源。添加好自己喜欢的新闻资源后，还可对这些资源进行管理。
			</p>
			<p>
				<img src="resource/11.png" />
			</p>
			<p>
				点击网站顶端的“管理”即可打开管理页面：
			</p>
			<p>
				<img src="resource/12.png" />
			</p>
			<p>
				目前的原型只有这些核心功能，感谢您的阅读！
			</p>
		</div>
		<div class="cb" ></div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
    
  </body>
</html>
