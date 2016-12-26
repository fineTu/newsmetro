package com.newsmetro.enumeration;

public enum TargetStatus {
	REGULAR("正常"),HIDE("隐藏");
	private TargetStatus(String value){
		this.value = value;
	}
	private String value;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
