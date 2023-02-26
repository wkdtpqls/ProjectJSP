<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function check_input()
{
   if (!document.member_form.id.value) {
       alert("아이디를 입력하세요!");    
       document.member_form.id.focus();
       return false;
   }

   if (!document.member_form.passwd.value) {
       alert("비밀번호를 입력하세요!");    
       document.member_form.passwd.focus();
       return false;
   }

   if (!document.member_form.pass_confirm.value) {
       alert("비밀번호확인을 입력하세요!");    
       document.member_form.pass_confirm.focus();
       return;
   }

   if (!document.member_form.name.value) {
       alert("이름을 입력하세요!");    
       document.member_form.name.focus();
       return;
   }

   if (document.member_form.passwd.value != 
         document.member_form.pass_confirm.value) {
       alert("비밀번호가 일치하지 않습니다.\n다시 입력해 주세요!");
       document.member_form.passwd.focus();
       document.member_form.passwd.select();
       return;
   }

   document.member_form.submit();
}

function reset_form() {
   document.member_form.id.value = "";  
   document.member_form.passwd.value = "";
   document.member_form.pass_confirm.value = "";
   document.member_form.name.value = "";
   document.member_form.id.focus();
   return;
}

function check_id() {
	     window.open("memberCheckId.jsp?id=" + document.member_form.id.value,
	         		 "IDcheck",
	          		 "left=700,top=300,width=350,height=200,scrollbars=no,resizable=yes");
}   

</script>
<link href="../css/member.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<div id="main_content">
   <div id="join_box">
      <form  name="member_form" method="post" action="memberPro.jsp" >
	  	<div class="txt">
		 	  	 <h1>회원가입</h1>
		 	  	 <p>아우어커피에 오신것을 환영합니다</p>
	 	  </div>
  		  <div class="form id">
		     <div class="col1">아이디</div>
		     <div class="col2"><input type="text" name="id" placeholder="아이디를 입력하세요"></div>  
		     <div class="col3"><a href="#"><span onclick="check_id()" class="btn">중복확인</span></a></div>                 
    	  </div>
    	  <div class="clear"></div>
     	  <div class="form">
      		<div class="col1">비밀번호</div>
      		<div class="col2"><input type="password" name="passwd" placeholder="비밀번호를 입력하세요"></div>                 
    	  </div>
    	  <div class="clear"></div>
    	  <div class="form">
      		<div class="col1">비밀번호 확인</div>
      		<div class="col2"><input type="password" name="pass_confirm" placeholder="비밀번호를 입력하세요"></div>                 
    	  </div>
    	  <div class="clear"></div>
    	  <div class="form">
          	<div class="col1">이름</div>
      		<div class="col2"><input type="text" name="name" placeholder="이름을 입력하세요"></div>                 
    	  </div>
    	  <div class="clear"></div>
    	  
    	  <div class="buttons">
           	 <a href="#"><span onclick="check_input()" class="btn">저장하기</span></a>&nbsp;
           	<!--<input type="submit" value="가입하기" onclick="check_input()" style="cursor:pointer">&nbsp; -->
           <a href="#"><span onclick="reset_form()" class="btn">취소하기</span></a>
      	  </div>
     	</form>
  	</div> <!-- join_box -->
  </div> <!-- main_content -->
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>