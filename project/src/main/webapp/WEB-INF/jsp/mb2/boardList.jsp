<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 목록보기</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto; }
	main > h3 {text-align: center;}
	nav {border:1px solid black; padding:0.3em; width:100%; text-align: center;}
	nav#nav1 { border:none;}
	nav#pagination > a {margin:0.3em 0.5em; color:blue; text-decoration: none; }
	span#pageNum {color:red;}
	table { border:1px solid black; border-spacing: 0; border-collapse: collapse;}
	th{border-bottom:2px double black; background-color:#ffd;}
	th,td {text-align: center; padding:0.3em 1em; border-right:1px solid black;}
	td {border-bottom: 1px dashed black; }
	div#search {width:fit-content; text-align: center;}
	a { text-decoration: none; }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
</script>
</head>
<body>
<main>
	<h3>게시글 목록</h3>
	<table>
	<tr><th>글번호</th><th>제 목</th><th>작성자</th><th>작성일</th><th>읽음</th><th>첨부</th></tr>
	<c:forEach var="b" items="${pageInfo.list}">
		<tr>
			<td>${b.num}</td>
			<td>
				<a href="/mb2/board/get/${b.num}">${b.title}</a>
			</td>
			<td>${b.author}</td>
			<td>${b.wdate}</td>
			<td>${b.hit}</td>
			<td>
				<c:if test="${b.fname!=null}">
					있음
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
	<p>
	<div id="search">
		<form id="searchForm" action="/mb2/board/search" method="post" >
			<label>검색 카테고리</label>
			<select name="category">
				<option value="title">제 목</option>
				<option value="author">작성자</option>
				<option value="contents">내 용</option>
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label>검색어</label> 
			<input type="text" name="keyword">
			<button type="submit">검색</button>
		</form>
	</div>
	<p>
		<nav id="nav1">[<a href="/mb2/board/add">글 추가</a>]</nav>
	<p>
	<nav id="pagination">
		<c:forEach var="pn" items="${pageInfo.navigatepageNums}">
			<c:choose>
		  		<c:when test="${pn==pageInfo.pageNum}">
		  			<span id="pageNum">${pn}</span>
		  		</c:when>
		  		<c:otherwise>
		  		    <a href="/mb2/board/list/page/${pn}">${pn}</a>
		  		</c:otherwise>
	    	</c:choose>
		</c:forEach>
	</nav>
</main>
</body>
</html>