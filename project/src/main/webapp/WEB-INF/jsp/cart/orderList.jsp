<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>주문내역</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        padding: 20px;
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #cccccc;
        padding: 8px;
        text-align: left;
    }

    th {
        background-color: #f0f0f0;
    }
    td{
    	background-color: #ffffff;
    }

    button {
    	display: block;
    	margin: 0 auto;
        padding: 10px 20px;
        background-color: #4CAF50;
        margin-top:10px;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
<body>
<h2>"${userid}" 님의 결제내역</h2>
	<table>
		<th>주문번호</th><th>품명</th><th>가격</th><th>수량</th><th>구매일</th></tr>
		<c:forEach var="a" items="${list}">
			<tr>
				<td>${a.anum}</td>
				<td>${a.item}</td>
				<c:set var="price" value="${a.price}"/>
				<td><fmt:formatNumber value="${price}" type="number"/>원</td>
				<td>${a.qty}</td>
				<td>${a.adate}</td>
			</tr>
		</c:forEach>
	</table>
		<button type="button" onclick="location.href='/book/'">쇼핑 계속하기</button>
</body>
</html>