<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberVO" %>
<%

	String id = (String) session.getAttribute("id"); //아이디
	
	MemberDAO mdao = MemberDAO.getInstance();
	MemberVO article = mdao.getArticleUpdate(id);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link href="../css/member.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<div id="main_content">
   <div id="join_box">
      <form  name="member_form" method="post" action="updatePro.jsp" >
	  	<h2>회원 정보 수정하기</h2>
  		  <div class="form id">
		     <div class="col1">아이디</div>
		     <div class="col2" ><%=id %></div>  
			<input type="hidden" name="id" value="<%= article.getId() %>"> 
		     <div class="col3"><a href="#"></a></div>                 
    	  </div>
    	  
    	  <div class="clear"></div>
    	  <div class="form">
          	<div class="col1">이름</div>
      		<div class="col2" ><%=article.getName() %></div>                 
    	  </div>
    	  
    	  <div class="clear"></div>
    	  <div class="form">
          	<div class="col1">변경할 이름</div>
      		<div class="col2"><input type="text" name="name"></div>                 
    	  </div>
    	  
    	   <div class="clear"></div>
     	  <div class="form">
      		<div class="col1">비밀번호</div>
      		<div class="col2"><input type="password" name="passwd" value="<%=article.getPasswd() %>"></div> 
      		                
    	  </div>
    	  
    	  <div class="clear"></div>
     	  <div class="form">
      		<div class="col1">비밀번호 확인</div>
      		<div class="col2"><input type="password" name="passwd_confirm" placeholder="비밀번호를 입력하세요."></div> 
      		                
    	  </div>
    	  
    	  <div class="clear"></div>
    	  <div class="bottom_line"> </div>
    	  <div class="buttons">
           	<span ><input class="btn" type="submit" value="수정하기"></span>
			<span><input  class="btn" type="reset" value="취소하기" ></span>
			<span ><input class="btn" type="button" value="돌아가기" onclick="window.location='../main/main.jsp'" ></span>
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