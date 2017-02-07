package com.newsmetro.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.newsmetro.po.Target;
import com.newsmetro.po.TargetCache;
import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.User;
import com.newsmetro.pojo.TargetForm;
import com.newsmetro.pojo.TargetGroupBean;
import com.newsmetro.service.TargetCacheService;
import com.newsmetro.service.TargetGroupService;
import com.newsmetro.service.TargetService;
import com.newsmetro.service.UserTargetService;
import com.newsmetro.util.TemplateUtil;

@Controller
public class TargetAction {
	@Autowired
	private TargetService targetService;
	@Autowired
	private TargetCacheService targetCacheService;
	@Autowired
	private TargetGroupService targetGroupService;
	@Autowired
	private UserTargetService userTargetService;
	
	@RequestMapping(value="/toNewsCenter.html")
	public String toNewsCenter(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		TargetForm form = new TargetForm();
		form.setUserId(user.getId());
		form.setStatus(Target.STATUS_REGULAR);
		List<Target> targetList = targetService.findTargetList(form);
		request.setAttribute("targetList", targetList);
		return "newsCenter";
	}
	
//	@RequestMapping(value="/addTarget.html")
//	public String addTarget(HttpServletRequest request,Target target){
//		User user = (User)request.getSession().getAttribute("user");
//		target.setUser(user);
//		target.setStatus(Target.STATUS_REGULAR);
//		target.setUserId(user.getId());
//		if(target!=null&&target.getUserTargetId()!=null){
//			UserTarget userTarget = userTargetService.findById(target.getUserTargetId());
//			if(userTarget==null){
//				return "redirect:/toNewsCenter.html";
//			}
//			target.setName(userTarget.getName());
//			target.setType(Target.TYPE_USER);
//			targetService.addTarget(target);
//
//		}else{
//			if(target.getId()!=null){
//				targetService.updateTarget(target);
//			}else{
//				targetService.addTarget(target);
//				String cacheStr = request.getParameter("xquery_res");
//				if(StringUtils.isNotBlank(cacheStr)) {
//					JSONObject jsonObj = JSONObject.fromObject(cacheStr);
//					if(jsonObj.has("meta")){
//						JSONObject metaObj = (JSONObject) jsonObj.get("meta");
//						metaObj.put("target_id",target.getId());
//						metaObj.put("md5","123");
//					}
//					TargetCache targetCache = new TargetCache();
//					targetCache.setTargetId(target.getId());
//					targetCache.setItems(jsonObj.toString());
//					targetCache.setMd5(MD5Util.md5(cacheStr,MD5Util._32_BIT));
//					targetCache.setUpdateTime(System.currentTimeMillis());
//					targetCacheService.saveTargetCache(targetCache);
//				}
//			}
//
//		}
//		return "redirect:/toNewsCenter.html";
//	}
	
	@RequestMapping(value="/manage/addTarget.html")
	public String manageAddTarget(HttpServletRequest request,Target target){
		User user = (User)request.getSession().getAttribute("user");
		target.setUser(user);
		targetService.addTarget(target);

		String cacheStr = request.getParameter("targetCache");
		if(StringUtils.isNotBlank(cacheStr)) {
			TargetCache targetCache = new TargetCache();
			targetCache.setTargetId(target.getId());
			targetCache.setItems(cacheStr);
			targetCache.setUpdateTime(System.currentTimeMillis());
			targetCacheService.saveTargetCache(targetCache);
		}
		return "redirect:/myTargetList.html";
	}
	
	@RequestMapping(value="/myTargetList.html")
	public String getTargetListByUserId(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		TargetForm form = new TargetForm();
		form.setUserId(user.getId());
		List<Target> targetList = targetService.findTargetList(form);

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

		request.setAttribute("targetGroupBeanList", beanList);
		request.setAttribute("targetGroupList", targetGroupList);
		return "myTargetList";
	}

	@RequestMapping(value="/myOutTargetList.html")
	public String getOutTargetByUserId(HttpServletRequest request){
		User user = (User)request.getSession().getAttribute("user");
		TargetForm form = new TargetForm();
		form.setUserId(user.getId());
		form.setType(Target.TYPE_USER);
		List<Target> targetList = targetService.findTargetList(form);

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

		request.setAttribute("targetGroupBeanList", beanList);
		request.setAttribute("targetGroupList", targetGroupList);
		return "myOutTargetList";
	}

	@RequestMapping(value="/developTarget.html")
	public String developTarget(HttpServletRequest request,Long targetId){
		Target target = new Target();
		target.setStatus(null);
		target.setType(Target.TYPE_WEB);
		TargetCache targetCache = new TargetCache();
		if(targetId!=null){
			target = targetService.getTargetById(targetId);
			targetCache = targetCacheService.getTargetCacheByTargetId(targetId);
		}
		request.setAttribute("target", target);
		request.setAttribute("targetCache", targetCache);
		request.setAttribute("tempTemp", TemplateUtil.getTempTemp());
		request.setAttribute("xqueryTemp", TemplateUtil.getXqueryTemp());
		return "developTarget";
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


}
