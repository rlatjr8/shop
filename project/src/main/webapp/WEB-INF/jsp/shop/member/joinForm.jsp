<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입 폼</title>
<style type="text/css">
   main {width:fit-content; margin:0.5em auto; }
   main > h3 { text-align: center;}
   form { border:1px solid black; padding:2em; }
   form>div:last-child { margin-top:0.5em; text-align:center; }
   div { margin-bottom:0.5em;}
   form>div>label {display:inline-block; width:4em; text-align: left; padding-right:1.5em;}
   form>div:last-child { margin-top:1em; }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function join() {
   var formdata = $('#joinForm').serialize();
   $.ajax({
      url:'/member/join',
      method:'post',
      data:formdata,
      cache:false,
      dataType:'json',
      success:function(res){
         alert(res.saved ? '회원정보추가 성공':'추가 실패');
         if(res.saved) {
            location.href='/main/';
         }
      },
      error : function(xhr,status,err){
         alert('에러:' + status + ', ' + err);
      }
   });
   return false;
}
</script>
</head>
<body>
<main>
   <h3>회원 가입</h2>
   <form id="joinForm" action="member/join" method="post"
                        onsubmit="return join();">
      <div>
         <label for="memberID">아이디</label>
         <input type="text" name="memberID" id="memberID">
         </div>
         <div>
         <label for="memberPwd">암 호</label>
         <input type="password" name="memberPwd" id="memberPwd">
         </div>
         <div>
         <label for="memberName">이름</label>
         <input type="text" name="memberName" id="memberName">
         </div>
         <div><label for="memberBirth">생년월일</label>
			<input type="date" id="memberBirth" name="memberBirth" >
		 </div>
      <div>
         <fieldset>
         <legend>성별</legend>
         	남자<input type="radio" name="memberSex" checked="checked" value="남자">
            여자<input type="radio" name="memberSex" value="여자">
           <p>내국인<input type="radio" name="national" checked="checked" value="내국인">
            외국인<input type="radio" name="national" value="외국인">
          </fieldset>
         </div>
         <div>
            <fieldset>
            <legend>관심사</legend>
         	<div><input type="checkbox" name="interest" value="casual">
           	   <label>캐주얼</label></div>
            <div><input type="checkbox" name="interest" value="street">
               <label>스트릿</label></div>
            <div><input type="checkbox" name="interest" value="beauty">
               <label>뷰티</label></div>
            <div><input type="checkbox" name="interest" value="accessory">
               <label>악세사리</label></div>
            <div><input type="checkbox" name="interest" value="shoes">
               <label>신발</label></div>
            </fieldset>
         </div>
         <div>
         <label for="memberPhone">번호</label>
         <input type="text" name="memberPhone" id="memberPhone">
         </div>
         <div>
         <label for="memberEmail">이메일</label>
         <input type="text" name="memberEmail" id="memberEmail">
         </div>
         <div>
         <label for="memberAddress">주소</label>
         <input type="text" name="memberAddress" id="memberAddress">
         </div>
         <div>
            <button type="reset">취소</button>
            <button type="submit">저장</button>
         </div>
   </form>
   <jsp:include page="../sidebar.jsp" />
</main>
</body>
</html>