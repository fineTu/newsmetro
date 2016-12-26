package com.newsmetro.pojo;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.List;

/**
 * Created by lifeng.gao on 2015/1/16.
 */
public class TargetView {
    @Expose
    @SerializedName(value = "isSuccess")
    private Boolean isSuccess;
    @Expose
    @SerializedName(value = "title")
    private String title;
    @Expose
    @SerializedName(value = "link")
    private String link;
    @Expose
    @SerializedName(value = "description")
    private String description;
    @Expose
    @SerializedName(value = "itemList")
    private List<Link> itemList;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public List<Link> getItemList() {
        return itemList;
    }

    public void setItemList(List<Link> itemList) {
        this.itemList = itemList;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getIsSuccess() {
        return isSuccess;
    }

    public void setIsSuccess(Boolean isSuccess) {
        this.isSuccess = isSuccess;
    }
}
