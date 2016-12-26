package com.newsmetro.service;

import com.newsmetro.dao.UserTargetMapper;
import com.newsmetro.po.UserTarget;
import com.newsmetro.pojo.UserTargetForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */
@Service
public class UserTargetService {
    @Autowired
    private UserTargetMapper userTargetMapper;

    public List<UserTarget> find(UserTargetForm form){
        return userTargetMapper.find(form);
    }

    public UserTarget findById(Long id){
        return userTargetMapper.findById(id);
    }

    public void save(UserTarget userTarget){
        userTargetMapper.save(userTarget);
    }

    public void updateStatus(Long id,Integer status){
        UserTarget userTarget = new UserTarget();
        userTarget.setId(id);
        userTarget.setStatus(status);
        userTargetMapper.update(userTarget);
    }

    public void updateTime(Long id,Long updateTime){
        UserTarget userTarget = new UserTarget();
        userTarget.setId(id);
        userTarget.setUpdateTime(updateTime);
        userTargetMapper.update(userTarget);
    }

    public void delete(Long id){
        userTargetMapper.delete(id);
    }

}
