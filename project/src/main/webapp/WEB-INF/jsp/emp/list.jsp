<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>사원정보 목록</title>
<style type="text/css">
main{width:fit-content; margin:0.5em auto; }
main>h3 {text-align:center; }
table { border:1px solid black; border-spacing: 0; border-collapse: collapse;}
th { background-color: #eee; padding:0.2em 1em; border-bottom: 3px double black;}
th, td { border-right: 1px solid black;}
td {padding:0.2em 1em; border-bottom: 1px dashed black;}
a {text-decoration: none;}
</style>
</head>
<body>
<main>
	<h3>사원정보 목록</h3>
	<table>
		<tr><th>사번</th><th>이름</th><th>입사</th><th>급여</th></tr>
		<c:forEach var="e" items="${list}">
			<tr>
				<td>${e.empno}</td>
				<td>
					<a href="/emp/find/${e.empno}">${e.ename}</a>
				</td>
				<td><fmt:formatDate value="${e.hiredate}" pattern="yyyy-mm-dd" type="date"/></td>
				<td>${e.sal}</td>
			</tr>
		</c:forEach>
	</table>
		<div><a href="/emp/">처음으로</a></div>
</main>
</body>
</html>