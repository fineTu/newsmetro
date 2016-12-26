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
			<div class="p10">
				<div class="fl ml10">
					<span class="fl mr30" style="line-height:76px; font-size: 22px;">
						管理
					</span>
					<span class="fl mr20"><a class="a_link"
							 style="line-height:76px; font-size: 14px; color:#666;"
							 href="<c:url value="/myTargetList.html"/>">订阅管理</a>
					</span>
					<span class="fl mr20"><a class="a_link"
							 style=" line-height:76px; font-size: 14px;"
							 href="<c:url value="/userTargetList.html"/>">发布管理</a>
					</span>
				</div>
				<div class="fl">
					<a href="javascript:void(0);" id="add_res" class="a_link_guan"
						style="line-height:70px; font-size: 36px;  font-weight: bold;"
						onclick="javascript:$('#span_add_user_target').toggle(0);">+</a>
				</div>
                <div class="cb"></div>
				<div id="add_form" style=" display:none; position: relative;">
					<span id="span_add_user_target" class="none">
						<form id="form_add_user_target" action="<c:url value="/addUserTarget.html"/>">
							<span><span>名称：</span><input name="userTargetName" type="text" /></span>
							<input type="submit" value="提交"/>
						</form>
					</span>
				</div>
				<div class="cb"></div>
				<div style="margin:20px 20px 0px 0px; border-bottom:1px dashed #bbb;">
				</div>
                <div class="cb"></div>
			</div>
			<div class="cb" ></div>
			<div>
				<c:forEach items="${requestScope.userTargetList}" var="ut" varStatus="st">
					<div class="p10" >
						<div>
							<c:choose>
								<c:when test="${ut.status==1}">
									<div class="fl"><span style="font-size: 16px;"><a class="a_link" href="<c:url value="/userTargetDetail.html"/>?userTargetId=<c:out value="${ut.id}" />"><c:out value="${ut.name}" /></a></span></div>
								</c:when>
								<c:otherwise>
									<div class="fl"><span style="font-size: 16px;color: #ccc;"><c:out value="${ut.name}" /></span></div>
								</c:otherwise>
							</c:choose>
							<div class="fl ml10" style="margin-top:3px;"><a class="a_link_guan" href="javascript:void(0);" onclick="javascript:$('#span_add_news').toggle(0);">新增</a></div>
							<div class="cb"></div>
							<div id="span_add_news" class="none">
								<form id="form_add_news" action="<c:url value="/addNews.html"/>">
									<input type="hidden" value="<c:out value="${ut.id}" />" name="userTargetId" />
									<div><span><span>名称：</span><input name="title" type="text" /></span></div>
									<div><span><span>链接：</span><input name="link" type="text" width="200px" /></span></div>
									<%--<div><span><span style="float: top;">内容：</span><textarea name="content" ></textarea></span></div>--%>
									<input type="submit" value="提交"/>
								</form>
							</div>
						</div>
						<ul class="ml20">
							<c:forEach items="${ut.newsList}" var="news" varStatus="st">
								<li class="mt10">
									<c:choose>
										<c:when test="${news.content==null}">
											<div><span><a class="a_link" target="_blank" href="<c:out value="${news.link}" />"><c:out value="${news.title}" /></a></span></div>
										</c:when>
										<c:otherwise>
											<div><span style="color: #ccc;"><a class="a_link" href="/newsDetail.html?newsId=<c:out value="${news.id}" />"><c:out value="${news.title}" /></a></span></div>
										</c:otherwise>
									</c:choose>
								</li>
							</c:forEach>
						</ul>
					</div>
				</c:forEach>

			</div>
		</div>
	</div>
    
  </body>
  <script type="text/javascript">
  	function deleteTarget(id){
  		if(confirm("是否确认删除?")){
	  		$.ajax({
				type : "POST",
				url : "deleteTarget.html",
				data: {"id":id},
	   	 		dataType: "json",
				success : function(data) {
					if(data.res == true){
						$("#li_"+id).attr("style","display:none;");
					}else{
						alert("删除失败鸟~");
					}
				}
			});
		}
  	}
  	function hideTarget(id){
	  	$.ajax({
			type : "POST",
			url : "hideTarget.html",
			data: {"id":id},
	   		dataType: "json",
			success : function(data) {
				if(data.res == true){
					$("#show_switch_"+id).html("<span><a class='a_link_guan' href='javascript:showUpTarget("+id+");'>显示</a></span>");
				}else{
					alert("设置失败鸟~");
				}
			}
		});
  	}
  	function showUpTarget(id){
	  	$.ajax({
			type : "POST",
			url : "showUpTarget.html",
			data: {"id":id},
  	 		dataType: "json",
			success : function(data) {
				if(data.res == true){
					$("#show_switch_"+id).html("<span><a class='a_link_guan' href='javascript:hideTarget("+id+");'>隐藏</a></span>");
				}else{
					alert("设置失败鸟~");
				}
			}
		});
  	}
  	
  	/* 点击添加 */
	$('#add_res').click(function(){
		$('#add_form').toggle(0);
	});

    function tryRss(){
		if($.trim($("#rss_url").val()).length < 1){
			alert("请输入url地址！");
			return;
		}
		$("#btn_try_rss").attr('disabled',"true");
		$("#btn_try_rss").attr('value','tring...');

		var loading = '<img class="mt50" src="img/loading.gif" />';
		$("#list_view").append(loading);
        var formData = $('#try_rss_form').serialize();

        $.ajax({
            type : "POST",
            dataType : "html",
            data : formData,
            async:true,
            url : "tryRss.html",
            success : function(data){
				$("#btn_try_rss").removeAttr("disabled");
				$("#btn_try_rss").attr('value','try');
				jsonObj = eval("("+data+")");
				if(jsonObj.isSuccess==true){
					$("#name_view").html("");
					$("#name_view").append("<a class='a_link_blue f16' href='"+jsonObj.link+"' >" + jsonObj.title + "</a>");
					var itemList =  jsonObj.itemList;
					$("#list_view").html("");
					var length = (itemList.length<=12)?itemList.length:12;
					for (var i=0;i<itemList.length;i++){
						if(i<length){
							$("#list_view").append("<li class='mb5'><a id='item_view"+"_"+i+
							"' class='a_link' target='_blank' href="+itemList[i].href+" >"+itemList[i].text+"</a></li>");
						}
					}
					$("#rss_cache").val(JSON.stringify(jsonObj.itemList));
					$("#btn_save_rss").removeAttr("disabled");
				}else{
					$("#name_view").html("");
					$("#name_view").append("<a class='a_link_blue f16' href='"+jsonObj.link+"' >" + jsonObj.link + "</a>");
					var msg = '<span class="mt50">解析未成功</span>';
					$("#list_view").html("");
					$("#list_view").append(msg);
				}

			}
        });
    }

	function tryWeb(){
		if($.trim($("#web_url").val()).length < 1){
			alert("请输入url地址！");
			return;
		}
		if($.trim($("#web_xpath").val()).length < 1){
			alert("请输入xpath地址！");
			return;
		}
		$("#btn_try_web").attr('disabled',"true");
		$("#btn_try_web").attr('value','tring...');

		$("#list_view").html("");
		var loading = '<img class="mt50" src="img/loading.gif" />';
		$("#list_view").append(loading);
		var formData = $('#try_web_form').serialize();
		$("#web_cache").val(null);
		$.ajax({
			type : "POST",
			dataType : "html",
			data : formData,
			async:true,
			url : "tryWeb.html",
			success : function(data){
				$("#btn_try_web").removeAttr("disabled");
				$("#btn_try_web").attr('value','try');
				jsonObj = eval("("+data+")");
				if(jsonObj.isSuccess==true){
					$("#name_view").html("");
					$("#name_view").append("<a class='a_link_blue f16' target='_blank' href='"+$("#web_url").val()+"' >" + $("#web_url").val() + "</a>");
					var itemList = jsonObj.itemList;
					$("#list_view").html("");
					var length = (itemList.length<=12)?itemList.length:12;
					for (var i=0;i<itemList.length;i++){
						if(i<length){
							$("#list_view").append("<li class='mb5'><a id='item_view"+"_"+i+
							"' class='a_link' target='_blank' href="+itemList[i].href+" >"+itemList[i].text+"</a><li>");
						}
					}
					$("#web_cache").val(JSON.stringify(jsonObj.itemList));
					$("#btn_save_web").removeAttr("disabled");
				}else{
					$("#name_view").html("");
					$("#name_view").append("<a class='a_link_blue f16' href='"+jsonObj.link+"' >" + jsonObj.link + "</a>");
					var msg = '<span class="mt50">解析未成功</span>';
					$("#list_view").html("");
					$("#list_view").append(msg);
				}

			}
		});
	}

    function submitForm(formId, formAction) {
        var formData = $('#' + formId).serialize();

        $.ajax({
            type : "POST",
            dataType : "html",
            data : formData,
            async:true,
            url : formAction,
            success : function(data) {

            }
        });
    }


	/* 显示新闻 */
	function showNews(targetIndex,itemIndex){
		if(pointedItem!=null){
			$(pointedItem).attr("style","line-height:20px;");
		}else{
			/* $("content").attr("style","width:1000px;"); */
		}
		pointedItem = $("#item_"+(targetIndex+1)+"_"+itemIndex);
		$("#item_"+(targetIndex+1)+"_"+itemIndex).attr("style","line-height:20px; font-weight: bold;");
		$("#left_panel").attr("style","width:370px;");
		$("#page_switch").attr("style","display:block; width:100%");

		trunBlockHide();
		groupIndex = Math.floor(targetIndex/2);
		trunGroupShow(groupIndex);

		$("#news_panel").html("");
		var titleDiv = "<div style='margin:0 auto; font-size:20px; font-weight: bold; margin-bottom:30px;'><a target='_blank' class='a_link color_blue' href='"+targetItems[targetIndex][itemIndex].linkUrl+"' >"+targetItems[targetIndex][itemIndex].title+"</a><div>";
		$("#news_panel").append(titleDiv,targetItems[targetIndex][itemIndex].description.htmlCode);
		$("#news_panel").attr("style","width:530px; display:block;");

	}

	var selectedGroup = null;
	var selectedId=null;
	function show_func(groupId,id,flag){
		if(flag==1){
			$('#func_'+groupId+'_'+id).show();
			$('#div_target_item_'+id).attr('onclick','javascript:show_func('+groupId+','+id+',2)');
			if(selectedId!=null&&selectedGroup!=null){
				$('#func_'+selectedGroup+'_'+selectedId).hide();
				$('#div_target_item_'+selectedGroup+'_'+selectedId).attr('onclick','javascript:show_func('+selectedGroup+','+selectedId+',1)');
			}
			selectedGroup = groupId;
			selectedId = id;
		}else{
			$('#func_'+selectedGroup+','+id).hide();
			$('#div_target_item_'+groupId+'_'+id).attr('onclick','javascript:show_func('+groupId+','+id+',1)');
			selectedGroup=null;
			selectedId = null;
		}
	}
	function addToGroup(groupId,targetId){
		targeGroupId = $("#group_select_"+groupId+'_'+targetId).val();
		if($.trim(targeGroupId)<=0){
			return;
		}
		url = "<%=basePath%>/addToGroup.html?targetId="+targetId+"&targetGroupId="+targeGroupId;
		$.ajax({
			type : "POST",
			dataType : "html",
			async:true,
			url : url,
			success : function(data) {
				window.location.href = '<%=basePath%>//myTargetList.html';
			}
		});
	}
	function removeFromGroup(groupId,targetId){
		url = "<%=basePath%>/removeFromGroup.html?targetId="+targetId+"&targetGroupId="+groupId;
		$.ajax({
			type : "POST",
			dataType : "html",
			async:true,
			url : url,
			success : function(data) {
				window.location.href = '<%=basePath%>//myTargetList.html';
			}
		});
	}
  </script>
</html>

