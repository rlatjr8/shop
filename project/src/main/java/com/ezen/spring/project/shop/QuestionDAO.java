package com.ezen.spring.project.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class QuestionDAO
{
	@Autowired
	private QuestionMapper questionMapper;
	
	public boolean addBoard(QuestionVO question)
	{
		boolean added = questionMapper.addBoard(question)>0;
		
		return added;
	}

	public Object getList() 
	{
		
		return questionMapper.getList();
	}
	
	public QuestionVO getBoard(int questionNum)
	{
		QuestionVO question = questionMapper.getBoard(questionNum);
		return question;
	}

	public boolean updateQuestion(QuestionVO q) {
		return questionMapper.updateQuestion(q)>0;
	}
	
	public boolean deleteQuestion(int QuestionNum) {
		return questionMapper.deleteQuestion(QuestionNum)>0;
	}
}
