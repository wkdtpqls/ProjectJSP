<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./login.css" rel="stylesheet" type="text/css">
<script>
function check_input()
{
    if (!document.login_form.id.value)
    {
        alert("아이디를 입력하세요");    
        document.login_form.id.focus();
        return;
    }

    if (!document.login_form.passwd.value)
    {
        alert("비밀번호를 입력하세요");    
        document.login_form.passwd.focus();
        return;
    }
    
    document.login_form.submit();
}
</script>
</head>
<body>
   <div id="main_content">
 	  <div id="login_box">
     	  <form name="login_form" method="post" action="loginPro.jsp">	
	     	  <div class="txt">
			 	  	 <h1>로그인</h1>
			 	  	 <p>아우어커피 관리자 권한이 필요합니다</p>
		 	  </div>	 
     	  	 <div class="form id"><input type="text" name="id" placeholder="아이디" ></div>
    	  	 <div class="clear"></div>
     	     <div class="form"><input type="password" id="passwd" name="passwd" placeholder="비밀번호" ></div>
             <div id="login_btn">
              	<a href="#"><span onclick="check_input()">로그인</span></a>
             </div>		    	
      	  </form>
	</div> <!-- login_box -->
   </div> <!-- main_content -->
</body>
</html>