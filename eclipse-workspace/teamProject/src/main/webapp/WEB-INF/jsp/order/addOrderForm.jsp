<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>결제 페이지</title>
<style type="text/css">
	body {
		font-family: Arial, sans-serif;
		margin: 0;
		padding: 0;
		background-color: #f2f2f2;
	}
	
	main {
		width: 80%;
		margin: 0 auto;
		margin-top: 30px;
		background-color: #fff;
		padding: 20px;
		border: 1px solid #ccc;
		border-radius: 5px;
	}
	h2{ text-align:center;}
	textarea#etc_textarea.order__textarea { display: none; }
	ul.order__delivery__radio-wrap {
        list-style-type: none;  /* 목록 앞의 점 제거 */
        padding-left: 0;        /* 왼쪽 패딩 제거 */
    }
    button {
		padding: 10px 20px;
		background-color: #333;
		color: #fff;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		margin-right: 10px;
		
	}
	nav { text-align:center;}
	button:hover {
		background-color: #444;
	}
	.product-image img {
	    max-width: 200px; /* 원하는 최대 너비 */
	    max-height: 200px; /* 원하는 최대 높이 */
	    width: 200;
	    height: 200;
	}
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
window.onload = function() {
    var selectBox = document.querySelector('select#dlv_selectbox.order__select');
    var textarea = document.querySelector('textarea#etc_textarea.order__textarea');
    if (selectBox) {
        selectBox.addEventListener('change', function(event) {
            // "직접 입력" 옵션이 선택되면 텍스트 에어리어를 보이게 하고, 그렇지 않으면 숨깁니다.
            if (event.target.value === 'etc') {
                textarea.style.display = 'block';
            } else {
                textarea.style.display = 'none';
            }
        }, false);
    }
}
function add_Order(){ //결제
	if(!confirm("결제 하시겠습니까?")) return;

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

//주소 검색 후 우편번호 및 주소를 불러와주는 기능 
function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) {
        	
        	console.log(data);
        	
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var jibunAddr = data.jibunAddress; // 지번 주소 변수
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("member_addr").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("member_addr").value = jibunAddr;
            }
        }
    }).open();
}
</script>

</head>
<body>
<main>
<%@ include file="../menu.jsp" %>
<h2>ORDER PAGE</h2>
	
	<h3>배송정보</h3>
	<ul class ="order__list">
		<li>
			<span> 이름 / 연락처</span>
			<input type="text" value="${member.memberName} / ${member.memberPhone}">
		</li>
		
		<li>
		<div class="order__item__area">
		<ul class="order__delivery__radio-wrap" id="quickDeliveryList">
        <li>
        <span> 배송지 </span>
           <input type="radio" onclick="ChoiceQuickDeliveryAddress(2297309)" class="n-radio" id="delivery_choice_0" name="delivery_choice" value="" checked="">
           <label for="delivery_choice_0">(${memberID})님 배송지</label>
           
         
        </li>
        <li>
		
		<span> 주소 </span>
			<input type="text" value="${member.address}">
		</li>
         <li>
                <input type="radio" id="delivery_choice_1" name="delivery_choice">
                <label for= "delivery_choice_1">직접 입력: </label>
                <input type='text' id='new_address' disabled> <!-- 처음에는 비활성화 상태 -->
                <input id="post" name="post" type="text" placeholder="우편번호" readonly onclick="findAddr()">
        </li>
        </ul>
        </div>
        </li>
		
		<li>
		<span> 배송 요청사항</span>
		<div class="order__item__area order__item__area--column">
                    <div class="order__select-wrap">
                        <select class="order__select" name="dlv_selectbox" id="dlv_selectbox" onchange="showEtc(this.value);">
                                                        <option value="shippingNote" selected="selected">
                                배송 시 요청사항을 선택해주세요
                            </option>
                                                        <option value="부재 시 경비실에 맡겨주세요">
                                부재 시 경비실에 맡겨주세요
                            </option>
                                                        <option value="부재 시 택배함에 넣어주세요">
                                부재 시 택배함에 넣어주세요
                            </option>
                                                        <option value="부재 시 집 앞에 놔주세요">
                                부재 시 집 앞에 놔주세요
                            </option>
                                                        <option value="배송 전 연락 바랍니다">
                                배송 전 연락 바랍니다
                            </option>
                                                        <option value="파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요.">
                                파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요.
                            </option>
                                                        <option value="etc">
                                직접 입력
                            </option>
                         </select>
                        
                    </div>
                    <textarea class="order__textarea" name="etc_textarea" id="etc_textarea" style="" maxlength="50" onkeyup="return textarea_maxlength(this)" placeholder="최대 50자까지 입력 가능합니다."></textarea>
                </div>
		</li>
		
	
	</ul>
	<h3>상품정보</h3>
	<table>
	<tr>
		<th>상품</th><th>상품번호</th><th>상품명</th><th>가격</th><th>수량</th>
	
	</tr>
		<c:forEach var="c" items="${list}">
			<tr>
				<td class="product-image">
				 	<a href="/item/detail/${c.itemNum}">
					<img src="${pageContext.request.contextPath}/items/${c.fnames}"></a>
				</td>
				<td>${c.cartNum}</td>
				<td>${c.goods}</td>
				<td>${c.price}</td>
				<td>
				<input type="number" class="quantity" id="quantity${c.cartNum}" value="${c.quantity}" min="1" max="50">
				<button type="button" onclick="modifyQty(${c.cartNum});">수정</button>
				</td>
				<td><input type="checkbox" name="cartNum" value="${c.cartNum}"></td>
			</tr>
		</c:forEach>
	</table>
	
	<nav>
			<button type="button" onclick="javascript:add_Order();">결제</button>
	</nav>
</main>
</body>
</html>