package com.newsmetro.pojo;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import javax.swing.*;
import java.util.Iterator;
import java.util.List;

public class HtmlBlock {
	private String htmlCode;
	private String descreption;
	private ImageIcon keyImage;
	private List<ImageIcon> imageList;
	
	public HtmlBlock(){
		
	}
	
	public HtmlBlock(String htmlStr){
		this.htmlCode = htmlStr;
		StringBuffer sb = new StringBuffer(htmlStr);
		int index = 0;
		while((index = sb.indexOf("<![CDATA["))!=-1){
			sb.delete(index, index+9);
			int index2 = sb.indexOf("]]>");
			sb.delete(index2,index2+3);
		}
			
		Document doc = Jsoup.parseBodyFragment(sb.toString());
		List<Element> pList = doc.getElementsByTag("p");//未考虑p标签嵌套
		List<Element> imageList = doc.getElementsByTag("img");
		Iterator<Element> it = pList.iterator();
		StringBuffer sb2 = new StringBuffer();
		if(pList.size()>0){
			while(it.hasNext()){
				Element p = it.next();
				String append = parsePToText(p.html());
				sb2.append(append);
				if(!append.trim().equals("")){
					sb2.append("\n");
				}
			}
		}else{
			String append = parsePToText(sb.toString());
			sb2.append(append);
			if(!append.trim().equals("")){
				sb2.append("\n");
			}
		}
		
		descreption = sb2.toString();
	}
	
	private String parsePToText(String html){
		StringBuffer sb = new StringBuffer(html);
		int index = 0;
		while((index = sb.indexOf("<"))!=-1){
			int tagEnd = 0;
			if((tagEnd = sb.indexOf(">"))!=-1){
				sb.delete(index, tagEnd+1);
				//sb.insert(index, "$");
			}
		}
		boolean end = false;
		while((index = sb.indexOf("&"))!=-1&&!end){
			int tagEnd = 0;
			if((tagEnd = sb.substring(index).indexOf(";"))!=-1&&tagEnd>index){
				sb.delete(index, index + tagEnd+1);
			}else{
				end = true;
			}
		}
		return sb.toString();
	}
	public String getHtmlCode() {
		return htmlCode;
	}
	public void setHtmlCode(String htmlCode) {
		this.htmlCode = htmlCode;
	}
	public String getDescreption() {
		return descreption;
	}
	public void setDescreption(String descreption) {
		this.descreption = descreption;
	}
	public ImageIcon getKeyImage() {
		return keyImage;
	}

	public void setKeyImage(ImageIcon keyImage) {
		this.keyImage = keyImage;
	}

	public List<ImageIcon> getImageList() {
		return imageList;
	}
	public void setImageList(List<ImageIcon> imageList) {
		this.imageList = imageList;
	}
	
}
