package com.newsmetro.pojo;

import com.newsmetro.po.UserTarget;

/**
 * Created by finetu on 9/11/15.
 */
public class UserTargetForm extends UserTarget {
    private String orderBy;
    private Integer offset;
    private Integer pageSize;

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public Integer getOffset() {
        return offset;
    }

    public void setOffset(Integer offset) {
        this.offset = offset;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
}
