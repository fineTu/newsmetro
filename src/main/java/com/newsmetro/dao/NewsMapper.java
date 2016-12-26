package com.newsmetro.dao;

import com.newsmetro.po.News;
import com.newsmetro.po.NewsContent;
import com.newsmetro.pojo.NewsBean;
import com.newsmetro.pojo.NewsForm;

import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */
public interface NewsMapper {
    List<NewsBean> find(NewsForm form);

    NewsBean findById(Long Id);

    void saveNews(News news);

    void saveContent(NewsContent newsContent);

    void update(News news);
}
