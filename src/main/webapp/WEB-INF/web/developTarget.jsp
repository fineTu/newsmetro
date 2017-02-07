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
	<link rel="shortcut icon" href="img/newsmetro_logo_blue_16.ico" type="image/x-icon" />
	<link rel="stylesheet" href="js/codemirror/lib/codemirror.css">
	<link rel="stylesheet" href="js/codemirror/theme/xq-light.css">
	<link rel="stylesheet" type="text/css" href="css/base-min.css">
	<link rel="stylesheet" type="text/css" href="css/common.css">
	<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
	<script src="js/codemirror/lib/codemirror.js"></script>
	<script src="js/codemirror/mode/xquery/xquery.js"></script>
	<script src="js/codemirror/mode/jinja2/jinja2.js"></script>
	<style type="text/css">
		.CodeMirror {
			border: 1px solid #999;
			height:320px;
		}
	</style>

</head>

<body style="font-family:Microsoft YaHei;">
<div class="container cf" >
	<jsp:include page="header.jsp"></jsp:include>
	<div id="content" class="content" >
		<div >
			<div >
				<div class="fl" style="margin-top:20px;">
					<span style="font-size:24px;" >
						开发资源
					</span>
				</div>
				<div class="cb"></div>
			</div>
			<div id="splite" class="cb"></div>
			<div id="dev">
				<form id="dev_form" method="post">
					<div class="mt10">
						<div class="fl"><span class="f14">资源名：</span><input id="form_name" class="w80" name="name" type="text" value="<c:out value="${target.name }" />" /></div>
						<div class="fl"><span class="f14">地址：</span><input id="form_url" class="w240" name="url" type="text" value="<c:out value="${target.url }" />" /></div>
						<div class="fl"><span class="f14">xpath：</span><input id="form_xpath" class="w240" name="relXpath" type="text" value="<c:out value="${target.relXpath }" />" /></div>
						<div class="fl">
							<span class="f14">状态：</span>
							<c:choose>
								<c:when test="${target.status==1}">
									<span class="f14">在线</span>
								</c:when>
								<c:when test="${target.status==2}">
									<span class="f14">隐藏</span>
								</c:when>
								<c:when test="${target.status==3}">
									<span class="f14">暂存</span>
								</c:when>
								<c:when test="${target.status==null}">
									<span class="f14">未保存</span>
								</c:when>
							</c:choose>
						</div>
						<input type="hidden" name="id" value="<c:out value="${target.id }" />" />
						<input type="hidden" name="type" value="<c:out value="${target.type }" />" />
						<input id="form_status" type="hidden" name="status" value="<c:out value="${target.status }" />" />
					</div>
					<div class="cb"></div>
					<div class="mt10">
						<span class="f14 fl" >xquery:</span>
						<span class="fr"><input type="button" value="提交测试" id="btn_try_xquery"  onclick="javascript:tryXquery();"/></span>
						<span id="sp_load_xquery" class="f14 fr"  ></span>
						<div class="cb"></div>
						<div id="xquery_code">
							<textarea id="code_xquery" name="xquery" ><c:choose><c:when test="${target.template!=null}"><c:out value="${target.xquery }" /></c:when><c:otherwise><c:out value="${xqueryTemp}" /></c:otherwise></c:choose></textarea>
						</div>
					</div>
					<div id="xquery_res" class="mt10">
						<textarea id="code_res" rows="12" cols="124" style="resize: none;" readonly="readonly" name="xquery_res" ><c:out value="${targetCache.items }" /></textarea>
					</div>
					<div class="mt20">
						<div>
							<span class="f14" >html模板(jinja2):</span>
							<input type="button" value="提交测试" id="btn_try_temp" onclick="javascript:tryTemplate();" class="fr"/>
							<span id="sp_load_temp" class="f14 fr"  ></span>
							<div class="cb"></div>
							<div id="temp_code">
								<textarea id="code_jinja2" name="template" ><c:choose><c:when test="${target.template!=null}"><c:out value="${target.template }" /></c:when><c:otherwise><c:out value="${tempTemp}" /></c:otherwise></c:choose></textarea>
							</div>
						</div>
						<div>
							<div class="mt10 fl">
								<div class="f14">渲染结果：</div>
								<div id="temp_res" style="width:420px; background-color:#f0f0f0;">
								</div>
							</div>
							<div class="mt10 fl">
								<div class="f14">结果代码：</div>
								<textarea readonly="readonly" class="mt10 fl" rows="12" cols="60" id="temp_res_code" style="width:420px; height:346px;"></textarea>
							</div>
						</div>
					</div>
					<!-- <div class="cb"></div> -->
					<div class="mt20 cb" style="width: 100%;">
						<input style="margin: 0 10; float:left;" type="button" onclick="javascript:addTarget(1);" value="保存资源"/>
						<input style="margin: 0 10; float:left;" type="button" onclick="javascript:addTarget(3);" value="暂存资源"/>
					</div>
				</form>
			</div>

		</div >

	</div>
