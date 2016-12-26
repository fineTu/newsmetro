package com.newsmetro.service;

import com.newsmetro.dao.NewsMapper;
import com.newsmetro.po.News;
import com.newsmetro.po.NewsContent;
import com.newsmetro.pojo.NewsBean;
import com.newsmetro.pojo.NewsForm;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */
@Service
public class NewsService {
    @Autowired
    private NewsMapper newsMapper;

    public void saveNews(NewsBean newsBean){
        newsMapper.saveNews(newsBean);
        if(StringUtils.isNotBlank(newsBean.getContent())){
            NewsContent newsContent = new NewsContent();
            newsContent.setContent(newsBean.getContent());
            newsContent.setCreateTime(newsBean.getCreateTime());
            newsContent.setNewsId(newsBean.getId());
            newsMapper.saveContent(newsContent);
        }

    }

    public void updateStatus(Long id,Integer status) {
        News news = new News();
        news.setId(id);
        news.setStatus(status);
        newsMapper.update(news);
    }

    public NewsBean findById(Long id) {
       return newsMapper.findById(id);
    }

    public List<NewsBean> find(NewsForm form){
        return newsMapper.find(form);
    }


}
