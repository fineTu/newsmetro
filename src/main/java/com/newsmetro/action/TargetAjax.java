package com.newsmetro.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.dom4j.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonSyntaxException;
import com.newsmetro.po.Target;
import com.newsmetro.po.TargetCache;
import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.User;
import com.newsmetro.po.UserTarget;
import com.newsmetro.pojo.NewsBean;
import com.newsmetro.pojo.NewsForm;
import com.newsmetro.pojo.Rss;
import com.newsmetro.pojo.RssItem;
import com.newsmetro.pojo.TargetForm;
import com.newsmetro.pojo.TargetGroupBean;
import com.newsmetro.pojo.TargetView;
import com.newsmetro.service.NewsService;
import com.newsmetro.service.ScriptService;
import com.newsmetro.service.TargetCacheService;
import com.newsmetro.service.TargetGroupService;
import com.newsmetro.service.TargetService;
import com.newsmetro.service.UserService;
import com.newsmetro.service.UserTargetService;
import com.newsmetro.util.GsonUtil;
import com.newsmetro.util.HttpGetter;
import com.newsmetro.util.MD5Util;
import com.newsmetro.util.TemplateUtil;


@Controller
public class TargetAjax extends BaseAction {
	static Logger logger = LoggerFactory.getLogger(TargetAjax.class.getName());
	static String key = "37d5aed075525d4fa0fe635231cba447";
	@Autowired
	private TargetService tpService;
	@Autowired
	private UserService userService;
    @Autowired
    private TargetCacheService targetCacheService;
    @Autowired
    private ScriptService scriptService;
	@Autowired
	private TargetGroupService targetGroupService;
	@Autowired
	private UserTargetService userTargetService;
	@Autowired
	private NewsService newsService;

	@RequestMapping(value="/getTarget.html",params = "isRss=1")
	public void getRss(HttpServletRequest request,HttpServletResponse response,Target target) {
        if(target==null||target.getId()==null){
            return;
        }
		Target tp = tpService.getTargetById(target.getId());
		HttpGetter getter = new HttpGetter();
		Document doc = null;
		try {
			String docStr = getter.getDocument(tp.getUrl());
			String md5 = MD5Util.md5(docStr, MD5Util._32_BIT);
            tp.setMd5(md5);

			tpService.updateTarget(tp);
			doc = getter.toDom4jDoc(docStr);
		}catch (Exception e) {
			doc = null;
			e.printStackTrace();
		}
		if(doc==null){
			return;
		}else{
			Rss rss = new Rss(doc);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("title",rss.getTitle());
			jsonObject.put("link",rss.getLink());
			jsonObject.put("description",rss.getRssDescription());
			JSONArray jsonArray = new JSONArray();
			List<RssItem> itemList = rss.getItemList();
			for(int i=0;i<itemList.size();i++){
				RssItem item = itemList.get(i);
				JSONObject jItem = new JSONObject();
				jItem.put("title", item.getTitle());
				jItem.put("link", item.getLinkUrl());
				jItem.put("description", item.getDescription());
				jItem.put("pubDate", item.getPubDate());
				jsonArray.add(i,jItem);
			}
			jsonObject.put("itemList", itemList);
			
			response.setContentType("application/json;charset=UTF-8");  
	        response.setHeader("Pragma", "No-cache");  
	        response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expires", 0);
	        PrintWriter out = null;
	        try {  
	            out = response.getWriter();  
	            out.write(jsonObject.toString());  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }
		}
	}
	
