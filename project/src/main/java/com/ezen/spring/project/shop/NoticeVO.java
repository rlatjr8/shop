package com.ezen.spring.project.shop;

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
public class NoticeVO
{
	private int noticeNum;
	private String noticeTitle;
	private String noticeAuthor;
	private java.sql.Date noticedate;
	private String noticeContents;
}
