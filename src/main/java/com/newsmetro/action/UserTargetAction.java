package com.newsmetro.action;

import com.newsmetro.po.Target;
import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.User;
import com.newsmetro.po.UserTarget;
import com.newsmetro.pojo.*;
import com.newsmetro.service.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */

@Controller
public class UserTargetAction extends BaseAction{
    @Autowired
    private UserTargetService userTargetService;
    @Autowired
    private NewsService newsService;
    @Autowired
    private UserService userService;
    @Autowired
    private TargetService targetService;
    @RequestMapping(value="/userTargetList.html")
    public String userTargetList(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        UserTargetForm form = new UserTargetForm();
        form.setUserId(user.getId());
        List<UserTarget> userTargetList = userTargetService.find(form);
        for(UserTarget ut : userTargetList){
            NewsForm newsForm = new NewsForm();
            newsForm.setUserTargetId(ut.getId());
            newsForm.setOffset(0);
            newsForm.setPageSize(20);
            List<NewsBean> newsList = newsService.find(newsForm);
            ut.setNewsList(newsList);
        }
        request.setAttribute("userTargetList", userTargetList);
        return "userTargetList";
    }

    @RequestMapping(value="/userTargetSquare.html")
    public String userTargetSquare(HttpServletRequest request){
        User user = (User)request.getSession().getAttribute("user");
        UserTargetForm form = new UserTargetForm();
        form.setOrderBy("ut.update_time");
        form.setOffset(0);
        form.setPageSize(10);
        List<UserTarget> userTargetList = userTargetService.find(form);
        for(UserTarget ut : userTargetList){
            NewsForm newsForm = new NewsForm();
            newsForm.setUserTargetId(ut.getId());
            newsForm.setOffset(0);
            newsForm.setPageSize(20);
            List<NewsBean> newsList = newsService.find(newsForm);
            ut.setNewsList(newsList);
            TargetForm targetForm = new TargetForm();
            targetForm.setUserId(user.getId());
            targetForm.setUserTargetId(ut.getId());
            List<Target> utList = targetService.findTargetList(targetForm);
            if(CollectionUtils.isNotEmpty(utList)){
                ut.setFocused(1);
            }else{
                ut.setFocused(0);
            }
            User author = userService.findById(ut.getUserId());
            ut.setAuthor(author);
        }
        request.setAttribute("userTargetList", userTargetList);
        return "newsSquare";
    }

    @RequestMapping(value="/userTargetDetail.html")
    public String userTargetDetail(HttpServletRequest request){
        String userTargetIdStr = request.getParameter("userTargetId");
        User user = (User)request.getSession().getAttribute("user");

        if(StringUtils.isBlank(userTargetIdStr)){
            request.setAttribute("userTarget", new UserTarget());
            request.setAttribute("newsList", new ArrayList<NewsBean>());
            return "userTargetDetail";
        }

        UserTarget userTarget = userTargetService.findById(Long.parseLong(userTargetIdStr));
        User author = userService.findById(userTarget.getUserId());
        if(author!=null&&author.getId().equals(user.getId())){
            userTarget.setIsAuthor(1);
        }else{
            userTarget.setIsAuthor(0);
        }
        NewsForm newsForm = new NewsForm();
        newsForm.setUserTargetId(Long.parseLong(userTargetIdStr));
        List<NewsBean> newsList = newsService.find(newsForm);

        request.setAttribute("userTarget", userTarget);
        request.setAttribute("newsList",newsList);
        return "userTargetDetail";
    }

    @RequestMapping(value="/addUserTarget.html")
    public String addUserTarget(HttpServletRequest request, HttpServletResponse response){
        String name = request.getParameter("userTargetName");

        if(StringUtils.isBlank(name)){
            return "redirect:/userTargetList.html";
        }
        User user = (User) request.getSession().getAttribute("user");
        UserTarget userTarget = new UserTarget();
        try {
            userTarget.setName(new String(name.getBytes("ISO-8859-1"),"utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        userTarget.setUserId(user.getId());
        userTarget.setStatus(1);
        Long now = System.currentTimeMillis();
        userTarget.setCreateTime(now);
        userTarget.setUpdateTime(now);
        userTargetService.save(userTarget);
        return "redirect:/userTargetList.html";
    }

    @RequestMapping(value="/updateUserTargetStatus.html")
    public void updateUserTargetStatus(HttpServletRequest request, HttpServletResponse response){
        String userTargetIdStr = request.getParameter("userTargetId");
        String statusStr = request.getParameter("status");

        if(StringUtils.isBlank(userTargetIdStr)||StringUtils.isBlank(statusStr)){
            returnFail(response);
        }
        User user = (User) request.getSession().getAttribute("user");
        UserTarget userTarget = new UserTarget();
        userTarget.setId(Long.parseLong(userTargetIdStr));
        userTarget.setStatus(Integer.parseInt(statusStr));
        userTarget.setCreateTime(System.currentTimeMillis());
        userTargetService.save(userTarget);
        returnSucc(response);
    }

    @RequestMapping(value="/addNews.html")
    public String addNews(HttpServletRequest request, HttpServletResponse response){
        String userTargetIdStr = request.getParameter("userTargetId");
        String title = request.getParameter("title");
        String link = request.getParameter("link");
        String content = request.getParameter("content");


        if(StringUtils.isBlank(title)||(StringUtils.isBlank(link)&&StringUtils.isBlank(content))){
            return "redirect:/userTargetDetail.html";
        }
        User user = (User) request.getSession().getAttribute("user");
        NewsBean news = new NewsBean();
        news.setUserTargetId(Long.parseLong(userTargetIdStr));
        news.setStatus(1);
        news.setCreateTime(System.currentTimeMillis());
        try {
            news.setTitle(new String(title.getBytes("ISO-8859-1"), "utf-8"));
            if(StringUtils.isNotBlank(link)){
                news.setLink(new String(link.getBytes("ISO-8859-1"),"utf-8"));
            }
            if(StringUtils.isNotBlank(content)){
                news.setContent(new String(content.getBytes("ISO-8859-1"), "utf-8"));
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        newsService.saveNews(news);
        userTargetService.updateTime(news.getUserTargetId(), System.currentTimeMillis());
        return "redirect:/userTargetDetail.html?userTargetId="+userTargetIdStr;
    }


    @RequestMapping(value="/updateNewsStatus.html")
    public void updateNewsStatus(HttpServletRequest request, HttpServletResponse response){
        String newsIdStr = request.getParameter("newsId");
        String statusStr = request.getParameter("status");

        if(StringUtils.isBlank(newsIdStr)&&StringUtils.isBlank(statusStr)){
            returnFail(response);
        }
        newsService.updateStatus(Long.parseLong(newsIdStr),Integer.parseInt(statusStr));
        returnSucc(response);
    }


}
