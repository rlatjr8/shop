<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>도서정보</title>
<style type="text/css">
	main { width:fit-content; margin:0.5em auto;}
 	main > h3 {width:fit-content; margin:1em auto; text-align: center; border-bottom:3px double black;}
 	table	{border-spacing:0; border-collapse: collapse; padding:1em; border:1px solid black;}
 	th	{background-color: #eeeeee; width:4em; text-align:right; padding:0.3em 1em;}
 	td  {padding-left:1em;}
 	img {width:200px; height:400px;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function add_cart(itemno) {
    var qty = $('#qty').val();
    var serdata = { itemno: itemno, qty: qty };
    if (!confirm("정말로 장바구니에 담을까요?")) return;

    $.ajax({
        url: '/cart1/add',
        method: 'post',
        data: serdata,
        cache: false,
        dataType: 'json',
        success: function (res) {
            alert(res.added ? '장바구니에 담았습니다' : '로그인 후 사용 가능합니다');
            if(res.added) {location.href = '/cart1/list';}
            else{location.href='/book/login';}
        },
        error: function (xhr, status, err) {
            alert(status + "/" + err);
        }
    });
    return false;
}

function show_cart(){
	location.href='/cart/list';
}
function show_index(){
	location.href='/book/'
}
</script>
</head>
<body>
<main>
	<h3>도서정보 보기</h3>	
	<div>
		<label>책번호</label>
		<span>${book.itemno}</span>
	</div>
	<div>
		<label>책이름</label>
		<span>${book.item}</span>
	</div>
	<div>
		<label>가격</label>
		<span>${book.price}</span>
	</div>
	<p>
	<nav>	
		수량 <input type= "number" id="qty" value ="1" min="1" max="50">
		<button type="button" onclick="add_cart(${book.itemno});">장바구니에 담기</button>
		<button type="button" onclick="show_cart();">장바구니 보기</button>
		<button type="button" onclick="show_index();">쇼핑 계속하기</button>
	</nav>
	
</main>
</body>
</html>