package com.newsmetro.constant;

/**
 * Created by lifeng.gao on 2014/12/26.
 */
public class SystemConfig {
    private String webSingleCrawlerPath;
    private String rssSingleCrawlerPath;

    private static SystemConfig instance;

    public void init(){
        this.instance = this;
    }
    public static String getWebSingleCrawlerPath() {
        return instance.webSingleCrawlerPath;
    }

    public void setWebSingleCrawlerPath(String webSingleCrawlerPath) {
        this.webSingleCrawlerPath = webSingleCrawlerPath;
    }

    public static String getRssSingleCrawlerPath() {
        return instance.rssSingleCrawlerPath;
    }

    public void setRssSingleCrawlerPath(String rssSingleCrawlerPath) {
        this.rssSingleCrawlerPath = rssSingleCrawlerPath;
    }
}