</div>
<script>
	var xquery_editor = CodeMirror.fromTextArea(document.getElementById("code_xquery"), {
		mode:{name:"xquery",htmlMode:true},
		lineNumbers: true,
		matchBrackets: true,
		theme: "xq-light"
	});
	var jinja_editor = CodeMirror.fromTextArea(document.getElementById("code_jinja2"), {
		mode:{name:"jinja2",htmlMode:true},
		lineNumbers: true,
		matchBrackets: true
	});
</script>
</body>
<script type="text/javascript">

	function tryXquery(){
		if($.trim($("#form_url").val()).length < 1){
			alert("请输入url地址！");
			return;
		}
		if($.trim($("#form_xpath").val()).length < 1){
			alert("请输入xpath地址！");
			return;
		}
		$("#btn_try_xquery").attr('disabled',"true");

		$("#code_res").val("");
		var loading = '<img class="mt5" src="img/loading.gif" />';
		$("#sp_load_xquery").append(loading);
		xquery_editor.save();
		var formData = $('#dev_form').serialize();
		$.ajax({
			type : "POST",
			dataType : "html",
			data : formData,
			async:true,
			url : "tryXquery.html",
			success : function(data){
				$("#code_res").css("color","black");
				$("#btn_try_xquery").removeAttr("disabled");
				jsonObj = eval("("+data+")");
				if(jsonObj.is_success==true) {
					$("#code_res").val(JSON.stringify(jsonObj.data));
					$("#sp_load_xquery").html("");
				}else if(jsonObj.is_success==false){
					$("#code_res").css("color","red");
					$("#code_res").val(JSON.stringify(jsonObj.data.data.msg));
					$("#sp_load_xquery").html("");
				}else{
					$("#code_res").val("");
					var msg = '<span class="mt50">解析未成功</span>';
					$("#sp_load_xquery").html("");
					$("#sp_load_xquery").append(msg);
				}
			}
		});
	}

	function tryTemplate(){
		if($.trim($("#code_res").val()).length < 1){
			alert("请先验证xpath与xquery的有效性！");
			return;
		}

		$("#btn_try_temp").attr('disabled',"true");

		$("#temp_res").val("");
		var loading = '<img class="mt5" src="img/loading.gif" />';
		$("#sp_load_temp").append(loading);
		xquery_editor.save();
		jinja_editor.save();
		var formData = $('#dev_form').serialize();
		$.ajax({
			type : "POST",
			dataType : "html",
			data : formData,
			async:true,
			url : "tryTemplate.html",
			success : function(data){
				$("#temp_res").css("color","black");
				$("#btn_try_temp").removeAttr("disabled");
				jsonObj = eval("("+data+")");
				if(jsonObj.is_success==true){
					$("#temp_res").html(jsonObj.html);
					htmlStr = jsonObj.html
					/* var reg = new RegExp("\'","g");//g,表示全部替换
					htmlStr = htmlStr.replace(reg,"\\\'");
					reg = new RegExp("\"","g");
					htmlStr = htmlStr.replace(reg,"\\\""); */
					$("#temp_res_code").html(htmlStr);
					$("#sp_load_temp").html("");
				}else if(jsonObj.is_success==false){
					$("#temp_res").css("color","red");
					$("#temp_res").html("<p>"+jsonObj.html+"</p>");
					$("#sp_load_temp").html("");
				}else{
					$("#temp_res").html("");
					var msg = '<span class="mt50">解析未成功</span>';
					$("#sp_load_temp").html("");
					$("#sp_load_temp").append(msg);
				}
			}
		});
	}
	
	function addTarget(status){
		if($.trim($("#form_name").val()).length < 1){
			alert("请填写资源名称！");
			return;
		}
		if($.trim($("#form_url").val()).length < 1){
			alert("请填写资源url！");
			return;
		}
		if($.trim($("#form_xpath").val()).length < 1){
			alert("请填写资源xpath！");
			return;
		}
	    $("#form_status").val(status)
		var formData = $('#dev_form').serialize();
		$.ajax({
			type : "POST",
			dataType : "html",
			data : formData,
			async:true,
			url : "addTarget.html",
			success : function(data){
				jsonObj = eval("("+data+")");
				if(jsonObj.is_success==true){
					window.location.href="<%=basePath%>toNewsCenter.html"
				}else if(jsonObj.is_success==false){
					alert(jsonObj.reason);
				}else{
					alert("服务器出错！");
				}
			}
		});
	}
</script>
</html>
