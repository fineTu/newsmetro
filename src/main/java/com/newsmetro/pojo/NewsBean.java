package com.newsmetro.pojo;

import com.newsmetro.po.News;

/**
 * Created by finetu on 9/11/15.
 */
public class NewsBean extends News {

    private String content;
    private String targetName;
    private String publishDate;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTargetName() {
        return targetName;
    }

    public void setTargetName(String targetName) {
        this.targetName = targetName;
    }

    public String getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(String publishDate) {
        this.publishDate = publishDate;
    }
}
