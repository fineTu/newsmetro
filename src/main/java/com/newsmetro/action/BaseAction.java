package com.newsmetro.action;

import net.sf.json.JSONObject;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by finetu on 5/29/15.
 */
public class BaseAction {

    protected void returnFail(HttpServletResponse response){
        JSONObject res = new JSONObject();
        res.put("res", false);
        returnJson(response, res);
    }

    protected void returnSucc(HttpServletResponse response){
        JSONObject res = new JSONObject();
        res.put("res", true);
        returnJson(response, res);
    }

    protected void returnJson(HttpServletResponse response,JSONObject res){
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        PrintWriter out = null;
        try {
            out = response.getWriter();
            out.write(res.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
