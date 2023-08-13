package com.ezen.spring.project.shop;

import java.util.*;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Component
@Mapper
public interface MemberMapper 
{

	public MemberVO getBoard(String memberID);
	
	public int join(MemberVO member);
	
	public MemberVO login(String memberID, String memberPwd);
	
	public MemberVO findIdresult(String memberEmail);
	
	public MemberVO findPwdresult(String memberID, String memberName);

	public int updateUser(MemberVO member);
	
	public int deleteUser(int memberNum);
	
	public int sMoneyAndPoint(ItemOrderVO order);

	public int updateUserSavingsAndPoints(MemberVO member);
	
	public int markAttendance(String memberID);

	public int getAttendanceCount(String memberID);

	public int saveAttendanceReward(@Param("memberID") String memberID, @Param("saveMoney") int saveMoney);

	public List<Map<String, Object>> getAttendanceData(String memberID);

	public boolean hasAlreadyCheckedIn(String uid);

	public List<String> getCheckedInDates(String uid);
}
