package com.newsmetro.interceptor;

import com.newsmetro.enumeration.AuthorExceptEnum;
import com.newsmetro.enumeration.UserStatus;
import com.newsmetro.exception.AuthorizationException;
import com.newsmetro.po.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StopWatch;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by finetu on 7/7/15.
 */
public class LogInterceptor extends HandlerInterceptorAdapter {
    private static final Logger logger = LoggerFactory.getLogger("STATISTICS");
    private ThreadLocal<StopWatch> watchLocal = new ThreadLocal<StopWatch>();

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        StopWatch watch = new StopWatch();
        watchLocal.set(watch);
        watch.start(handler.toString());
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        StopWatch watch = watchLocal.get();
        watch.stop();

        String url = request.getRequestURI();
        JSONObject requestJson = new JSONObject();
        requestJson.put("url",url);

        JSONObject paramJson = new JSONObject();
        Map<String,String[]> paramMap = request.getParameterMap();
        for(String key:paramMap.keySet()){
            String[] values = paramMap.get(key);
            if(values.length>0&&values.length<=1){
                paramJson.put(key,values[0]);
            }else if(values.length>0){
                JSONArray paramArray = new JSONArray();
                for(String value : paramMap.get(key)){
                    paramArray.add(value);
                }
                paramJson.put(key,paramArray);
            }
        }
        requestJson.put("params",paramJson);
        requestJson.put("response_time",watch.getTotalTimeMillis());
        logger.info(requestJson.toString());
    }
}
