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
public class MemberVO
{
	private int memberNum;
	private String memberName;
	private String memberPhone;
	private String memberAddress;
	private String memberID;
	private String memberPwd;
	private String memberEmail;
	private String memberSex;
	private String memberBirth;
	private String national;
	private int saveMoney;
	private int point;
	private int couponNum;
	private String interest;
	private int attendance;
	private int attendCount;
	
	
	
}
