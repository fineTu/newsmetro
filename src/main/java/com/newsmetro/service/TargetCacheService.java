package com.newsmetro.service;

import com.newsmetro.dao.TargetCacheMapper;
import com.newsmetro.po.TargetCache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by finetu on 14-10-12.
 */

@Service
public class TargetCacheService {
    @Autowired
    private TargetCacheMapper targetCacheMapper;

    public TargetCache getTargetCacheByTargetId(Long targetId) {
        return targetCacheMapper.getTargetCacheByTargetId(targetId);
    }

    public void saveTargetCache(TargetCache targetCache) {
        targetCacheMapper.saveTargetCache(targetCache);
    }

    public void deleteTargetCache(Long targetId){
        targetCacheMapper.delete(targetId);
    }

}
