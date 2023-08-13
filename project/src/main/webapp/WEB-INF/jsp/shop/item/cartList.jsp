<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>장바구니 보기</title>
<style type="text/css">
	main {width:fit-content; margin:0.5em auto; }
	main > h3 {width:fit-content; margin:0.5em auto; border-bottom:3px double black;}
	table {border-spacing:0; border-collapse:collapse; border:1px solid black;}
	th { background-color:#eeeeee; border-bottom:3px double black;}
	th,td {  padding:0.2em 1em; border-right:1px solid black; text-align: center;}
	td { border-bottom:1px dashed black;}
	nav { text-align:center;}
	a { text-decoration: none;}
	.qty {width:3em;}
	 main > h2 { position: absolute;top: 0; left: 0; margin: 0; padding: 10px; background-color: black; box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}
	 #aa {color:white;}
	 .user-info { position: absolute; top: 0; right: 0; }
	
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function modifyQty(cartNum) {
	 var qty = $('#qty'+cartNum).val();
	$.ajax({
		url:'/cart/update',
		method:'post',
		cache:false,
		dataType:'json',
		data: {
			cartNum: cartNum,
	            qty: qty
	       	  },
		success:function(res){
			alert(res.modified ? '수정 성공':'수정 실패');
		},
		error:function(xhr,status,err){
			error('에러:' + status+"/"+err);
		}
	});
}

function removeItem() {	
	if(!confirm('선택된 상품을 장바구니에서 제거하시겠어요?')) return false;
	
	var selectedItems = $("input[name=cartNum]:checked");
    if (selectedItems.length == 0) {
        alert("삭제할 상품을 선택해주세요");
        return;
    }
    var cartnums = [];
    selectedItems.each(function() {
        cartnums.push($(this).val()); // 선택한 각 상품의 cartnum을 배열에 추가
    });
	var  formdata = $('#deleteForm').serialize();
	
	$.ajax({
		url:'/cart/delete',
		method:'Post',
		data:JSON.stringify(cartnums),
		cache:false,
		contentType: 'application/json',
		dataType:'json',
		success:function(res){
			alert(res.deleted ? '삭제 성공':'삭제 실패');
			location.href="/cart/list";

		},
		error:function(xhr,status,err){
			alert('에러:'+status+"/"+err);
		}
	});
	
	return false;
}

function clearCart() {
	if(!confirm('정말로 장바구니를 비울까요?')) return;
	$.ajax({
		url:'/cart/clear',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.cleared ? '장바구니를 비웠습니다':'비우기 실패');
			location.href='/cart/list';
		},
		error:function(xhr,status,err){
			alert('에러:'+status + '/' + err);
		}
	});
	
}
function add_Order(){ //결제
	if(!confirm("결제 하시겠습니까?")) return;
	
	var selectedItems = $("input[name=cartNum]:checked");
    if (selectedItems.length == 0) {
        alert("결제할 상품을 선택해주세요");
        return;
    }

    var cartnums = []; // 선택한 상품들의 cartnum을 담을 배열

    selectedItems.each(function() {
        cartnums.push($(this).val()); // 선택한 각 상품의 cartnum을 배열에 추가
    });

	$.ajax(
		{
			url:"/order/add",
			method:'post', 
			contentType: 'application/json', // 요청의 Content-Type을 application/json으로 설정
			data:JSON.stringify(cartnums),
			success:function(res){
				alert(res.ordered ? '결제 완료' : '결제 실패');
				location.href="/order/list";
			},
			error:function(xhr, status
					, err){
				alert(status + "/" + err);
			}
		}		
	);
}
function checkAll() {
    if($("#cboxAll").is(':checked')) {
        $("input[name=cartNum]").prop("checked", true);
    } else {
        $("input[name=cartNum]").prop("checked", false);
    }
}
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
</script>
</head>
<body>
<main>
	<h2><a id="aa" href="/member/">SHOP</a></h2>
	<h3>${userid}님의 장바구니</h3>
	<c:if test="${userid == null}">
	<div class="user-info">
	<div>
		<a href="/member/login">로그인</a>
		<a href="/member/join">회원가입</a>
		<a href="/member/findid">아이디찾기</a>
		<a href="/member/findpwd">비밀번호찾기</a>
	</div>
	</div>
	</c:if>
	
	<form id="deleteForm" method="Post" action="/cart/delete" onsubmit="return removeItem();">
	<table>
	<label>전체선택<input type="checkbox" id="cboxAll" name="cboxAll" onclick="checkAll();"></label>
	<tr><th>상품</th><th>상품명</th><th>가격</th><th>수량</th>
		<th><button type="submit" >삭제</button></th></tr>
		
	<c:forEach var="c" items="${list}">
	<tr><td>${c.goods}</td>
	<td>${c.goods}</td><td>${c.price}</td>
		<td>
			<input type="number" class="qty" id="qty${c.cartNum}" value="${c.qty}" min="1" max="50">
			<button type="button" onclick="modifyQty(${c.cartNum});">수정</button>
		</td>
		
		<td><input type="checkbox" name="cartNum" value="${c.cartNum}"></td>
	</tr>	
	</c:forEach>
	
	</table>
	</form>
	<p>
	<nav>
	<c:if test="${userid != null}">
	<div class="user-info">
	<div>
		ID: ${userid}
		<button type="button" onclick="javascript:logout();">로그아웃</button>
		<button type="button" onclick="javascript:mypage();">마이페이지</button>
	</div>
	</div>
		[<a href="javascript:add_Order();">결제</a>]
		[<a href="javascript:clearCart();">장바구니 비우기</a>]
	</c:if>
	</nav>
	<jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>