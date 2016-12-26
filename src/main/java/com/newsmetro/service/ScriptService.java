package com.newsmetro.service;


import com.newsmetro.constant.RedisConstants;
import com.newsmetro.constant.SystemConfig;

import com.newsmetro.util.GsonUtil;
import com.newsmetro.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Created by lifeng.gao on 2014/12/26.
 */
@Service
public class ScriptService {
    private Hashtable<String,TryTargetProcess> procMap = new Hashtable<String, TryTargetProcess>();
//    public String tryTarget(String url,String xpath) {
//        String res = "";
//        String command = SystemConfig.getWebSingleCrawlerPath() + " " + url + " " + xpath;
//        try {
//            Process process = Runtime.getRuntime().exec(command);
//            process.waitFor();
//            InputStreamReader ir = new InputStreamReader(process.getInputStream());
//
//            LineNumberReader input = new LineNumberReader(ir);
//            String line;
//
//            while((line = input.readLine()) != null){
//                res += line;
//            }
//            input.close();
//            ir.close();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        catch (InterruptedException e) {
//            e.printStackTrace();
//        }
//        return res;
//    }

    public String tryTarget(final String url,final String xpath,final String xquery) {
        String res = "";
        TryTargetProcess tryProc = new TryTargetProcess(url,xpath,xquery);
        procMap.put(tryProc.getKey(),tryProc);
        String resStr = tryProc.sendReqAndWaitForRes();
        procMap.remove(tryProc.getKey());
        return resStr;
    }

    public void acceptTryRes(String key,String resStr){
        TryTargetProcess tryProc = procMap.get(key);
        tryProc.acceptResAndNotify(resStr);
    }
    public String tryRss(String url){
        String command = SystemConfig.getRssSingleCrawlerPath() + url;
        String items = "";
        try {
            Process process = Runtime.getRuntime().exec(command);
            process.waitFor();
            InputStreamReader ir = new InputStreamReader(process.getInputStream());

            LineNumberReader input = new LineNumberReader(ir);
            String line;
            while((line = input.readLine()) != null)
                items += line;
            input.close();
            ir.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        return items;
    }

    class TryTargetProcess{
        private final  Lock lock = new ReentrantLock();
        private final Condition hasRes = lock.newCondition();
        private String url;
        private String xpath;
        private String xquery;
        private String  key;
        private String resStr = null;

        public TryTargetProcess(String url,String xpath,String xquery){
            this.url = url;
            this.xpath = xpath;
            this.xquery = xquery;
            Random r = new Random();
            this.key = r.nextInt(10000)+"_"+System.currentTimeMillis();
        }

        public String sendReqAndWaitForRes(){
            RedisUtil.execute(RedisConstants.REDIS_POOL_MASTER, new RedisUtil.RedisCallback<Long>() {
                public Long doRedis(Jedis jedis) {
                    String redisKey = RedisConstants.REDIS_KEY_TRY_TARGET_QUEUE;
                    Map<String,String> reqMap = new  HashMap<String,String>();
                    reqMap.put("url",url);
                    reqMap.put("xpath",xpath);
                    if(StringUtils.isNotBlank(xquery)){
                        reqMap.put("xquery",xquery);
                    }
                    reqMap.put("try_key",key);
                    return jedis.rpush(redisKey, GsonUtil.toJson(reqMap));
                }
            });
            lock.lock();
            try{
                if(!hasRes()){
                    hasRes.await(60l,TimeUnit.SECONDS);
                }
                if(hasRes()){
                    return resStr;
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            } finally {
                lock.unlock();
            }
            return null;
        }

        public void acceptResAndNotify(String resStr){
            lock.lock();
            try{
                this.resStr = resStr;
                hasRes.signalAll();
            }finally {
                lock.unlock();
            }
        }

        private boolean hasRes(){
            return resStr != null;
        }

        public String getKey(){
            return this.key;
        }
    }
}
