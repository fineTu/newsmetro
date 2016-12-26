package com.newsmetro.po;

import com.newsmetro.enumeration.SexEnum;
import com.newsmetro.enumeration.UserStatus;

import java.util.Date;


/**
 * User entity. @author MyEclipse Persistence Tools
 */
public class User implements java.io.Serializable {

	public static final int STATUS_REGULAR = 1;
	public static final int STATUS_NEW = 2;
	public static final int STATUS_DENIED = 3;
	public static final int STATUS_CANCEL = 4;

	public static final int SEX_NULL = 0;
	public static final int SEX_MALE = 1;
	public static final int SEX_FEMALE = 2;
	// Fields

	private Long id;
	private Long userId;
	private String name;
	private String password;
	private String email;
	private Integer sex;
	private String photo;
	private String sign;
	private Integer status;
	private String code;
	private Long updateTime;
	private Long createTime;


	/** default constructor */
	public User() {
	}

	// Property accessors

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public Long getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Long updateTime) {
		this.updateTime = updateTime;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}
}