	@RequestMapping(value="/getTarget.html",params = "isRss=0")
	public void getWeb(HttpServletRequest request,HttpServletResponse response,Target target){
        Target tp = tpService.getTargetById(target.getId());
		JSONObject jsonObject = new JSONObject();
		if(tp.getUserTargetId()==null){
			TargetCache targetCache = targetCacheService.getTargetCacheByTargetId(target.getId());
			Map<String,Object> mapObj = GsonUtil.loads(targetCache.getItems());
			Map<String,Object> metaMap = (Map<String, Object>) mapObj.get("meta");
			metaMap.put("name",tp.getName());
			String htmlStr = null;
			if(StringUtils.isBlank(tp.getTemplate())){
				htmlStr = TemplateUtil.render(mapObj);
			}else{
				htmlStr = TemplateUtil.render(mapObj,tp.getTemplate());
			}
			jsonObject.put("html",htmlStr );
			JSONObject metaObj = new JSONObject();
			metaObj.put("md5",metaMap.get("md5"));
			metaObj.put("description","");
			jsonObject.put("meta",metaObj );
//			jsonObject.put("title",tp.getName());
//			jsonObject.put("link",tp.getUrl());
//			jsonObject.put("description","");
//			TargetCache targetCache = targetCacheService.getTargetCacheByTargetId(target.getId());
//			jsonObject.put("md5",targetCache.getMd5());
//			jsonObject.put("itemList",targetCache.getItems());

		}else{
			UserTarget userTarget = userTargetService.findById(tp.getUserTargetId());
			NewsForm form = new NewsForm();
			form.setUserTargetId(tp.getUserTargetId());
			form.setOffset(0);
			form.setPageSize(12);
			JSONObject renderData = new JSONObject();
			List<NewsBean> newsList = newsService.find(form);
			JSONObject meta = new JSONObject();
			meta.put("url",tp.getUrl());
			meta.put("target_id",tp.getId());
			meta.put("md5","123");
			renderData.put("meta",meta);
			renderData.put("data",newsListToJsonList(newsList));

			String htmlStr = TemplateUtil.render(renderData);
			jsonObject.put("html",htmlStr );
			jsonObject.put("meta",meta);
//			jsonObject.put("title", userTarget.getName());
//			jsonObject.put("link","");
//			jsonObject.put("description","");
//			jsonObject.put("md5","123");
//			jsonObject.put("itemList", newsListToJsonList(newsList));
		}

		response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {
            logger.info(jsonObject.toString());
            out = response.getWriter();
            out.write(jsonObject.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	@RequestMapping("/getTargetGroupList")
	public void getTargetGroupList(HttpServletRequest request,HttpServletResponse response){
		User user = (User) request.getSession().getAttribute("user");
		String status = request.getParameter("status");
		TargetForm form = new TargetForm();
		form.setUserId(user.getId());
		form.setStatus(status!=null?new Integer(status):null);
		List<Target> targetList = tpService.findTargetList(form);

		List<TargetGroup> targetGroupList = new ArrayList<TargetGroup>();
		targetGroupList = targetGroupService.findByUserId(user.getId());
		List<TargetGroupBean> beanList = new ArrayList<TargetGroupBean>();
		for (TargetGroup tg : targetGroupList) {
			TargetGroupBean bean = new TargetGroupBean();
			bean.setTargetGroup(tg);
			List<Target> tList = targetGroupService.findTargetByGroupId(tg.getId());
			if(tList==null){
				tList = new ArrayList<Target>();
			}
			bean.setTargetList(tList);
			beanList.add(bean);
		}

		TargetGroupBean noGroupBean = findNoGroupedTargetGroupBean(targetList,beanList);
		beanList.add(0,noGroupBean);

		JSONArray groupArray = new JSONArray();
		for(TargetGroupBean bean:beanList){
			TargetGroup groupBean = bean.getTargetGroup();
			JSONObject group = new JSONObject();
			group.put("id", groupBean.getId());
			group.put("name",groupBean.getName());
			group.put("position",groupBean.getPosition());

			JSONArray targetArray = new JSONArray();
			List<Target> list = bean.getTargetList();
			for(Target t:list){
				JSONObject item = new JSONObject();
				item.put("id", t.getId());
				item.put("name", t.getName());
				item.put("url", t.getUrl());
				item.put("type", t.getType());
				item.put("absXpath", t.getAbsXpath());
				item.put("relXpath", t.getRelXpath());
				item.put("md5", t.getMd5());
				targetArray.add(item);
			}
			group.put("targetList",targetArray);
			groupArray.add(group);
		}

		response.setContentType("application/json;charset=UTF-8");  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(groupArray.toString());
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
	}
	
	@RequestMapping(value="/addTarget.html")
	public void addTarget(HttpServletRequest request,Target target,HttpServletResponse response){
		boolean isSuccess = true;
		String reason = "";
		User user = (User)request.getSession().getAttribute("user");
		
		target.setUser(user);
		target.setStatus(target.getStatus());
		target.setUserId(user.getId());
		if(target!=null&&target.getUserTargetId()!=null){
			UserTarget userTarget = userTargetService.findById(target.getUserTargetId());
			if(userTarget==null){
				isSuccess = false;
			}
			target.setName(userTarget.getName());
			target.setType(Target.TYPE_USER);
			tpService.addTarget(target);

		}else{
			if(target.getId()!=null){
				tpService.updateTarget(target);
			}else{
				if(target.getName()==null){
					isSuccess = false;
					reason = "请填写资源名称";
				}
				if(target.getUrl()==null){
					isSuccess = false;
					reason = "请填写url";
				}
				if(target.getRelXpath()==null){
					isSuccess = false;
					reason = "请填写Xpath";
				}
				
				tpService.addTarget(target);
				String cacheStr = request.getParameter("xquery_res");
				if(StringUtils.isNotBlank(cacheStr)) {
					JSONObject jsonObj = JSONObject.fromObject(cacheStr);
					if(jsonObj.has("meta")){
						JSONObject metaObj = (JSONObject) jsonObj.get("meta");
						metaObj.put("target_id",target.getId());
						metaObj.put("md5","123");
					}
					TargetCache targetCache = new TargetCache();
					targetCache.setTargetId(target.getId());
					targetCache.setItems(jsonObj.toString());
					targetCache.setMd5(MD5Util.md5(cacheStr,MD5Util._32_BIT));
					targetCache.setUpdateTime(System.currentTimeMillis());
					targetCacheService.saveTargetCache(targetCache);
				}
			}

		}
		
		JSONObject res = new JSONObject();
		res.put("is_success", isSuccess?true:false);
		res.put("reason", reason);
		response.setContentType("application/json;charset=UTF-8");  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(res.toString());
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
	}
	
	@RequestMapping(value="/deleteTarget.html")
	public void deleteTarget(HttpServletRequest request,HttpServletResponse response){
		boolean flag = true;
		
		Long id = Long.parseLong(request.getParameter("id"));
		if(id==null){
			flag = false;
		}
		
		Target target = tpService.getTargetById(id);
		if(target==null){
			flag = false;
		}
		
		User user = (User)request.getSession().getAttribute("user");
		if(target.getUserId()!=user.getId()){
			flag = false;
		}
		
		tpService.deleteTarget(target.getId());
		targetCacheService.deleteTargetCache(id);

		JSONObject res = new JSONObject();
		res.put("res", flag?true:false);
		response.setContentType("application/json;charset=UTF-8");  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(res.toString());  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
	}
	
	@RequestMapping(value="/hideTarget.html")
	public void hideTarget(HttpServletRequest request,HttpServletResponse response){
		boolean flag = true;

        Long id = Long.parseLong(request.getParameter("id"));
		if(id==null){
			flag = false;
		}
		
		Target target = tpService.getTargetById(id);
		if(target==null){
			flag = false;
		}
		
		User user = (User)request.getSession().getAttribute("user");
		if(target.getUserId()!=user.getId()){
			flag = false;
		}
		
		target.setStatus(Target.STATUS_HIDE);
		tpService.updateTarget(target);
		
		JSONObject res = new JSONObject();
		res.put("res", flag?true:false);
		response.setContentType("application/json;charset=UTF-8");  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(res.toString());  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
	}
	
	@RequestMapping(value="/showUpTarget.html")
	public void showUpTarget(HttpServletRequest request,HttpServletResponse response){
		boolean flag = true;

        Long id = Long.parseLong(request.getParameter("id"));
		if(id==null){
			flag = false;
		}
		
		Target target = tpService.getTargetById(id);
		if(target==null){
			flag = false;
		}
		
		User user = (User)request.getSession().getAttribute("user");
		if(target.getUserId()!=user.getId()){
			flag = false;
		}
		
		target.setStatus(Target.STATUS_REGULAR);
		tpService.updateTarget(target);
		
		JSONObject res = new JSONObject();
		res.put("res", flag?true:false);
		response.setContentType("application/json;charset=UTF-8");  
        response.setHeader("Pragma", "No-cache");  
        response.setHeader("Cache-Control", "no-cache");  
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {  
            out = response.getWriter();  
            out.write(res.toString());  
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
	}
	
//	@RequestMapping(value="/addTarget.html")
//	public void addTarget(HttpServletRequest request,HttpServletResponse response){
//		DESUtil desUtil = new DESUtil();
//		boolean flag = true;
//		String url = request.getParameter("url");
//		String absXpath = request.getParameter("absXpath");
//		String relXpath = request.getParameter("relXpath");
//		String regex = request.getParameter("regex");
//		String signInKey = request.getParameter("signInKey");
//		String targetName = null;
//		try {
//			targetName = new String(request.getParameter("targetName").getBytes("ISO-8859-1"),"utf-8");
//		} catch (UnsupportedEncodingException e2) {
//			e2.printStackTrace();
//		}
//		String decodeKey = null;;
//		try {
//			decodeKey = desUtil.getDecryptString(signInKey,key);
//		} catch (UnsupportedEncodingException e1) {
//			e1.printStackTrace();
//			flag = false;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		String array[] = null;
//		String email = null;
//		String password = null;
//		if(decodeKey!=null){
//			array = decodeKey.split("\\|\\|");
//		}else{
//			flag = false;
//		}
//		if(array.length==2){
//			email = array[0];
//			password = array[1];
//		}else{
//			flag = false;
//		}
//
//		//验证signInKey的有效性
//		User user = userService.signIn(email, password);
//		if(user==null){
//			flag = false;
//		}
//
//		if(url==null){
//			flag = false;
//		}
//		Target target = new Target();
//		target.setUser(user);
//		target.setAbsXpath(absXpath);
//		target.setIsRss(false);
//		target.setName(targetName);
//		target.setRelXpath(relXpath);
//		target.setStatus(Target.STATUS_REGULAR);
//		target.setUrl(url);
//		tpService.addTarget(target);
//		System.out.println(
//			"---------------------------------"+
//			"\nurl:"+url+
//			"\nabsXpath:"+absXpath+
//			"\nrelXpath:"+relXpath+
//			"\ntargetName:"+targetName+
//			"\nregex:"+regex+
//			"\ndecode:"+decodeKey);
//
//		JSONObject res = new JSONObject();
//		res.put("res", flag?true:false);
//		response.setContentType("application/json;charset=UTF-8");
//        response.setHeader("Pragma", "No-cache");
//        response.setHeader("Cache-Control", "no-cache");
//        response.setDateHeader("Expires", 0);
//        PrintWriter out = null;
//        try {
//            out = response.getWriter();
//            out.write(res.toString());
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//	}

    @RequestMapping(value="/getTargetMd5.html")
    public void getTargetMd5(HttpServletRequest request,HttpServletResponse response){
        boolean flag = true;
        Long id = null;
        try{
            id = Long.parseLong(request.getParameter("id"));
        }catch(NumberFormatException e){
            flag = false;
        }
        if(id==null){
            flag = false;
        }

        TargetCache targetcache = targetCacheService.getTargetCacheByTargetId(id);
		String md5  = "123";
		if(targetcache!=null){
			md5  = targetcache.getMd5();
		}



        User user = (User)request.getSession().getAttribute("user");

        JSONObject res = new JSONObject();
        res.put("md5", flag?md5:null);
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.write(res.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value="/tryRss.html")
    public void tryRss(HttpServletRequest request,HttpServletResponse response){
        String url = request.getParameter("url");
        if(url==null){
            return;
        }

        String feedStr = scriptService.tryRss(url);

		TargetView jsonObj = null;
		try{
			jsonObj = GsonUtil.fromJson(feedStr, TargetView.class);
		}catch (JsonSyntaxException e){
			logger.info("try rss失败！{}",url);
		}

		if(jsonObj==null){
			jsonObj = new TargetView();
			jsonObj.setIsSuccess(false);
			jsonObj.setLink(url);
		}
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {
            logger.info(GsonUtil.toJson(jsonObj));
            out = response.getWriter();
            out.write(feedStr);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

	@RequestMapping(value="/tryXquery.html")
	public void tryXquery(HttpServletRequest request,HttpServletResponse response){
		String name = request.getParameter("name");
		String url = request.getParameter("url");
		String xpath = request.getParameter("relXpath");
		String xquery = request.getParameter("xquery");
		if(url==null||xpath==null){
			return;
		}

		JSONObject jsonObj = new JSONObject();
		String resStr = scriptService.tryTarget(url,xpath,xquery);
		if (resStr != null){
			resStr = resStr.substring(resStr.indexOf("{"));
			JSONObject resObj = JSONObject.fromObject(resStr);
			if(resObj.has("data")){
				JSONObject dataObj = new JSONObject();
				dataObj.put("data",resObj.get("data"));
				JSONObject metaObj = new JSONObject();
				metaObj.put("url",url);
				dataObj.put("meta",metaObj);
				jsonObj.put("data", dataObj);
			}

			if(resObj.has("is_success")){
				jsonObj.put("is_success",resObj.getBoolean("is_success"));
			}else{
				jsonObj.put("is_success",false);
			}
			jsonObj.put("link", url);
			jsonObj.put("name",name);
		}

		if(jsonObj.keySet().size()==0){
			jsonObj.put("is_success",false);
			jsonObj.put("link",url);
			jsonObj.put("name",name);
		}

		response.setContentType("application/json;charset=UTF-8");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		PrintWriter out = null;
		try {
			String res = jsonObj.toString();
			logger.info(res);
			out = response.getWriter();
			out.write(res);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/tryTemplate.html")
	public void tryTemplate(HttpServletRequest request,HttpServletResponse response){
		String template = request.getParameter("template");
		String data = request.getParameter("xquery_res");
		if(template==null||data==null){
			return;
		}

		JSONObject jsonObj = new JSONObject();
		String resStr = null;
		String errorStr = null;
		if(StringUtils.isBlank(template)){
			resStr = TemplateUtil.render(GsonUtil.loads(data));
		}else{
			try{
				resStr = TemplateUtil.render(GsonUtil.loads(data),template);
			}catch(Exception e){
				errorStr = e.toString();
			}
		}

		if (resStr != null && errorStr == null){
			jsonObj.put("is_success",true);
			jsonObj.put("html",resStr);
		}else{
			jsonObj = new JSONObject();
			jsonObj.put("is_success",false);
			jsonObj.put("html",errorStr);
		}

		response.setContentType("application/json;charset=UTF-8");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		PrintWriter out = null;
		try {
			String res = jsonObj.toString();
			logger.info(res);
			out = response.getWriter();
			out.write(res);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/acceptTryWeb.html")
	public void acceptTryRes(HttpServletRequest request,HttpServletResponse response){
		String key = request.getParameter("try_key");
		String resStr = request.getParameter("res_str");
		scriptService.acceptTryRes(key, resStr);

		JSONObject res = new JSONObject();
		res.put("code", 1);
		response.setContentType("application/json;charset=UTF-8");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.write(res.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value="/forkTarget.html")
	public void forkTarget(HttpServletRequest request,HttpServletResponse response){
		String targetId = request.getParameter("targetId");
		Target target = tpService.getTargetById(Long.parseLong(targetId));
		User user = (User)request.getSession().getAttribute("user");
		target.setUserId(user.getId());
		target.setParentId(target.getParentId());
		target.setId(null);
		target.setCreateTime(System.currentTimeMillis());
		tpService.addTarget(target);

		returnSucc(response);
		return;
	}

	private TargetGroupBean findNoGroupedTargetGroupBean(
			List<Target> targetList,List<TargetGroupBean> targetGroupBeanList){
		Set<Long> idSet = new HashSet<Long>();
		for(TargetGroupBean b:targetGroupBeanList){
			if(b.getTargetList()==null){
				continue;
			}
			for(Target p:b.getTargetList()){
				idSet.add(p.getId());
			}
		}
		List<Target> resList = new ArrayList<Target>();
		for(Target t: targetList){
			if(!idSet.contains(t.getId())) {
				resList.add(t);
			}
		}
		TargetGroupBean resBean = new TargetGroupBean();
		TargetGroup tg = new TargetGroup();
		tg.setId(0l);
		tg.setName("未分组");
		tg.setPosition(0);
		tg.setStatus(1);
		resBean.setTargetGroup(tg);
		resBean.setTargetList(resList);
		return resBean;
	}

	private List<JSONObject> newsListToJsonList(List<NewsBean> newsList) {
		if (CollectionUtils.isEmpty(newsList)) {
			return null;
		}
		JSONArray jsonArray = new JSONArray();
		for (NewsBean news : newsList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("text", news.getTitle());
			jsonObj.put("href", news.getLink());
			jsonArray.add(jsonObj);
		}
		return jsonArray;
	}
}
