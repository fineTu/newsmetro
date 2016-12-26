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
					<span class="fl mr20">
						<a class="a_link"
						   style="line-height:76px; font-size: 14px;"
						   href="<c:url value="/myTargetList.html"/>">订阅管理</a>
					</span>
					<span class="fl mr20">
						<a class="a_link"
						   style=" line-height:76px; font-size: 14px; color:#666;"
						   href="<c:url value="/myTargetList.html"/>">发布管理</a>
					</span>
				</div>
				<div class="fl">
					<a href="javascript:void(0);" id="add_res" class="a_link_guan"
						style="line-height:70px; font-size: 36px; font-weight: bold;">+</a>
				</div>
                <div class="cb"></div>
				<div id="add_form" style=" display:none; position: relative;">
					<div style="float:left; width:400px; line-height:40px; ">
						<input type="radio" id="add_rss_radio" name="isRss" value="true" checked="checked"
							   onclick="$('#add_rss_form').attr('style','display:block;');$('#add_web_form').attr('style','display:none;');"  />
						<span style="font-size:16px; margin-right: 24px;">Rss</span>
						<input type="radio" id="add_web_radio" name="isRss" value="false"
							   onclick="$('#add_web_form').attr('style','display:block;');$('#add_rss_form').attr('style','display:none;');"/>
						<span style="font-size:16px;">Web</span>
						<div id="add_rss_form" >
							<form id="try_rss_form" action="<c:url value='/addTarget.html' />" method="post">
								<div>资源名：<input class="w80" name="name" type="text" /></div>
								<div>rss地址：<input id="rss_url" class="w240" name="url" type="text"
										onchange="javascript:$('#btn_save_rss').attr('disabled','true')" /></div>
								<input type="hidden" name="type" value="2" />
								<input id="rss_cache" type="hidden" name="targetCache" />
								<div id="div_try_rss" class="fl mr20"><input id="btn_try_rss" type="button" onclick="javascript:tryRss();" value="try" /></div>
								<div class="fl"><input id="btn_save_rss" type="submit" value="添加" disabled="true" /></div>
							</form>
						</div>
						<div id="add_web_form" style="display: none;">
							<form id="try_web_form" action="<c:url value='/addTarget.html' />" method="post">
								<div>资源名：<input class="w80" name="name" type="text" /></div>
								<div>url：<input id="web_url" class="w240" name="url" type="text"
										onchange="javascript:$('#btn_save_web').attr('disabled','true');" /></div>
								<div>xpath:<input id="web_xpath" class="w240" name="relXpath" type="text"
										onchange="javascript:$('#btn_save_web').attr('disabled','true');"/></div>
								<input type="hidden" name="type" value="1" />
								<input id="web_cache" type="hidden" name="targetCache" />
								<div id="div_try_web" class="fl mr20" ><input id="btn_try_web" type="button" onclick="javascript:tryWeb();" value="try" /></div>
								<div class="fl" ><input id="btn_save_web" type="submit" value="添加" disabled="true" /></div>
							</form>
						</div>
					</div>
					<div style="float:left;">
						<div id="name_view" class="mb10"></div>
						<div id="list_view"></div>
					</div>
				</div>
				<div class="cb"></div>
				<div style="margin:20px 20px 0px 0px; border-bottom:1px dashed #bbb;">
				</div>
                <div class="cb"></div>
			</div>
			<div class="cb" ></div>
			<div class="p10 f14" >
				<div class="p10 ">
				<span class="fl"><a class="a_link_guan" href="javascript:void(0);" onclick="javascript:$('#span_add_group').toggle(0);">新增组</a></span>
				<span id="span_add_group" class="none">
					<form id="form_add_group" action="<c:url value="/addTargetGroup.html"/>">
						<span><span>名称：</span><input name="name" type="text" /></span>
						<input name="position" type="hidden" value="<c:out value="${fn:length(requestScope.targetGroupBeanList)+1}" />"/>
						<input type="submit" value="提交"/>
					</form>
				</span>
			</div>
				<div class="cb" ></div>
				<c:forEach items="${requestScope.targetGroupBeanList}" var="b" varStatus="st">
				<div class="p10" >
					<div><span><c:out value="${b.targetGroup.name}" /></span></div>
				<ul class="ml20">
				<c:forEach items="${b.targetList }" var="t">
					<li id="li_<c:out value="${t.id }" />">
						<div class="p5" >
							<div id="div_target_item_<c:out value="${b.targetGroup.id }" />_<c:out value="${t.id }" />" class="fl single_line_text w400"
								 onclick="javascript:show_func(<c:out value="${b.targetGroup.id }" />,<c:out value="${t.id }" />,1)">
								<span class="ml10"><c:out value="${t.name}" /></span>
								<span class="ml10 color_gray"><c:out value="${t.url}" /></span>
							</div>
							<div class="fl f12" id="func_<c:out value="${b.targetGroup.id }" />_<c:out value="${t.id}" />" style="display:none;" >
								<div class="fl ml10 single_line_text w200">
									<span>
										<span>添加到组</span>
										<select id="group_select_<c:out value="${b.targetGroup.id }" />_<c:out value="${t.id }" />" style=" height:20px;display:inline-block;" onchange="">
											<option>未选择</option>
										<c:forEach items="${requestScope.targetGroupList}" var="tg">
											<option value="<c:out value="${tg.id}" />"><c:out value="${tg.name}" /></option>
										</c:forEach>
										</select>
										<button id="btn_add_to_group" style="height:20px;" onclick="javascript:addToGroup(<c:out value="${b.targetGroup.id}" />,<c:out value="${t.id }" />);" value="确定">确定</button>
									</span>
								</div>
								<div id="show_switch_<c:out value="${t.id}" />" class="fl ml10 single_line_text w30">
									<c:if test="${t.status == 1 }" >
										<span><a class="a_link_guan" onclick="javascript:hideTarget(<c:out value="${t.id }" />);">隐藏</a></span>
									</c:if>
									<c:if test="${t.status ==2 }">
										<span><a class="a_link_guan" onclick="javascript:showUpTarget(<c:out value="${t.id }" />);">显示</a></span>
									</c:if>
								</div>
								<div class="fl ml10 single_line_text w30">
									<c:choose>
										<c:when test="${st.index==0}">
											<span><a class="a_link_guan" onclick="javascript:deleteTarget(<c:out value="${t.id }" />);">删除</a></span>
										</c:when>
										<c:otherwise>
											<span><a class="a_link_guan" onclick="javascript:removeFromGroup(<c:out value="${b.targetGroup.id }" />,<c:out value="${t.id }" />);">移除</a></span>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
							<div class="cb"></div>
						</div>
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

