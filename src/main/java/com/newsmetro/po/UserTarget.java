package com.newsmetro.po;

import com.newsmetro.pojo.NewsBean;

import java.util.List;

/**
 * Created by finetu on 8/14/15.
 */
public class UserTarget {
    private Long id;
    private Long userId;
    private String name;
    private Integer status;
    private Long updateTime;
    private Long createTime;
    private List<NewsBean> newsList;
    private Integer isAuthor;
    private Integer focused;
    private User author;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Long getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Long updateTime) {
        this.updateTime = updateTime;
    }

    public Long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Long createTime) {
        this.createTime = createTime;
    }

    public List<NewsBean> getNewsList() {
        return newsList;
    }

    public void setNewsList(List<NewsBean> newsList) {
        this.newsList = newsList;
    }

    public Integer getIsAuthor() {
        return isAuthor;
    }

    public void setIsAuthor(Integer isAuthor) {
        this.isAuthor = isAuthor;
    }

    public Integer getFocused() {
        return focused;
    }

    public void setFocused(Integer focused) {
        this.focused = focused;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }
}
