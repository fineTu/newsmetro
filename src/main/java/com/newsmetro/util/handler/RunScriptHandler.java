package com.newsmetro.util.handler;

import com.newsmetro.util.callback.ScriptOutLineCallback;

import java.io.*;

/**
 * Created by lifeng.gao on 2014/12/26.
 */
public abstract class RunScriptHandler implements Runnable{
    protected String outStr = null;
    private InputStream is;
    private ScriptOutLineCallback callback;
    public void run() {
        BufferedReader br = new BufferedReader(new InputStreamReader(is));
        try {
            String line = null;
            while ((line = br.readLine()) != null) {
                handleLine(line,outStr);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    protected abstract void handleLine(String line,String outStr);

    public String getOutStr() {
        return outStr;
    }

    public void setInputStream(InputStream is) {
        this.is = is;
    }
}
