package com.newsmetro.dao;

import com.newsmetro.po.UserTarget;
import com.newsmetro.pojo.UserTargetForm;

import java.util.List;

/**
 * Created by finetu on 9/11/15.
 */

public interface UserTargetMapper {

    List<UserTarget> find(UserTargetForm form);

    UserTarget findById(Long id);

    void save(UserTarget userTarget);

    void update(UserTarget userTarget);

    void delete(Long id);

}
