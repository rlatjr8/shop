<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>쇼핑몰</title>
<style type="text/css">
   main > h2 {
      position: absolute;
      top: 0;
      left: 0;
      margin: 0;
      padding: 10px;
      background-color: black;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      z-index: 100;
   }
   #aa {
      color: white;
   }
   a {
      text-decoration: none;
      color: blue;
   }
   # {
  position: absolute;
  top: 3em;
  right: 0;
}

@media screen and (max-width: 767px) {
  .main {
    margin-top: 7em;
  }

  #sidebar {
    position: static;
    margin-top: 2em;
  }
}
   main {
      position: relative;
      max-width: 1200px;
      margin: 3em auto;
   }
   main h3 {
      text-align: center;
   }
   .user-info {
      position: absolute;
      top: 0;
      right: 0;
   }
   .links-container {
  text-align: center;
  margin-top: 3em;
}
   .links-container a {
      margin: 0 1em;
   }
   .product-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      margin-top: 1em;
   }
   .product {
      width: 150px;
      border: 1px solid #ddd;
      padding: 0.5em;
      margin: 0.5em;
      text-align: center;
      background-color: white;
      box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      flex: 0 0 calc(20% - 1em);
      max-height: 250px;
   }
   .product img {
      max-width: 100%;
      height: auto;
   }
   .product-name {
      font-size: 1.1em;
      margin: 0.5em 0;
   }
   .product-price {
      font-size: 0.9em;
      color: blue;
   }
   body {
  padding-top: 3em;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function logout() {
	if(!confirm('로그아웃할까요?')) return;
	$.ajax({
		url : '/member/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 성공':'로그아웃 실패');
			if(res.logout) location.href='/member/';
		},
		error:function(xhr,status,err){
			alert('에러:' + err);
		}
	});
}

function mypage(){
	location.href='/member/detail/${userid}';
}
function cart(){
location.href='/cart/list';
}
function order(){
location.href='/order/allList';
}
function check(){
location.href='/member/attendance';
}
</script>
</head>
<body>
<main>
<h2><a id="aa" href="/member/">SHOP</a></h2>
<div class="links-container">
   <a href="/question/list">FAQ</a>
   <a href="/notice/list">NOTICE</a>
   <a href="/review/list/1">REVIEW</a>
</div>
<h3>베스트 상품</h3>

<c:if test="${empty userid}">
   <div class="user-info">
      <div>
         <a href="/member/login">로그인</a>
         <a href="/member/join">회원가입</a>
         <a href="/member/findid">아이디찾기</a>
         <a href="/member/findpwd">비밀번호찾기</a>
      </div>
   </div>
</c:if>

<c:if test="${not empty userid and userid ne 'admin'}">
   <div class="user-info">
      <div>
         ID: ${userid}
         <button type="button" onclick="javascript:logout();">로그아웃</button>
         <button type="button" onclick="javascript:mypage();">마이페이지</button>
         <button type="button" onclick="javascript:check();">출석체크</button>
         <button type="button" onclick="javascript:cart();">🛒</button>
      </div>
   </div>
</c:if>

<c:if test="${userid eq 'admin'}">
   <div class="user-info">
      <div>
         ID: ${userid}
         <button type="button" onclick="javascript:logout();">로그아웃</button>
         <button type="button" onclick="javascript:mypage();">마이페이지</button>
         <button type="button" onclick="javascript:order();">결제리스트</button>
      </div>
   </div>
</c:if>

<div class="product-container">
   <c:forEach var="item" items="${topItems}">
      <div class="product">
         <a href="/item/detail/${item.itemNum}"><img src="${pageContext.request.contextPath}/items/${item.inames}"></a>
         <br/>
         <h4 class="product-name">${item.goods}</h4>
         <p class="product-price">${item.price}원</p>
         <br/>
         <div><label>구매횟수</label> ${item.purchaseCnt}</div>
      </div>
   </c:forEach>
</div>
<jsp:include page="../sidebar.jsp" />

</main>
</body>
</html>