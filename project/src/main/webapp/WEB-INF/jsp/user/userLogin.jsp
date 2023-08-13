<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인 폼</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function login() {
	
	var formdata = $('#loginForm').serialize();
	//alert(formdata);
	$.ajax({
		url:'/user/login',
		method:'post',
		data:formdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.login ? '로그인 성공':'실패');
			if(res.login) location.href='/board';
		},
		error:function(xhr, status, err){
			alert('에러');
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h3>로그인</h3>
	<form id="loginForm" action="/user/login" method="post"
										onsubmit="return login();">
		<div><label for="uid"></label>
			<input type="text" id="uid" name="uid">
		</div>
		<div><label for="pwd"></label>
			<input type="password" id="pwd" name="pwd">
		</div>
		<div>
			<button type="reset" >취소</button>
			<button type="submit" >로그인</button>
		</div>
	</form>
</main>
</body>
</html>