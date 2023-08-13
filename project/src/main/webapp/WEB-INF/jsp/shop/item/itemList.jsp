<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>상의</title>
<style type="text/css">

    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background-color: #fafafa;
        margin: 0;
        padding: 0;
    }

    main {
        
        margin: 0.5em auto;
        padding: 1em;
        background-color: white;
        border: 1px solid #ddd;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        position: relative;
        margin-left: 15%;
    }

    main h2 {
        position: absolute;
        top: 0;
        left: 0;
        margin: 0;
        padding: 10px;
    }

    main h3 {
        text-align: center;
        margin: 0 0 1em;
    }

    a {
        text-decoration: none;
        color: black;
        font-weight: bold;
    }

  

    a#aa {
        color: black;
    }

    .product-container {
        display: flex;
        flex-wrap: wrap;
    }

    .product {
        width: 200px;
        border: 1px solid #ddd;
        padding: 0.5em;
        margin: 0.5em;
        text-align: center;
        background-color: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }

    .product img {
        width: 100%;
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

    @media screen and (max-width: 600px) {
        .product {
            width: 100%;
        }
    }
    .user-info { position: absolute; top: 0; right: 0;}
    a#lo{color:blue; font-weight:normal;}
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
	location.href='/cart/list'
}
function order(){
	location.href='/order/allList';
}
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>${category}</h3>
	<c:if test="${userid == null}">
	<div class="user-info">
	<div>
		<a id="lo" href="/member/login">로그인</a>
		<a id="lo" href="/member/join">회원가입</a>
	</div>
	</div>
	</c:if>
	<c:if test="${userid != null && userid != 'admin'}">
	<div class="user-info">
	<div>
		ID: ${userid}
		<button type="button" onclick="javascript:logout();">로그아웃</button>
		<button type="button" onclick="javascript:mypage();">마이페이지</button>
		<button type="button" onclick="javascript:cart();">🛒</button>
	</div>
	</div>
	</c:if>
	<div class="product-container">
		<c:forEach var="i" items="${pageInfo.list}">
		  <div class="product">
		  	<a href="/item/detail/${i.itemNum}"><img src="${pageContext.request.contextPath}/items/${i.inames}"></a>
		  	<h4 class="product-name">${i.goods}</h4>
		  	<p class="product-price">${i.price}원</p>
		  	<div><label>구매횟수</label>${i.purchaseCnt}</div>
			<div><label>장바구니에담긴횟수</label>${i.cartCnt}</div>
		 </div>
		</c:forEach>
    </div>
    <nav id="pagination">
		<c:forEach var="pn" items="${pageInfo.navigatepageNums}">
			<c:choose>
		  		<c:when test="${pn==pageInfo.pageNum}">
		  			<span id="pageNum">[${pn}]</span>
		  		</c:when>
		  		<c:otherwise>
		  		    <a href="/item/list/${pn}?category=${category}">${pn}</a>
		  		</c:otherwise>
	    	</c:choose>
		</c:forEach>
	</nav>
		<c:if test="${userid != null && userid == 'admin'}">
		<div class="user-info">
		<div>
			ID: ${userid}
			<button type="button" onclick="javascript:logout();">로그아웃</button>
			<button type="button" onclick="javascript:mypage();">마이페이지</button>
			<button type="button" onclick="javascript:order();">결제리스트</button>
		</div>
		</div>
		<div><a href="/item/add">아이템추가</a></div>
		</c:if>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>
