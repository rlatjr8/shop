package com.ezen.spring.project.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface NoticeMapper 
{
	public int addBoard(NoticeVO notice);
	
	public List<NoticeVO> getList();
	
	public NoticeVO getBoard(int noticeNum);

	public int updateBoard(NoticeVO notice);
	
	public int deleteBoard(int noticeNum);
}
