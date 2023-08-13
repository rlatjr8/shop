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
public class QuestionVO 
{
	private int questionNum;
	private String questionTitle;
	private String questionAuthor;
	private java.sql.Date questionDate;
	private String questionContents;
	
	private List<AnswerVO> answers;
}
