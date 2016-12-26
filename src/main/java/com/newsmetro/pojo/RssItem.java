package com.newsmetro.pojo;

public class RssItem {
	private String title;
	private String linkUrl;
	private HtmlBlock description;
	private String pubDate;
	public RssItem(){
		
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}
	public HtmlBlock getDescription() {
		return description;
	}
	public void setDescription(HtmlBlock description) {
		this.description = description;
	}
	public String getPubDate() {
		return pubDate;
	}
	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}
	
}
