package com.newsmetro.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

public class UrlUtil {
	public static void main(String args[]) throws UnsupportedEncodingException{
		System.out.println(URLDecoder.decode(URLEncoder.encode("lC/IsCnKVpc8hNwBfnp+rcPnStoHTp8ZJZILYjVPVgmkjQwdmavdT0nswBFipBDLIUPLDKNryOE=", "utf-8"),"utf-8"));
	}
}
