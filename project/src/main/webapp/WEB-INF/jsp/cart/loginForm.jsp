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
    button[type="reset"] {
        background-color: #6c757d;
        margin-right: 10px;
    }
    button[type="submit"] {
        background-color: #28a745;
    }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function login(){
		var formdata = $('#loginForm').serialize();
		$.ajax({ 
			url:'/book/login',
			data:formdata,
			method:"post",
			cache:false, 
			dataType:'json', 
			success:function(res){
				if(res.login==true){
					alert("로그인 성공");
					location.href="/book/m";
				}else{	
					alert("로그인 실패");
					location.href="/book/login";
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
	<form id="loginForm" action="book/login" method="post" onsubmit="return login()">
		<div><label for="id">
			 아이디 : </label><input type="text" id="uid" name="uid" >
		</div>
		<div><label for="pwd">
			 비밀번호 : </label><input type="password" id="pwd" name="pwd">
		</div>
		<div>
			<button type="reset">취소</button>
			<button type="submit">로그인</button>
		</div>
	</form>
	
</main>
</body>
</html>