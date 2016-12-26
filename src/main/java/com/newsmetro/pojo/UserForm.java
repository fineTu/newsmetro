package com.newsmetro.pojo;

import com.newsmetro.po.User;

/**
 * Created by finetu on 7/18/15.
 */
public class UserForm extends User {
    private Long startTime;
    private Long endTime;

    public UserForm(){}

    public UserForm(User user){
        
    }

    public Long getStartTime() {
        return startTime;
    }

    public void setStartTime(Long startTime) {
        this.startTime = startTime;
    }

    public Long getEndTime() {
        return endTime;
    }

    public void setEndTime(Long endTime) {
        this.endTime = endTime;
    }
}
