<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="header shadow_d_3 pr">
<div class="fl"><a class="logo" href="<c:url value='/' />">NewsMetro</a></div>
    <div class="left_bar pr ml75">
    	<ul class="fl">
    		<li class="fl" ><a class="a_bt" href="<c:url value='/toNewsCenter.html' />" >新闻中心</a></li>
			<li class="fl" ><a class="a_bt" href="<c:url value='/userTargetSquare.html' />" >广场</a></li>
    		<li class="fl" ><a class="a_bt" href="<c:url value='/myTargetList.html'/>" >管理</a></li>
    		<li class="fl" ><a class="a_bt" href="javascript:void(0);" >个人档</a></li>
    	</ul>
    </div>
	<div class="right_bar pr">
    <c:choose>
    <c:when test="${sessionScope.user!=null}">
    	<ul>
    		<li class="fr"><a class="a_bt" href="javascript:void(0);"><c:out value="${sessionScope.user.name}" /></a></li>
    		<li class="fl"><a class="a_bt" href="signout.html">注销</a></li>
    	</ul>
    </c:when>
    <c:otherwise>
    	<ul>
    		<li class="fr"><a class="a_bt" href="signup.html">注册</a></li>
    		<li class="fr"><a id="signin_btn" class="a_bt" href="javascript:void(0);">登录</a></li>
    	</ul>
    </c:otherwise>
    </c:choose>
    </div>
	<div id="sigin_div" class="signin_div shadow_d_3">
		<div style="font-size:16px; margin-bottom:10px;">登录：</div>
		<form method="post" action="<c:url value="/signin.html"/>">
			<div class="">
				<div class="mb10">
					<span class="w70">邮箱：</span> <input class="fr" name="email"
						type="text" />
				</div>
				<div class="mb10">
					<span class="w70">密码：</span> <input class="fr" name="password"
						type="password" />
				</div>
				<div style="font-size:14px;">
					<input class="signup_btn" type="submit" value="登录" />&nbsp;&nbsp;
					<a href='<c:url value="/toSendResetPassMail.html"/>' style="color:#ccc; font-size:10px;" >忘记密码</a>
				</div>
			</div>
		</form>
	</div>
	<script type="text/javascript" src="js/jquery-1.9.1.min.js" ></script>
	<script type="text/javascript">
		$('#signin_btn').click(function(){
			$('#sigin_div').toggle(100);
		});
	</script>
</div>