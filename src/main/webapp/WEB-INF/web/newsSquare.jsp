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
							广场
						</span>
				</div>
				<div class="cb"></div>
			</div>
			<div id="splite" class="cb"></div>
			<div id="user_target_area">
				<c:forEach items="${userTargetList}" var="ut" varStatus="st">
					<div id="block_<c:out value="${ut.id}"/> " class="m10 fl w400">
						<div class="fl f16" id="name_<c:out value="${ut.id}"/>">
							<a class="a_link_blue" href="<c:url value="/userTargetDetail.html"/>?userTargetId=<c:out value="${ut.id}"/>"><c:out value="${ut.name}"/></a>
						</div>
						<div class="fl color_gray" style="margin-top:3px;">by&nbsp;<c:out value="${ut.author.name}"/></div>
						<c:if test="${ut.focused==0}">
							<div class="fl f16" id="name_<c:out value="${ut.id}"/>">
								<a class="a_link_guan f16" style="font-weight: bold;" href="<c:url value="/addTarget.html"/>?userTargetId=<c:out value="${ut.id}"/>">+</a>
							</div>
						</c:if>

						<div class="cb mt5 mb10"></div>
						<div style="width:340px;">
							<ul class="fl" id="list_<c:out value="${ut.id}"/>">
								<c:forEach items="${ut.newsList}" var="news" >
									<li class='mb5'>
										<a class='a_link' style='line-height:20px;' href='<c:out value="${news.link}"/>' target='_blank' >
											<c:out value="${news.title}"/>
										</a>
									<li>
								</c:forEach>
							</ul>
						</div>
					</div>
					<c:if test="${st.index%2==1}">
						<div class="cb"></div>
					</c:if>
				</c:forEach>
			</div>
			<%--<div id="left_panel" class="fl" style="width:900px;">
				<div id="page_switch" style="display:none;">
					<a class="fl ml30 a_link color_blue" href="javascript:last_Group();">&lt;&lt;上一组</a>
					<span id="page_value" class="fl" style="margin-left:80px;" ></span>
					<a class="fr mr30 a_link color_blue" href="javascript:next_Group();">下一组&gt;&gt;</a>
				</div>
				<div id="target_panel" class="fl"></div>
			</div>
			<div id="news_panel" class="fl" style="width:530px; display: none;">

			</div>--%>

		</div >

	</div>
</div>

