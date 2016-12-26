package com.newsmetro.pojo;

import com.newsmetro.util.HttpGetter;
import org.apache.http.client.ClientProtocolException;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.QName;

import javax.swing.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Rss {
	private String title;
	private String link;
	private String rssDescription;
	private ImageIcon image;
	private List<RssItem> itemList;
	public Rss(){
		
	}
	public Rss(Document doc){
		Element root = doc.getRootElement();
		this.title = root.element("channel").element("title").getData().toString();
		this.link = root.element("channel").element("link").attributeValue(new QName("href"));
		this.rssDescription = root.element("channel").element("description").getData().toString();
		HttpGetter getter = new HttpGetter();
		Element image = root.element("channel").element("image");
		if(image!=null){
			try {
				this.image = getter.getImageIcon(image.element("url").getData().toString());
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		List<Element> itemDocList = root.element("channel").elements("item");
		Iterator<Element> it = itemDocList.iterator();
		itemList = new ArrayList<RssItem>();
		while(it.hasNext()){
			Element itemDoc = it.next();
			RssItem item = new RssItem();
			item.setTitle(itemDoc.elementText("title"));
			item.setLinkUrl(itemDoc.elementText("link"));
			String pubDateStr = itemDoc.elementText("pubDate");
			if(pubDateStr!=null){
				item.setPubDate(pubDateStr);
			}
			HtmlBlock block = new HtmlBlock(itemDoc.elementText("description"));
			item.setDescription(block);
			itemList.add(item);
		}
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getRssDescription() {
		return rssDescription;
	}
	public void setRssDescription(String rssDescription) {
		this.rssDescription = rssDescription;
	}
	public ImageIcon getImage() {
		return image;
	}
	public void setImage(ImageIcon image) {
		this.image = image;
	}
	public List<RssItem> getItemList() {
		return itemList;
	}
	public void setItemList(List<RssItem> itemList) {
		this.itemList = itemList;
	}
	
}
