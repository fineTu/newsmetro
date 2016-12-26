package com.newsmetro.util;

import com.newsmetro.po.Target;
import com.newsmetro.pojo.Link;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.htmlcleaner.HtmlCleaner;
import org.htmlcleaner.TagNode;
import org.htmlcleaner.XPatherException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class XpathUtil {
	static Logger logger = LoggerFactory.getLogger(XpathUtil.class.getName());
	
	//HttpGetter getter = new HttpGetter();
	private HttpClient client = null;
	public List<Link> getLinkListByTarget(Target target) throws ClientProtocolException, IOException, XPatherException{
		client = new DefaultHttpClient();
		String docStr = null;
		//String docStr = getter.getDocument(target.getUrl());
		HttpResponse response = null;
		response = client.execute(new HttpGet(target.getUrl()));
		docStr = EntityUtils.toString(response.getEntity(),judgeEncode(response.getEntity().toString()));
		String md5 = MD5Util.md5(docStr, MD5Util._32_BIT);
		target.setMd5(md5);
		HtmlCleaner hc = new HtmlCleaner();  
        TagNode tn = hc.clean(docStr);
        Object[] objarr = null;
        objarr = tn.evaluateXPath(target.getRelXpath());
        List<Link> resList = new ArrayList<Link>();
        if(objarr.length<=0){
        	objarr = tn.evaluateXPath(target.getAbsXpath());
        }
        if(objarr.length>0){
        	TagNode absNode = (TagNode) objarr[0];
    		List<TagNode> aList = (List<TagNode>) absNode.getElementListByName("a", true);
        	for(TagNode n:aList){
        		TagNode[] childTags = n.getChildTags();
        		boolean flag = true;
        		for(TagNode ct:childTags){
        			if("img".equals(ct.getName().toLowerCase())){
        				flag = false;
        				break;
        			}
        		}
        		for(Link link:resList){
        			if(n.getAttributeByName("href").equals(link.getHref())){
        				flag=false;
        				break;
        			}
        		}
        		if(flag==false){
        			continue;
        		}
        		String nStr = n.getText().toString();
        		if(nStr.matches("^[0-9a-zA-Z_-]*")&&nStr.indexOf(" ")==-1){
        			continue;
        		}
        		if(n.getText().toString().length()<=5){
        			continue;
        		}
        		Link link = new Link();
        		link.setText(n.getText().toString());
        		link.setHref(parseHref(target.getUrl(),n.getAttributeByName("href")));
        		resList.add(link);
        		//System.out.println(n.getText());
        	}
        }else{
        		logger.warn("---------------> Xpath解析失败：id:"+target.getId()+
            		"name:"+target.getName()+"url:"+target.getUrl()+
            		"relXpath:"+target.getRelXpath()+"absXpath:"+target.getAbsXpath());
        }
        return resList;
	}
	public static void main(String args[]){
		XpathUtil xpathUtil = new XpathUtil();
		Target target = new Target();
		target.setUrl("http://news.sina.com.cn/");
		target.setRelXpath("//*[@id=\"syncad_1\"]");
		try {
			xpathUtil.getLinkListByTarget(target);
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (XPatherException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String judgeEncode(String s) {
        //默认GBK编码
        try {
            if (Character.UnicodeBlock.of(new String(s.getBytes("ISO8859_1"), "UTF-8").charAt(0)) == Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS) {
                return "UTF-8";
            } else {
                return "GBK";
            }
        } catch(Exception e) {
            return "GBK";
        }
    }
	
	private String parseHref(String url,String href){
		if(href.indexOf("/")==0){
			if(url.lastIndexOf("/")==url.length()-1){
				return url.substring(0,url.length()-1)+href;
			}else{				
				return url+href;
			}
		}
		return href;
	}
}


