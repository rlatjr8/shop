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
          text-align: center; 
    }
    td{
    	background-color: #ffffff;
    	  text-align: center; 
    }

    button {
    	display: block;
    	margin: 0 auto;
        padding: 10px 20px;
        background-color: black;
        margin-top:10px;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    button:hover {
        background-color: black;
    }
    a{color:black; text-decoration: none; display: inline-block; width: 100%; text-align: center; }
</style>
</head>
<body>
<body>
<c:if test="${not empty userid and userid ne 'admin'}">
<h3>"${userid}" 님의 결제내역</h3>
	<table>
		<th>주문번호</th><th>상품명</th><th>가격</th><th>수량</th><th>구매일</th><th>리뷰 쓰기</th></tr>
		<c:set var="totalPrice" value="0" />
		<c:forEach var="o" items="${list}">
			<tr>
				<td>${o.orderNum}</td>
				<td>${o.goods}</td>
				<c:set var="price" value="${o.price}"/>
				<td><fmt:formatNumber value="${price}" type="number"/>원</td>
				<td>${o.qty}</td>
				<td><fmt:formatDate value="${o.orderdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td><a href='/review/add?userid=${o.user}&goods=${o.goods}'>🖋</a></td>
			</tr>
			 <c:set var="totalPrice" value="${totalPrice + o.price}" />
		</c:forEach>
		<tr>
            <td colspan="2">주문총액</td>
            <td><fmt:formatNumber value="${totalPrice}" type="number" />원</td>
            <td colspan="2"></td>
        </tr>
	</table>
		<button type="button" onclick="location.href='/member/'">메인으로</button>
</c:if>
<c:if test="${userid eq 'admin'}">
<h3>전체 결제내역</h3>
	<table>
		<tr><th>주문번호</th><th>상품명</th><th>가격</th><th>수량</th><th>구매일</th><th>구매자</th></tr>
		 <c:set var="totalPrice" value="0" />
		<c:forEach var="o" items="${olist}">
			<tr>
				<td>${o.orderNum}</td>
				<td>${o.goods}</td>
				<c:set var="price" value="${o.price}"/>
				<td><fmt:formatNumber value="${price}" type="number"/>원</td>
				<td>${o.qty}</td>
				<td><fmt:formatDate value="${o.orderdate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				<td>${o.user}</td>
			</tr>
			<c:set var="totalPrice" value="${totalPrice + o.price}" />
		</c:forEach>
		<tr>
            <td colspan="2">주문총액</td>
            <td><fmt:formatNumber value="${totalPrice}" type="number" />원</td>
            <td colspan="3"></td>
        </tr>
	</table>
		<button type="button" onclick="location.href='/member/'">메인으로</button>
</c:if>

</body>
</html>