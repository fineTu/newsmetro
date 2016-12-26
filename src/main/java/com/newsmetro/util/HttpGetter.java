package com.newsmetro.util;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;

import javax.swing.*;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class  HttpGetter {
	private static int CACHE = 4*1024;
	private HttpClient client = new DefaultHttpClient();
	
	public HttpGetter(){
	}
	
	public String getDocument(String url) throws ClientProtocolException, IOException{
		HttpResponse response = client.execute(new HttpGet(url));
		return EntityUtils.toString(response.getEntity(),"UTF-8");
	}
	
	public ImageIcon getImageIcon(String url) throws ClientProtocolException, IOException{
		HttpResponse response = client.execute(new HttpGet(url));
		if(response.getStatusLine().getStatusCode() == 200){
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			InputStream imageInput = response.getEntity().getContent();
			byte [] cache = new byte[CACHE];
			int i = 0;
			while((i=imageInput.read(cache))!=-1){
				baos.write(cache,0,i);
			}
			imageInput.close();
			ImageIcon imageIcon = new ImageIcon(baos.toByteArray());
			baos.flush();
			baos.close();
			return imageIcon;
		}else{
			System.out.print("http响应状态异常:\t");
			System.out.println(response.getStatusLine().getStatusCode());
			return null;
		}
	}
	
	public org.dom4j.Document toDom4jDoc(String docStr) throws DocumentException{
		return DocumentHelper.parseText(docStr);
	}
	
}
