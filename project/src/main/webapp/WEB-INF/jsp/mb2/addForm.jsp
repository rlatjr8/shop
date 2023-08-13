<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 추가 폼</title>
<style type="text/css">
	main {width:fit-content; margin:0.5em auto; }
	main>h3 { text-align: center;}
	table {border:1px solid black; border-spacing:0;border-collapse:collapse;}
	textarea { width:20em; height:8em;}
	th,td {padding:0.5em 1em; }
	input[name=title] {width:20em;}
	tr:last-child > td { text-align: center; }
	nav { text-align:center; }
	a {text-decoration: none;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function saveBoard() {
	var formdata = new FormData($('#addForm')[0]);
	$.ajax({
		url:'/mb2/board/add',
		method:'post',
		enctype:'multipart/form-data',
		processData:false,
		contentType:false,
		timeout:3600,
		cache:false,
		data:formdata,
		dataType:'json',
		success:function(res) {
			alert(res.added ? '글 저장 성공':'저장 실패');
			if(res.added) location.href='/mb2/board/get/'+res.num;
		},
		error:function(xhr,status,err) {
			alert('에러:' + err);
		}
	});
	return false;
}
</script>
</head>
<body>
<main>
	<h3>글 추가</h3>
	<form id="addForm" onsubmit="return saveBoard();">
	<table>
		<tr><th>글 제목</th>
			<td><input type="text" name="title"></td>
		</tr>
		<tr><th>글 내용</th>
			<td><textarea name="contents"></textarea></td>
		</tr>
		<tr><th>첨부</th>
			<td><input type="file" name="files" multiple></td>
		</tr>
		<tr>
			<td colspan="2">
				<button type="reset">취소</button>
				<button type="submit">저장</button>
			</td>
		</tr>
	</table>
	</form>
	<p>
	<nav>
		[<a href="/mb2/board/list/page/1">목록보기</a>]
	</nav>
</main>
</body>
</html>