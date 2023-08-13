<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 수정</title>
<style type="text/css">
	main {width:fit-content; margin:0.5em auto; }
	main>h3 { text-align: center;}
	table {border:1px solid black; border-spacing:0;
		border-collapse:collapse; }
	th,td {padding:0.5em 0.5em;border-bottom:1px solid black;}
	th { text-align:right; padding-right:0.5em; background-color:#ddd;}
	td { text-align:left; padding-left:0.2em; }
	td#title {border-bottom:1px solid black; }
	input[name=title] {width:25em; border:1px dashed black; background-color:#fdd;}
	textarea { width:25em; height:8em; overflow:auto; 
		border:1px dashed black; padding:0.2em;  background-color:#fdd;}
	nav { text-align: center; }
	nav a {text-decoration: none;}
	div#btn {padding:0.5em; text-align: center;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delBoard(num) {
	$.ajax({
		url:'/mb2/board/delete/${b.num}',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res) {
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href='/mb2/board/list/page/1';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function updateBoard() {
	var serdata = $('#editForm').serialize();
	$.ajax({
		url:'/mb2/board/update',
		method:'post',
		cache:false,
		data:serdata,
		dataType:'json',
		success:function(res){
			alert(res.updated ? '수정 성공':'수정 실패');
			if(res.updated) location.href='/mb2/board/get/${b.num}';
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
	<h3>게시글 수정</h3>
	<form id="editForm" onsubmit="return updateBoard();">
		<input type="hidden" name="num" value="${b.num}">
	<table>
		<tr><th>글번호</th><td colspan="5">${b.num}</td></tr>
		<tr><th>제 목</th><td colspan="5" id="title">
			<input type="text" name="title" value="${b.title}">
		</td></tr>
		<tr><th>작성자</th><td>${b.author}</td>
			<th>작성일</th><td>${b.wdate}</td>
			<th>읽 음</th><td>${b.hit}</td>
		</tr>
		<tr><th>내 용</th><td colspan="5" id="contents">
			<textarea name="contents">${b.contents}</textarea>
			</td>
		</tr>
	</table>
	<div id="btn">
		<button type="reset">취소</button>
		<button type="submit">적용</button>
	</div>
	</form>
	<p>
	<hr>
	<nav>
		[<a href="/mb2/board/list/page/1">목록</a>]
	</nav>
</main>
</body>
</html>