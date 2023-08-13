package com.ezen.spring.project.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class NoticeDAO
{
	@Autowired
	private NoticeMapper noticeMapper;
	
	public boolean addBoard(NoticeVO notice)
	{
		boolean added = noticeMapper.addBoard(notice)>0;
		return added;
	}
	
	public Object getList()
	{
		return noticeMapper.getList();
	}
	
	public NoticeVO getBoard(int noticeNum)
	{
		NoticeVO notice = noticeMapper.getBoard(noticeNum);
		return notice;
	}
	
	public boolean updateBoard(NoticeVO notice)
	{
		return noticeMapper.updateBoard(notice)>0;
	}
	
	public boolean deleteBoard(int noticeNum)
	{
		return noticeMapper.deleteBoard(noticeNum)>0;
	}
}
