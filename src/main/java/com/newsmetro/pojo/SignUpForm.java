package com.newsmetro.pojo;

import com.newsmetro.enumeration.SexEnum;

public class SignUpForm {
	private String name;
	private String email;
//	@Pattern(regexp="[^\\s]{6,11}")
	private String password;
//	@Pattern(regexp="[^\\s]{6,11}")
	private String repassword;
	private Integer sex;
	private String photo;
	private String talking;
	
	public SignUpForm() {
	}
	

	public SignUpForm(String name, String email, String password,
			String repassword, Integer sex, String photo, String talking) {
		super();
		this.name = name;
		this.email = email;
		this.password = password;
		this.repassword = repassword;
		this.sex = sex;
		this.photo = photo;
		this.talking = talking;
	}


	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRepassword() {
		return repassword;
	}
	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getTalking() {
		return talking;
	}
	public void setTalking(String talking) {
		this.talking = talking;
	}
}
