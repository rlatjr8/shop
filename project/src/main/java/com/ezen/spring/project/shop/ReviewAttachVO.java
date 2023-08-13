package com.ezen.spring.project.shop;

import org.springframework.stereotype.Component;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Component
@ToString

public class ReviewAttachVO
{
	private int reviewattachNum;
	private String reviewattachName;
	private int reviewattachparentsNum;
	private float reviewattachfSize;
	private String reviewattachfContentType;
	public int getReviewattachNum() {
		return reviewattachNum;
	}
	public void setReviewattachNum(int reviewattachNum) {
		this.reviewattachNum = reviewattachNum;
	}
	public String getReviewattachName() {
		return reviewattachName;
	}
	public void setReviewattachName(String reviewattachName) {
		this.reviewattachName = reviewattachName;
	}
	public int getReviewattachparentsNum() {
		return reviewattachparentsNum;
	}
	public void setReviewattachparentsNum(int reviewattachparentsNum) {
		this.reviewattachparentsNum = reviewattachparentsNum;
	}
	public float getReviewattachfSize() {
		return reviewattachfSize;
	}
	public void setReviewattachfSize(float reviewattachfSize) {
		this.reviewattachfSize = reviewattachfSize;
	}
	public String getReviewattachfContentType() {
		return reviewattachfContentType;
	}
	public void setReviewattachfContentType(String reviewattachfContentType) {
		this.reviewattachfContentType = reviewattachfContentType;
	}
}
