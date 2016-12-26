package com.newsmetro.enumeration;

public enum AuthorExceptEnum {
	NO_SIGNIN("未登录"),NO_ACTIVE("未激活"),DENIED("账号被封"),UN_KNOW("未知错误");
	
	private String value;
	
	private AuthorExceptEnum(String value) {
		this.value = value;
	}
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
}
