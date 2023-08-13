<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원정보 수정</title>
<style type="text/css">
main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px;}
#aa {color:black;}
body {
      font-family: Arial, sans-serif;
    }

    main {
      width: 80%;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      background-color: #f8f8f8;
      border-radius: 10px;
      box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
    }

    h3 {
      text-align: center;
      margin-bottom: 20px;
    }

    div {
      margin-bottom: 10px;
    }

    label {
      display: inline-block;
      width: 100px;
      font-weight: bold;
    }

    nav {
      text-align: center;
      margin-top: 20px;
    }

    a {
      text-decoration: none;
      color: #448AFF;
    }

    a:hover {
      text-decoration: underline;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delUser(memberNum) {
	if(!confirm("정말로 탈퇴하시겠어요?")) return;
	$.ajax({
		url:'/member/delete/'+memberNum,
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '회원탈퇴 완료':'탈퇴 실패');
			location.href='/member/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function updateUser() {
	var serdata = $('#updateForm').serialize();
	$.ajax({
		url:'/member/update',
		method:'post',
		cache:false,
		data:serdata,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 실패');
			if(res.updated) location.href='/member/detail/${userid}';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>회원정보 수정</h3>
	<form id="updateForm" onsubmit="return updateUser();">
		<input type="hidden" name="memberID" value="${mem.memberID}">
	<table>
		<div><label>이름</label><input type="text" name="memberName" value="${mem.memberName}"></div>
		<div><label>번호</label>${mem.memberPhone}</div>
		<div><label>주소</label>${mem.memberAddress}</div>
		<div><label>ID</label>${mem.memberID}</div>
		<div><label>이메일</label><input type="text" name="memberEmail" value="${mem.memberEmail}"></div>
		<div><label>성별</label>${mem.memberSex}</div>
		<div><label>국적</label>${mem.national}</div>
		<div><label>생일</label>${mem.memberBirth}</div>
		<div><label>관심사</label>${mem.interest}</div>
		<div><label>적립금</label>${mem.saveMoney}</div>
	</table>
	<div id="btn">
		<button type="reset">원래대로</button>
		<button type="submit">수정</button>
	</div>
	</form>
	<nav>
		[<a href='/member/detail/${userid}'>취소</a>]
		[<a href="javascript:delUser(${mem.memberNum});">회원탈퇴</a>]
	</nav>
	
	
	
</main>
</body>
</html>