<%@ page language="java" import="java.util.*,com.newsmetro.enumeration.TargetStatus" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <% pageContext.setAttribute("regularEnum", TargetStatus.REGULAR); %>
    <% pageContext.setAttribute("hidenEnum", TargetStatus.HIDE); %>
    <title>NewsMetro 管理信息源</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="css/base-min.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<link rel="shortcut icon" href="img/newsmetro_logo_blue_16.ico" type="image/x-icon" />
	  <style type="text/css">
		  li {list-style-type:none;}
	  </style>
  </head>
  
  <body style="font-family:Microsoft YaHei;">
  	<div class="container cf">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="content">
			<div class="p10 f14" >
				<div class="mt50">
					<div>
						<div style="float:left; color: #177cb0; font-size: 20px;"><c:out value="${userTarget.name}" /></div>
						<c:if test="${userTarget.isAuthor==1}">
							<div class="fl ml10" style="margin-top:3px;"><a class="a_link_guan" href="javascript:void(0);" onclick="javascript:$('#span_add_news').toggle(0);">新增</a></div>
						</c:if>
					</div>
					<div class="cb"></div>
					<div id="span_add_news" class="none">
						<form id="form_add_news" action="<c:url value="/addNews.html"/>">
							<input type="hidden" value="<c:out value="${userTarget.id}" />" name="userTargetId" />
							<div><span><span>名称：</span><input name="title" type="text" /></span></div>
							<div><span><span>链接：</span><input name="link" type="text" width="200px" /></span></div>
							<%--<div><span><span style="float: top;">内容：</span><textarea name="content" ></textarea></span></div>--%>
							<input type="submit" value="提交"/>
						</form>
					</div>
				</div>
			</div>
				<div class="cb" ></div>
			<div>
				<c:forEach items="${requestScope.newsList}" var="news" varStatus="st">
				<div class="p10 f14" >
					<c:choose>
						<c:when test="${news.content==null}">
							<div><span><a class="a_link" target="_blank" href="<c:out value="${news.link}" />"><c:out value="${news.title}" /></a></span></div>
						</c:when>
						<c:otherwise>
							<div><span style="color: #ccc;"><a class="a_link" href="/newsDetail.html?newsId=<c:out value="${news.id}" />"><c:out value="${news.title}" /></a></span></div>
						</c:otherwise>
					</c:choose>
				<ul class="ml20">

				</ul>
				</div>
				</c:forEach>

			</div>
		</div>
	</div>
    
  </body>

</html>

