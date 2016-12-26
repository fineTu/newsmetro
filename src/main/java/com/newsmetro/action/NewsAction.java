package com.newsmetro.action;

import com.newsmetro.po.News;
import com.newsmetro.po.Target;
import com.newsmetro.po.User;
import com.newsmetro.pojo.NewsBean;
import com.newsmetro.pojo.NewsForm;
import com.newsmetro.pojo.TargetForm;
import com.newsmetro.service.NewsService;
import com.newsmetro.service.TargetService;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by finetu on 8/11/15.
 */
@Controller
public class NewsAction extends BaseAction{

    @Autowired
    private NewsService newsService;
    @Autowired
    private TargetService targetService;

    @RequestMapping(value="/recentNewsList.html")
    public String recentNewsList(HttpServletRequest request) {
        User user = (User)request.getSession().getAttribute("user");
        TargetForm targetForm = new TargetForm();
        targetForm.setUserId(user.getId());
        List<Target> targetList = targetService.findTargetList(targetForm);
        List<Long> tidList = new ArrayList<Long>();
        for(Target t:targetList){
            tidList.add(t.getId());
        }
        NewsForm form = new NewsForm();
        form.setTargetIds(tidList);
        form.setOffset(0);
        form.setPageSize(40);
        List<NewsBean> newsList = newsService.find(form);
        convertNewsList(newsList,targetList);
        request.setAttribute("newsList", newsList);
        return "recentNews";
    }

    private void convertNewsList(List<NewsBean> newsList,List<Target> targetList){
        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd hh:mm");
        Map<Long,Target> targetMap = new HashMap<Long, Target>();
        for(Target t:targetList){
            targetMap.put(t.getId(),t);
        }
        for(NewsBean n : newsList){
            Target t = targetMap.get(n.getTargetId());
            if(t!=null){
                n.setTargetName(t.getName());
            }
            n.setPublishDate(sdf.format(new Date(n.getPublishTime())));
        }
    }

}
