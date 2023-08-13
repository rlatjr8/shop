package com.ezen.spring.project.shop;


import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface ReviewMapper 
{
	public int addReview(ReviewVO review);
	public int addReviewAttach(List<ReviewAttachVO> list);
	public List<Map<String, Object>> getList();
	public List<Map<String, String>> search(String category, String keyword);
	public List<Map<String, String>> getReview(int reviewNum);
}
