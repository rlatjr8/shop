<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 상세보기</title>
<style type="text/css">
	main {width:fit-content; margin:0.5em auto; }
	main>h3 { text-align: center;}
	table {border:1px solid black; border-spacing:0;
		border-collapse:collapse; }
	th,td {padding:0.5em 0.5em;border-bottom:1px solid black;}
	th { text-align:right; padding-right:0.5em; background-color:#ddd;}
	td { text-align:left; padding-left:0.2em; }
	td#title {border-bottom:1px solid black; }
	td#contents>div { width:25em; height:8em; overflow:auto; 
		border:1px dashed black; padding:0.2em;}
	nav { text-align: center; }
	nav a {text-decoration: none;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delBoard(num) {
	if(!confirm('현재 글을 삭제하시겠어요?')) return;
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
</script>
</head>
<body>
<main>
	<h3>게시글 상세보기</h3>
	<table>
		<tr><th>글번호</th><td colspan="5">${b.num}</td></tr>
		<tr><th>제 목</th><td colspan="5" id="title">${b.title}</td></tr>
		<tr><th>작성자</th><td>${b.author}</td>
			<th>작성일</th><td>${b.wdate}</td>
			<th>읽 음</th><td>${b.hit}</td>
		</tr>
		<tr><th>내 용</th><td colspan="5" id="contents">
			<div>${b.contents}</div>
			</td>
		</tr>
	</table>
	<p>
	<nav>
		[<a href="/mb2/board/add">추가</a>]
		[<a href="/mb2/board/edit/${b.num}">수정</a>]
		[<a href="javascript:delBoard();">삭제</a>]
		[<a href="/mb2/board/list/page/1">목록</a>]
	</nav>
</main>
</body>
</html>