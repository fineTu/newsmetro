package com.newsmetro.pojo;

import com.newsmetro.po.News;

import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */
public class NewsForm extends News{
    private Integer offset;
    private Integer pageSize;
    private List<Long> targetIds;

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

    public List<Long> getTargetIds() {
        return targetIds;
    }

    public void setTargetIds(List<Long> targetIds) {
        this.targetIds = targetIds;
    }
}
