package com.ezen.spring.project.shop;

import org.springframework.stereotype.Component;

import lombok.ToString;

@Component
@ToString
public class ItemAttachVO
{
	private int itemattachNum;
	private String itemattachName;
	private int itemparentsNum;
	private float itemfSize;
	private String itemfContentType;
	
	public int getItemattachNum() {
		return itemattachNum;
	}
	public void setItemattachNum(int itemattachNum) {
		this.itemattachNum = itemattachNum;
	}
	public String getItemattachName() {
		return itemattachName;
	}
	public void setItemattachName(String itemattachName) {
		this.itemattachName = itemattachName;
	}
	public int getItemparentsNum() {
		return itemparentsNum;
	}
	public void setItemparentsNum(int itemparentsNum) {
		this.itemparentsNum = itemparentsNum;
	}
	public float getItemfSize() {
		return itemfSize;
	}
	public void setItemfSize(float itemfSize) {
		this.itemfSize = itemfSize;
	}
	public String getItemfContentType() {
		return itemfContentType;
	}
	public void setItemfContentType(String itemfContentType) {
		this.itemfContentType = itemfContentType;
	}
	
	
	
	
	
}
