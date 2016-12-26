package com.newsmetro.util;

import com.newsmetro.util.callback.ScriptOutLineCallback;
import com.newsmetro.util.handler.RunScriptHandler;

import java.io.*;
import java.util.List;

/**
 * Created by lifeng.gao on 2014/12/26.
 */
public class RuntimeUtil {
    public static String execute(String command,RunScriptHandler handler){
        String resStr = null;
        try {

            Process proc = Runtime.getRuntime().exec(command);
            final InputStream is = proc.getInputStream();
            handler.setInputStream(is);
            new Thread(handler).start();
            resStr = handler.getOutStr();
            proc.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resStr;
    }


}
