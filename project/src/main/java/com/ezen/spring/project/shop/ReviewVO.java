package com.ezen.spring.project.shop;

import java.util.List;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
@EqualsAndHashCode
public class ReviewVO 
{
	private int reviewNum;
	private String reviewTitle;
	private String reviewAuthor;
	private String reviewContents;
	private java.sql.Date reviewdate;
	private int reviewparentsNum;
	private int reviewLikeCnt;
	
	List<ReviewAttachVO> reviewattList;
}
