package com.newsmetro.po;


/**
 * Target entity. @author MyEclipse Persistence Tools
 */

public class Target implements java.io.Serializable {
	
	public static final int STATUS_REGULAR = 1;
	public static final int STATUS_HIDE = 2;

	public static final int TYPE_WEB = 1;
	public static final int TYPE_RSS = 2;
	public static final int TYPE_USER = 3;

	// Fields

	private Long id;
	private User user;
    private Long userId;
	private Long userTargetId;
	private String name;
	private String url;
	private String absXpath;
	private String relXpath;
	private String regex;
	private String xquery;
	private String template;
	private Long parentId;
	private String md5;
	private Integer type;
	private Integer status;
	private Long createTime;

	// Property accessorsl


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getUserId() {
        return userId;
    }

	public Long getUserTargetId() {
		return userTargetId;
	}

	public void setUserTargetId(Long userTargetId) {
		this.userTargetId = userTargetId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getAbsXpath() {
		return this.absXpath;
	}

	public void setAbsXpath(String absXpath) {
		this.absXpath = absXpath;
	}

	public String getRelXpath() {
		return this.relXpath;
	}

	public void setRelXpath(String relXpath) {
		this.relXpath = relXpath;
	}

	public String getRegex() {
		return this.regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public String getMd5() {
		return this.md5;
	}

	public void setMd5(String md5) {
		this.md5 = md5;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public String getXquery() {
		return xquery;
	}

	public void setXquery(String xquery) {
		this.xquery = xquery;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}
}