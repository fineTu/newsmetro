package com.newsmetro.pojo;

import com.newsmetro.po.Target;
import com.newsmetro.po.TargetGroup;

import java.util.List;

/**
 * Created by finetu on 5/29/15.
 */
public class TargetGroupBean {
    private TargetGroup targetGroup;
    private List<Target> targetList;

    public TargetGroup getTargetGroup() {
        return targetGroup;
    }

    public void setTargetGroup(TargetGroup targetGroup) {
        this.targetGroup = targetGroup;
    }

    public List<Target> getTargetList() {
        return targetList;
    }

    public void setTargetList(List<Target> targetList) {
        this.targetList = targetList;
    }
}
