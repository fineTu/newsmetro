package com.newsmetro.dao;

import com.newsmetro.po.TargetCache;
import org.apache.ibatis.annotations.Param;

/**
 * Created by finetu on 14-10-12.
 */
public interface TargetCacheMapper {
    TargetCache getTargetCacheByTargetId(@Param("targetId") Long targetId);

    void saveTargetCache(@Param("targetCache") TargetCache targetCache);

    void delete(@Param("targetId") Long targetId);
}
