package com.newsmetro.util;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ValueNode;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.*;

/**
 * Created by finetu on 2014/10/13.
 */
public class GsonUtil {
    private static final GsonBuilder builder = new GsonBuilder().excludeFieldsWithoutExposeAnnotation();
    private static final Gson gson = builder.create();
    private static JsonFactory factory = new JsonFactory();
    public static String toJson(Object obj){
        return gson.toJson(obj);
    }

    public static <T> T fromJson(String json,Class<T> clazz){
        return gson.fromJson(json,clazz);
    }
    public static <T> T fromJson(String json,Type type){
        return gson.fromJson(json,type);
    }

    public static Map<String,Object> loads(String jsonStr){
        ObjectMapper mapper = new ObjectMapper(factory);
        JsonNode rootNode = null;
        try {
            rootNode = mapper.readTree(jsonStr);
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,Object> resMap = parseNode2Obj(rootNode);
        return resMap;
    }

    private static Map<String,Object> parseNode2Obj(JsonNode jsonNode){
        Map<String,Object> resMap = new HashMap<String, Object>();
        if(jsonNode.isValueNode()){
            Object value = parseValue(jsonNode);
            resMap.put("",value);
            return resMap;
        }else if(jsonNode.isArray()){
            List<Object> list = new ArrayList<Object>();
            Iterator<JsonNode> it = jsonNode.iterator();
            while( it.hasNext()){
                Map<String,Object> child = parseNode2Obj(it.next());
                if (child.keySet().size() == 1 && child.keySet().contains("")){
                    list.add(child.get(""));
                }else{
                    list.add(child);
                }
            }
            resMap.put("",list);
            return resMap;
        }else {
            Iterator<Map.Entry<String,JsonNode>> it = jsonNode.fields();
            while( it.hasNext()){
                Map.Entry<String,JsonNode> entry = it.next();
                Map<String,Object> child = parseNode2Obj(entry.getValue());
                if (child.keySet().size() == 1 && child.keySet().contains("")){
                    resMap.put(entry.getKey(),child.get(""));
                }else{
                    resMap.put(entry.getKey(),child);
                }
            }
            return resMap;
        }
    }

    private static Object parseValue(JsonNode valueNode){
        if(valueNode.isTextual()){
            return valueNode.asText();
        }else if(valueNode.isInt()){
            return valueNode.asInt();
        }else if(valueNode.isBigInteger() || valueNode.isLong()){
            return valueNode.asLong();
        }else if(valueNode.isFloat() || valueNode.isDouble()){
            return valueNode.asDouble();
        }else if(valueNode.isBoolean()){
            return valueNode.asBoolean();
        }
        return valueNode.asText();
    }

}
