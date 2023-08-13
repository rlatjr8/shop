<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 폼</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
    }
    main {
        max-width: 400px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }
    h3 {
        text-align: center;
    }
    form {
        margin-top: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    input[type="text"],
    input[type="password"] {
        width: 95%;
        padding: 8px;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    button {
        padding: 8px 15px;
        margin-top:10px;
        font-size: 16px;
        border-radius: 5px;
        border: none;
        color: #fff;
        background-color: #007bff;
        cursor: pointer;
    }
   
    button[type="submit"] {
        background-color: #6c757d;
        width: 100%;
        padding: 8px;
        font-size: 16px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function login(){
		var formdata = $('#loginForm').serialize();
		$.ajax({ 
			url:'/member/login',
			data:formdata,
			method:"post",
			cache:false, 
			dataType:'json', 
			success:function(res){
				if(res.login==true){
					alert("로그인 성공");
					location.href="/member/";
				}else{	
					alert("등록된 아이디가 없거나 비밀번호가 잘못되었습니다");
					location.href="/member/login";
				}
			},
			error:function(err){ 
				alert(err);
			}
		});
		return false;
	}
</script>
</head>
<body>
<main>
	<h3>로그인</h3>
	<form id="loginForm" action="member/login" method="post" onsubmit="return login()">
		<div><label for="memberID">
			 아이디 : </label><input type="text" id="memberID" name="memberID" >
		</div>
		<div><label for="memberPwd">
			 비밀번호 : </label><input type="password" id="memberPwd" name="memberPwd">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
		<div>
			<a href="/member/findid">아이디찾기</a>
			<a href="/member/findpwd">비밀번호찾기</a>
			<a href="/member/join">회원가입</a>
		</div>
	</form>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>