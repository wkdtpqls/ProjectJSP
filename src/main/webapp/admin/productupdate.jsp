<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	//input의 date 타입은 'yyyy-MM-dd' 유형만 value 지정이 가능함.
	
	ProductDAO pdao = ProductDAO.getInstance();
	ProductVO article = pdao.getArticle(pnum);
	
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
<link href="./common.css" rel="stylesheet" type="text/css">
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
        alert("카페인를 입력하세요!");    
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
  <h2>관리자 페이지 > 제품 관리 > 제품 수정</h2>
  <div id="bookform_box">
  <form  name="book_form" method="post" enctype="multipart/form-data" action="productupdatePro.jsp">
  	<input type="hidden" name="pnum" value="<%=pnum%>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
   	 <ul id="book_form">
		<li>
			<span class="col1">&nbsp;&nbsp;분류선택</span>
			<span class="col2">
				<select name="pid">
					<!-- <option value="100">컴퓨터</option> -->
           			<option value="1" 
           				<%if(article.getPid() == 1) { %> selected <%}%>
           				>음료</option>
           			<option value="2" 
           				<%if(article.getPid() == 2) { %> selected <%}%>
           				>디저트</option>
           			<option value="3" 
           				<%if(article.getPid() == 3) { %> selected <%}%>
           				>기타</option>
       			</select>		
			</span>
		</li>		
		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="ptitle" type="text" value="<%=article.getPtitle()%>"></span>
   		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;가 격</span>
			<span class="col2"><input name="price" type="text" value="<%=article.getPrice()%>"></span>
		</li>
		<li>
			<span class="col1">&nbsp;&nbsp;칼 로 리</span>
			<span class="col2"><input name="calory" type="text" value="<%=article.getCalory()%>"></span>
		</li>	
		<li>
			<span class="col1">&nbsp;&nbsp;당 류</span>
			<span class="col2"><input name="sugar" type="text" value="<%=article.getSugar()%>"></span>
		</li>	
		<li>
			<span class="col1">&nbsp;&nbsp;카 페 인</span>
			<span class="col2"><input name="caffeine" type="text" value="<%=article.getCaffeine()%>"></span>
		</li>    	
   		<li id="text_area">	
   			<span class="col1" >&nbsp;&nbsp;내&nbsp;&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="pcontent"> <%=article.getPcontent()%></textarea>
   			</span>
   		</li>
   		<li>
		     <span class="col1">&nbsp;&nbsp;제품 이미지</span>
		     <span class="col2"><input type="file" name="pimage" value="<%=article.getPimage()%>"></span>
		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">수 정</button></li>
		<li><button type="button" onclick="location.href='productlist.jsp?pageNum=<%=pageNum%>'">목 록</button></li>
	</ul>
  </form>
  </div>
</section>
</body>
</html>
<%} %>