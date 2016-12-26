package com.newsmetro.enumeration;

public enum UserStatus {
	REGULAR("正常"),NEW("未激活"),DENIED("封号"),CANCEL("已注销");
	private UserStatus(String value){
		this.value = value;
	}
	
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	private String value;
}
