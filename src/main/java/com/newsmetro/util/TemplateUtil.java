package com.newsmetro.util;

import com.hubspot.jinjava.Jinjava;
import org.apache.commons.io.IOUtils;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by finetu on 9/20/16.
 */

public class TemplateUtil {
//    @Value("classpath:target_temp_default.ja")
    private static Jinjava jinjava = null;
    private static String DEFAULT_TEMP = null;
    private static TemplateUtil instance = null;

    private TemplateUtil(String templatePath) {
        jinjava = new Jinjava();
//        DEFAULT_TEMP = readToString("/home/tmp/target_temp_default.ja");
//        FileLocator fl = new FileLocator();
        try {
            Resource defaultTempResource =  new ClassPathResource(templatePath);
            DEFAULT_TEMP = IOUtils.toString(defaultTempResource.getInputStream());
//            DEFAULT_TEMP = fl.getString("resources/target_temp_default.ja", StandardCharsets.UTF_8,null);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static TemplateUtil getInstance(String templatePath){
        if(instance == null){
            instance = new TemplateUtil(templatePath);
        }
        return instance;
    }

    public static String render(Map<String,Object> data){
        return instance.jinjava.render(DEFAULT_TEMP,data);
    }

    public static String render(Map<String,Object> data,String template){
        return instance.jinjava.render(template,data);
    }

    public static void main(String[] args){

        Map<String,Object> context = new HashMap<String, Object>();
        Map<String,Object> meta = new HashMap<String, Object>();
        meta.put("url","http://news.sina.com.cn/");
        meta.put("target_id",4);
        meta.put("md5","c332d8aad1bd2b243623235394f26110");
        List<Map<String,String>> dataList = new ArrayList<Map<String,String>>();
        Map<String,String> item = new HashMap<String, String>();
        item.put("text","一带一路：习近平打开的筑梦空间");
        item.put("href","http://gov.sina.com.cn/zt/xjpbdj/");
        dataList.add(item);
        item = new HashMap<String, String>();
        item.put("text","李克强联合国讲话承诺援助难民");
        item.put("href","http://news.sina.com.cn/china/xlxw/2016-09-20/doc-ifxvyrit2900472.shtml");
        dataList.add(item);
        item = new HashMap<String, String>();
        item.put("text","中企协助朝鲜发展核项目？外交部回应");
        item.put("href","http://news.sina.com.cn/c/nd/2016-09-20/doc-ifxvykwk5279848.shtml");
        dataList.add(item);
        context.put("meta",meta);
        context.put("data",dataList);

        String res = TemplateUtil.render(context);
        System.out.println(res);
    }
}
