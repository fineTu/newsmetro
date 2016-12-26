package com.newsmetro.util;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

/**
 * Created by lifeng.gao on 2014/12/8.
 */
public class RedisUtil implements InitializingBean, ApplicationContextAware {
    private static final Logger logger = LoggerFactory.getLogger(RedisUtil.class);
    private ApplicationContext applicationContext;
    private static RedisUtil instance;

    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }

    public void afterPropertiesSet() throws Exception {
        this.instance = this;
    }

    public static <T> T execute(String redisPoolBeanId, RedisCallback<T> callback) {
        JedisPool pool = instance.applicationContext.getBean(redisPoolBeanId,JedisPool.class);
        return instance.execute(pool, callback);
    }

    private <T> T execute(JedisPool pool, RedisCallback<T> callback) {
        Jedis jedis = null;
        Boolean broken = false;

        try {
            jedis = pool.getResource();
            return callback.doRedis(jedis);
        } catch (Exception e) {
            broken = true;
            logger.error(ExceptionUtils.getMessage(e));
        }finally {
            closeResource(pool,jedis,broken);
        }
        return null;
    }

    private void closeResource(JedisPool pool, Jedis jedis,Boolean broken){
        if(jedis==null){
            return;
        }
        try {
            if(broken){
                pool.returnBrokenResource(jedis);
            }else{
                pool.returnResource(jedis);
            }
        } catch (Exception e) {
            logger.error("Error happen when return jedis to pool, try to close it directly.", e.fillInStackTrace());
        }
    }


    public interface RedisCallback<T>{
        T doRedis(Jedis jedis);
    }
}
