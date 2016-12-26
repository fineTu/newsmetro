package com.newsmetro.dao;

import com.newsmetro.enumeration.TargetStatus;
import com.newsmetro.po.Target;
import com.newsmetro.pojo.TargetForm;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by lifeng.gao on 2014/10/11.
 */
public interface TargetMapper {
    void save(Target target);

    List<Target> findTarget(TargetForm form);

    Target getTargetById(@Param("id") Long id);

    void deleteById(@Param("id") Long id);

    void update(@Param("target")Target target);
}
