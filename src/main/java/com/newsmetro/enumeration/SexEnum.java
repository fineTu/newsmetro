package com.newsmetro.enumeration;

public enum SexEnum {
	MALE("男"),FAMALE("女");
	
	private String value;
	
	private SexEnum(String value) {
		this.value = value;
	}
	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
}
