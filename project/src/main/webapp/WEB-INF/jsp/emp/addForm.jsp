<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사원정보 추가 폼</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function addEmp() {
	var serdata = $('#addForm').serialize();
	$.ajax({
		url:'/emp/add',
		method:'post',
		data:serdata,
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.added ? '추가성공':'추가실패');
			location.href='/emp/list';
			if(res.cause){
				alert(res.cause);
				location.href="/user/login";
			}
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
	<h3>사원정보 추가</h3>
	<form id="addForm" action="/emp/add" method="post"
								onsubmit="return addEmp();">
		<div><label for="empno">사번</label>
			<input type="text" id="empno" name="empno" >
		</div>
		<div><label for="ename">이름</label>
			<input type="text" id="ename" name="ename" >
		</div>
		<div><label for="hiredate">입사일</label>
			<input type="text" id="hiredate" name="hiredate" >
		</div>
		<div><label for="sal">급여</label>
			<input type="text" id="sal" name="sal" >
		</div>
		<div>
			<button type="reset" >취소</button>
			<button type="submit" >저장</button>
		</div>
	</form>
</main>
</body>
</html>