package com.ezen.spring.project.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface QuestionMapper 
{
	public int addBoard(QuestionVO question);
	
	public List<QuestionVO> getList();
	
	public QuestionVO getBoard(int qeustionNum);
	
	public int updateQuestion(QuestionVO q);
	
	public int deleteQuestion(int QuestionNum);
}
