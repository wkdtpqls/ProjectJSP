<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {

	//페이지처리
	int pageSize = 20;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	

	List<ProductVO> aList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	ProductDAO pDAO = ProductDAO.getInstance();
	count = pDAO.getArticleCount();
	
	if (count > 0) {
		aList = pDAO.getArticles(startRow, pageSize);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 소개</title>
<link href="./common.css" rel="stylesheet" type="text/css">
<link href="./admin.css" rel="stylesheet" type="text/css">
<script>
  function check(pnum) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="productdelete.jsp?pnum=" + pnum + "&pageNum=<%=currentPage%>";
      } else {
    	  return;
      }      
   }
</script>
</head>
<body>
<header>
  <jsp:include page="header.jsp" flush="false"/>
</header>
<section>
  <h2>관리자 페이지 > 제품 관리</h2>
  <div id="book_box">
  <ul id="book_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>분류</b></span>
		<span class="col3"><b>제목</b></span>
		<span class="col4"><b>가격</b></span>
		<span class="col5"><b>칼로리</b></span>
		<span class="col6"><b>당류</b></span>
		<span class="col7"><b>카페인</b></span>
		<span class="col8"><b>이미지</b></span>
		<span class="col9"><b>수정</b></span>
		<span class="col10"><b>삭제</b></span>
	</li>

<%
for(int i=0; i<aList.size(); i++) {
  		ProductVO article = aList.get(i);
%> 
	<li>
		<span class="col1"><%=number--%></span>
		<span class="col2"><%=article.getPid()%></span>
		<span class="col3"><%=article.getPtitle()%></span>
		<span class="col4"><%=article.getPrice()%></span>
		<span class="col5"><%=article.getCalory()%></span>
		<span class="col6"><%=article.getSugar() %></span>
		<span class="col7"><%=article.getCaffeine()%></span>
		<span class="col8"><a href="filedownload.jsp?pimage=<%=article.getPimage()%>"><%=article.getPimage()%></a></span>
		<span class="col9"><button type="button" onclick="location.href='productupdate.jsp?pnum=<%=article.getPnum()%>&pageNum=<%=currentPage%>'">수정</button></span>
		<span class="col10"><button type="button" onclick="check(<%=article.getPnum()%>)">삭제</button></span>
	</li>
<% 	} %>  
  </ul>	
  <br>
  <div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 14/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10 ) { %>
			<a href="productlist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a href="productlist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a href="productlist.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%		}
	}
%>
  </div>

  <ul class="buttons">
  	<li>
		<button onclick="location.href='productinsert.jsp'">제품 등록</button>
	</li>
  </ul>
 
 </div>
</section>
</body>
</html>
<%} %>