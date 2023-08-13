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
public class AnswerVO
{
	private int answerNum;
	private String answerContents;
	private String answerAuthor;
	private java.sql.Date answerDate;
	private int pQuestionNum;
}
