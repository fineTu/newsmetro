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
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>

</head>

<body style="font-family:Microsoft YaHei;">
<div class="container cf" >
	<jsp:include page="header.jsp"></jsp:include>
	<div id="content" class="content" >
		<div >
			<div class="p10">
				<div class="fl ml10" style="margin-top:20px;">
						<span class="f20" >
							实时
						</span>
				</div>
				<div class="cb"></div>
			</div>
			<div id="splite" class="cb"></div>
			<div id="news_list">
				<ul>
				<c:forEach items="${newsList}" var="news" >
					<li class='mb5'>
						<a class='a_link' style='line-height:20px;' href='<c:out value="${news.link}"/>' target='_blank' >
							<c:out value="${news.title}"/>
						</a>
						<span class="ml20 color_gray"><c:out value="${news.targetName}"/></span>
						<span class="ml10 color_gray"><c:out value="${news.publishDate}"/></span>
					<li>

				</c:forEach>
				</ul>
			</div>

		</div >

	</div>
</div>

</body>
<script type="text/javascript">

	$(document).bind("selectstart",function(){return false;});


</script>
</html>
