<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>게시글 보기</title>
<style type="text/css">
	main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px; background-color: black; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
    #aa {color:white;}
    a { text-decoration: none; color:blue; }
	main { width:fit-content; margin:0.5em auto;}
	main > h3 {text-align:center; }
	label {width:3em; padding:0.2em 1em; text-align: right;font-weight: bolder; }
	
	nav { text-align: center; margin:0.5em;}
	nav > a {text-decoration: none;}
	textarea { width:23em; margin-top:0.5em;}
	.product {
        width: 400px;
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
    
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function add_cart(itemNum) {
    var qty = $('#qty').val();
    var serdata = { itemNum: itemNum, qty: qty};
    if (!confirm("정말로 장바구니에 담을까요?")) return;

    $.ajax({
        url: '/cart/add',
        method: 'post',
        data: serdata,
        cache: false,
        dataType: 'json',
        success: function (res) {
            alert(res.added ? '장바구니에 담았습니다' : '로그인 후 사용 가능합니다');
            if(res.added) {location.href = '/cart/list';}
            else{location.href='/member/login';}
        },
        error: function (xhr, status, err) {
            alert(status + "/" + err);
        }
    });
    return false;
}

</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>${item.goods}</h3>
	<div class="product">
	<c:forEach var="list" items="${item.itemattList}">
	<img src="<c:url value='/items/${list.itemattachName}' />">
	</c:forEach>
	<div><label>${item.goods}</label></div>
	<div><label>가격</label>${item.price}</div>
	<div><label>상품설명</label>${item.explain}</div>
	수량 <input type= "number" id="qty" value ="1" min="1" max="50">
	</div>
	<nav>
	[<a href="javascript:add_cart(${item.itemNum});">🛒장바구니담기</a>]

	
	
		
	<c:if test="${userid != null && userid == 'admin'}">
	
	<a href="/item/update/${itemNum}">수정</a>
	
	</c:if>	
	
	
	</nav>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>