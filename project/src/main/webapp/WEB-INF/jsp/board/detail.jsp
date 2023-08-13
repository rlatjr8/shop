<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 상세보기</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto;}
	main > h3 {text-align:center; }
	label {width:3em; padding:0.2em 1em; text-align: right;font-weight: bolder; }
	main > div {border-bottom:1px dashed black; padding:0.3em 1em;}
	nav { text-align: center; margin:0.5em;}
	nav > a {text-decoration: none;}
	textarea { width:23em; margin-top:0.5em;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function deleteIt() {
	if(!confirm('정말로 삭제하시겠어요?')) return;
	$.ajax({
		url:'/board/delete',
		method:'post',
		data:{"num":${board.num}},
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.deleted ? '삭제성공':'삭제실패');
			location.href='/board/list';
			if(res.cause){
				alert(res.cause);
				location.href='/user/login';
			}
		},
		error:function(xhr, status, err){
			alert('에러:' + status+'/'+err);
		}	
	});
	return false;
}

</script>
</head>
<body>
<main>
	<h3>게시글 상세보기</h3>
	<div><label>번호</label>${board.num}</div>
	<div><label>제목</label>${board.title}</div>
	<div><label>작성자</label>${board.author}</div>
	<div><label>작성일</label>${board.wdate}</div>
	<div><label>조회수</label>${board.hit}</div>
	<div><label>내용</label>
	<textarea rows="6" readonly>${board.contents}</textarea>
	</div>
	<nav>
		[<a href="/board/update/${board.num}">수정</a>]
		[<a href="javascript:deleteIt();">삭제</a>]
	
	
	</nav>
</main>
</body>
</html>