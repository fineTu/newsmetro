package com.newsmetro.exception;

import com.newsmetro.enumeration.AuthorExceptEnum;

public class AuthorizationException extends Exception{
	private AuthorExceptEnum errorEnum;
	
	public AuthorizationException(AuthorExceptEnum errorEnum){
		this.errorEnum = errorEnum;
	}
	
	public AuthorExceptEnum getErrorEnum() {
		return errorEnum;
	}

	public void setErrorEnum(AuthorExceptEnum errorEnum) {
		this.errorEnum = errorEnum;
	}
	
}
