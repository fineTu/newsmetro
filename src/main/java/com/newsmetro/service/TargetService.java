package com.newsmetro.service;

import com.newsmetro.constant.RedisConstants;
import com.newsmetro.dao.TargetMapper;
import com.newsmetro.enumeration.TargetStatus;
import com.newsmetro.po.Target;
import com.newsmetro.pojo.TargetForm;
import com.newsmetro.util.RedisUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

import java.util.List;

@Service
public class TargetService {

	@Autowired
	private TargetMapper targetMapper;
	
	public void addTarget(Target target){
        targetMapper.save(target);
	}

	public List<Target> findTargetList(TargetForm form){
		List<Target> list = targetMapper.findTarget(form);
		return list;
	}

    public Target getTargetById(Long id){
        return targetMapper.getTargetById(id);
    }

	public void deleteTarget(Long id){
        targetMapper.deleteById(id);
	}

	public void updateTarget(Target target){
        targetMapper.update(target);
	}

    public String getTargetMd5(Long id) {
        if(id==null){
            return null;
        }
        String md5 = getTargetMd5FromRedis(id);
        if(StringUtils.isEmpty(md5)){
            Target t = targetMapper.getTargetById(id);
            md5 = t.getMd5();
        }
        return md5;
    }

    private String getTargetMd5FromRedis(final Long id){
        return RedisUtil.execute(RedisConstants.REDIS_POOL_MASTER, new RedisUtil.RedisCallback<String>() {
            public String doRedis(Jedis jedis) {
                String key = RedisConstants.REDIS_KEY_TARGET_MD5_PREFIX + id.toString();
                return jedis.get(key);
            }
        });
    }
}