</body>
<script type="text/javascript">
	var groupIndex = 0;
	var groupNum = 0;
	var targetNum = 0;
	var pointedItem = null;
	var targetGroupList = null;
	var targetItems=new Array();
	for(var i=0;i<50;i++){
		targetItems[i]=new Array();
	}
	/* 获取目标点列表*/
	/*$(document).ready(function() {
		$.ajax({
			type : "POST",
			url : "getTargetGroupList.html?status=1",
			success : function(data) {
				var panel = $("#target_panel");
				for(var j=0;j<data.length;j++){
					var group = document.createElement("div");
					$("#target_panel").append(group);
					group.setAttribute("id", "group_"+j);
					group.setAttribute("class", "m10 fl");
					group.setAttribute("style", "width:100%;");
					var groupName = '<div class="fl f16" id="group_name_'+j+'">'+data[j].name+'</div>';
					var groupHr = '<div class="mt5 mb10 cb" style="border-bottom:1px dashed #bbb;"></div>';
					$("#group_"+j).append(groupName,groupHr);
					var i = 1;
					var targetList = data[j].targetList;
					for(t in targetList){
						var block = document.createElement("div");
						block.setAttribute("id", "block_"+targetList[t].id);
						block.setAttribute("class", "m10 fl w400");
						$("#group_"+j).append(block);
						var name = '<div class="fl f16" id="name_'+targetList[t].id+'"></div>';
						var des = '<div class="fl mt5 ml10 color_gray w250" id="description_'+targetList[t].id+'"></div>';
						var md5 = '<input type="hidden" id="md5_'+targetList[t].id+'" value="'+targetList[t].id.md5+'" />';
						var target_id = '<input type="hidden" id="target_id_'+targetList[t].id+'" value="'+targetList[t].id+'" />';
						var hr = '<div class="cb mt5 mb10"></div>';
						var ul = '<div style="width:340px;"><ul class="fl" id="list_'+targetList[t].id+'"><li><img class="mt50" src="img/loading.gif" /></li></ul></div>';
						$("#block_"+targetList[t].id).append(target_id,md5,name,des,hr,ul);
						$("#name_"+targetList[t].id).append("<a class='a_link_blue' href='javascript:void(0);' >" + targetList[t].name + "</a>");
						*//*$("#block_"+i).after('<div class="cb h30"></div>');  *//*
						if(i%2==0&&i!=0){
							$("#block_"+targetList[t].id).after("<div class='cb'></div>");
						}
						i++;
						targetNum++;
					}
					$("#target_panel").append("<div class='cb'></div>");
				}
				targetGroupList = data;
				for(var j=0;j<data.length;j++){
					if(data[j].targetList==null){
						continue;
					}
					for(var i=0;i<data[j].targetList.length;i++){
						getTarget(0,data[j].targetList[i].id);
					}
				}
				groupNum = Math.ceil(targetNum/2);
			}
		});
//            for(var i=0;i<targetNum;i++){
//                window.setInterval("checkTargetUpdate("+i+","+$("#target_id_"+i).value+","+$("#md5_"+i).value+")",30000);
//            }
	});
	*//* 获取目标点内容 *//*
	function getTarget(isRss,targetId){
		if(isRss==0){
			$.ajax({
				type : "POST",
				url : "getTarget.html?isRss=0&id="+targetId,//+"&url="+url+"&relXpath="+target.relXpath+"&absXpath="+target.absXpath
				success : function(data) {
					*//*$("#name_"+index).html("");
					 $("#name_"+index).append("<a class='a_link_blue' href='"+data.link+"' >" + targetList[index-1].name + "</a>");*//*
					$("#a_update_"+targetId).remove();
					$("#description_"+targetId).append("<span>" + data.description + "</span>");
					$("#md5_"+targetId).attr("value",data.md5);
					var itemList = data.itemList;
					$("#list_"+targetId).html("");
					var length = (itemList.length<=12)?itemList.length:12;
					for (var i=0;i<itemList.length;i++){
						if(i<length){
							//$("#list_"+index).append("<li class='mb5'><a id='item_"+index+"_"+i+"' class='a_link' style='line-height:20px;' href='javascript:showNews("+(index-1)+","+i+");' >"+itemList[i].title+"</a><li>");
							$("#list_"+targetId).append("<li class='mb5'><a id='item_"+targetId+"_"+i+"' class='a_link' style='line-height:20px;' href='"+itemList[i].href+"' target='_blank' >"+itemList[i].text+"</a><li>");
						}
						*//*targetItems[index-1][i]=itemList[i];*//*
					}
					window.setInterval("checkTargetUpdate("+targetId+")",30000);
				}
			});
		}
	};*/
	/* 显示新闻 */
	/*function showNews(targetIndex,itemIndex){
	 if(pointedItem!=null){
	 $(pointedItem).attr("style","line-height:20px;");
	 }else{
	 *//* $("content").attr("style","width:1000px;"); *//*
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

	 }*/

	function checkTargetUpdate(target_id){
		var old_md5 = $("#md5_"+target_id).attr("value");
		$.ajax({
			type : "POST",
			url : "getTargetMd5.html?id="+target_id,
			success : function(data) {
				if(data.md5!=old_md5&&$("#has_new_"+target_id).length==0){
					$("#name_"+target_id).append("<a id='a_update_"+target_id+"' style='color:red; font-size:8px; margin-left:10px;' href='javascript:void(0);' onclick='getTarget(0,"+target_id+");'>更新"+
					"<span class='alertLabel' style='position:relative; font-weight:bold;' id='has_new_"+target_id+"' >*</span></a>");
				}
				$("#md5_"+target_id).attr("value",data.md5);
			}
		});
	}

	$(document).dblclick(function(){
		trunBlockShow();
		$("#page_switch").attr("style","display:none;");
		$("#news_panel").attr("style","display:none");
		$("#left_panel").attr("style","width:900px;display:none;");
		$("#left_panel").attr("style","width:900px;display:block;");
	});

	function trunBlockHide(){
		for(var i=0;i<targetNum;i++){
			$("#block_"+(i+1)).attr("style","display:none;");
		}
	}

	function trunBlockShow(){
		for(var i=0;i<targetNum;i++){
			$("#block_"+(i+1)).attr("style","display:block;");
		}
	}

	function trunGroupShow(index){
		for(var i=(index)*2;i<(index+1)*2;i++){
			$("#block_"+(i+1)).attr("style","display:block;");
		}
		$("#page_value").html((groupIndex+1)+'/'+groupNum);
	}

	function last_Group(){
		if(groupIndex>0){
			trunBlockHide();
			groupIndex--;
			$("#block_"+(groupIndex*2+1)).attr("style","display:block;");
			$("#block_"+(groupIndex*2+2)).attr("style","display:block;");
			$("#page_value").html((groupIndex+1)+'/'+groupNum);
		}
	}

	function next_Group(){
		if(groupIndex<(groupNum-1)){
			trunBlockHide();
			groupIndex++;
			$("#block_"+(groupIndex*2+1)).attr("style","display:block;");
			$("#block_"+(groupIndex*2+2)).attr("style","display:block;");
			$("#page_value").html((groupIndex+1)+'/'+groupNum);
		}
	}

	$(document).bind("selectstart",function(){return false;});


</script>
</html>
