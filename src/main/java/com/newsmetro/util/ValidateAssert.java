package com.newsmetro.util;

import java.util.regex.Pattern;

public class ValidateAssert {
	public static final String NULL_ERROR = "请填写必填项！";
	public static final String NOT_MATCHED = "请输入正确的格式";
	public static boolean notEmpty(String str){
		if(str==null||str.equals("")){
			return false;
		}
		return true;
	}
	
	public static boolean notNull(Object obj){
		if(obj==null){
			return false;
		}
		return true;
	}
	
	public static boolean matchRegex(String regex,String str){
		return Pattern.matches(regex, str);
	}
}
