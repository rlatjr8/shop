<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 목록</title>
<style type="text/css">
main{width:fit-content; margin:0.5em auto; }
main>h3 {text-align:center; }
table { border:1px solid black; border-spacing: 0; border-collapse: collapse;}
th { background-color: #eee; padding:0.2em 1em; border-bottom: 3px double black;}
th, td { border-right: 1px solid black;}
td {padding:0.2em 1em; border-bottom: 1px dashed black;}
a {text-decoration: none;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function hitCnt(num){
	$.ajax({
		url : '/board/find',
		method:'post',
		data:{"num":${b.num},
		cache : false,
		dataType:'json',
		success:function(res){
		 alert(res.hited);
		},
		error:function(xhr,status,err){
			alert('에러:'+status+'/'+err);
		}
	});
}

</script>
</head>
<body>
<main>
	<h3>게시글 목록</h3>
	<table>
		<tr><th>글번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th></tr>
		<c:forEach var="b" items="${list}">
			<tr>
				<td>${b.num}</td>
				<td>
					<a href="/board/find/${b.num}">${b.title}</a>
				</td>
				<td>${b.author}</td>
				<td>${b.wdate}</td>
				<td>${b.hit}</td>
			</tr>
		</c:forEach>
	</table>
		<div><a href="/board">처음으로</a></div>
		<div><a href="/board/add">글쓰기</a></div>
<p>
<form id="findForm" action="/board/find" method="post">
      <fieldset>
         <legend>검색</legend>
         <select name = "category">
            <option value="num">번호</option> 
            <option value="title">제목</option> 
            <option value="author">작성자</option> 
         </select>
         <input type="text" name="keyword">
         <button type="submit">검 색</button>
         
      </fieldset>
   </form>
</main>
</body>
</html>
