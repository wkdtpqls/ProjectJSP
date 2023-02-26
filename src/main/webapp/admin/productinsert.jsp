<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 소개</title>
<link href=".common.css" rel="stylesheet" type="text/css">
<link href="./admin.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.book_form.pid.value)
      {
          alert("분류를 선택하세요!");
          document.book_form.pid.focus();
          return;
      }
      if (!document.book_form.ptitle.value)
      {
          alert("제목을 입력하세요!");    
          document.book_form.ptitle.focus();
          return;
      }
      if (!document.book_form.price.value)
      {
          alert("가격을 입력하세요!");    
          document.book_form.price.focus();
          return;
      }
      if (!document.book_form.calory.value)
      {
          alert("칼로리를 입력하세요!");    
          document.book_form.calory.focus();
          return;
      }
      if (!document.book_form.sugar.value)
      {
          alert("당류를 입력하세요!");    
          document.book_form.sugar.focus();
          return;
      }
      if (!document.book_form.caffeine.value)
      {
          alert("카페인을 입력하세요!");    
          document.book_form.caffeine.focus();
          return;
      }

      if (!document.book_form.pcontent.value)
      {
          alert("제품 내용을 입력하세요!");    
          document.book_form.pcontent.focus();
          return;
      }
      if (!document.book_form.pimage.value)
      {
          alert("제품 이미지를 입력하세요!");    
          document.book_form.pimage.focus();
          return;
      }
      document.book_form.submit();
   }
</script>
</head>
<body>
<header>
  <jsp:include page="header.jsp" flush="false"/>
</header>
<section>
  <h2>관리자 페이지 > 제품 관리 > 제품 등록</h2>
  <div id="bookform_box">
  <form  name="book_form" method="post" enctype="multipart/form-data" action="productinsertPro.jsp">
   	 <ul id="book_form">
		<li>
			<span class="col1">&nbsp;&nbsp;분류선택</span>
			<span class="col2">
				<select name="pid">
           			<option value="1">커피</option>
           			<option value="2">디저트</option>
           			<option value="3">기타</option>
       			</select>		
			</span>
		</li>		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="ptitle" type="text"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;가 격</span>
			<span class="col2"><input name="price" type="text"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;당 류</span>
			<span class="col2"><input name="sugar" type="text"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;칼 로 리</span>
			<span class="col2"><input name="calory" type="text"></span>
		</li>	
		<li>
			<span class="col1">&nbsp;&nbsp;카 페 인</span>
			<span class="col2"><input name="caffeine" type="text"></span>
		</li>   	
   		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;내&nbsp;&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="pcontent"></textarea>
   			</span>
   		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;제품 이미지</span>
		     <span class="col2"><input type="file" name="pimage"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">등 록</button></li>
		<li><button type="button" onclick="location.href='productlist.jsp'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>