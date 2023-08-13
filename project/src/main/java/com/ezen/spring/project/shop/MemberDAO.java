package com.ezen.spring.project.shop;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class MemberDAO 
{
	@Autowired
	private MemberMapper memberMapper;

	
	public MemberVO getBoard(String memberID) 
	{
		MemberVO mem = memberMapper.getBoard(memberID);
		
		return mem;
	}

	public boolean join(MemberVO member) 
	{
		return memberMapper.join(member)>0;
	}
	
	public boolean login(String memberID, String memberPwd)
	{
		MemberVO member = memberMapper.login(memberID,memberPwd);
		return member != null;
	}
	
	public MemberVO findIdresult(String memberEmail)
	{
		  return memberMapper.findIdresult(memberEmail);
	}
	
	public MemberVO findPwdresult(String memberID, String memberName)
	{
		return memberMapper.findPwdresult(memberID, memberName);
	}

	public boolean updateUser(MemberVO member) 
	{
		return memberMapper.updateUser(member)>0;
	}
	
	public boolean deleteUser(int memberNum)
	{
		return memberMapper.deleteUser(memberNum)>0;
	}
	
	public boolean updateUserSavingsAndPoints(MemberVO member) 
	{
		return memberMapper.updateUserSavingsAndPoints(member) > 0;
	}
	
	public boolean markAttendance(String memberID) {
        return memberMapper.markAttendance(memberID) > 0;
    }
	
	public int getAttendanceCount(String memberID) {
	    return memberMapper.getAttendanceCount(memberID);
	}
	
	public boolean saveAttendanceReward(String memberID, int point) {
	    return memberMapper.saveAttendanceReward(memberID, point) > 0;
	}
	
	public List<Map<String, Object>> getAttendanceData(String memberID) {
	    return memberMapper.getAttendanceData(memberID);
	}

	public boolean hasAlreadyCheckedIn(String uid) {
		return memberMapper.hasAlreadyCheckedIn(uid);
	}

	public List<String> getCheckedInDates(String uid) {
		return memberMapper.getCheckedInDates(uid);
	}
}
