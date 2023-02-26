<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>
<%@ page import="java.util.List" %>

<%
	int count = 0; //총글수	
	int dessert = 2;
	
	List<ProductVO> alist = null;
	product.ProductDAO pdao = product.ProductDAO.getInstance();

	count = pdao.getCategoryCount(dessert);

	//------------------ 페이지 처리
	int pageSize = 8;
	int number = 0; //현재 페이지의 시작 번호
	String pageNum = null;
	
	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);   //1			 //2
	int startRow = (currentPage - 1)* pageSize + 1;//(1-1)*10+1=1, (2-1)*10+1=11 
	int endRow = currentPage * pageSize;		   //1*10=10,      2*20=20
	
	//number = count - (currentPage - 1) * pageSize; //12-(1-1)*10=12, 12-(2-1)*10=2
	//------------------
	
	String sword = request.getParameter("sword");
	   if (sword==null || sword.equals("")) {
	      count = pdao.getArticleCount();   
	      if(count > 0) {
	         alist = pdao.getArticles(dessert, startRow, pageSize);
	      }
	   } else {
	      count = pdao.getArticleCount("%"+sword+"%",2);   
	      if(count > 0) {
	         alist = pdao.getArticles(startRow, pageSize, "%"+sword+"%",2);
	      }else{
%>
		<script>
			alert("검색결과가 없습니다!");
			history.go(-1);
		</script>
<%
	   }
	 }

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 소개</title>
<link href="../css/product.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<script>
function search_input() {
    if (!document.search_form.sword.value) {
        alert("검색어를 입력하세요");    
        document.search_form.sword.value.focus();
        return;
    }    
    document.search_form.submit();
}
</script>
<div class="con">
	<div class="text">
		<p>OUR COFFEE</p>
		<h1>제품 소개 > 메뉴</h1>
		<div class="txt_box">
		    <ul class="menu">
		        <li class="menu-item"><a href="productlist.jsp" class="menu-link" >All</a></li>
		        <li class="menu-item"><a href="coffeelist.jsp" class="menu-link">음료</a></li>
		        <li class="menu-item"><a href="dessertlist.jsp" class="menu-link" style="background-color:#000040; color:white;">디저트</a></li>
		    </ul>
		</div> 
	</div>
</div>

<div class="search_box">
<form name="search_form" method="get" action="dessertlist.jsp">
  <input type="search" name="sword" placeholder="검색할 내용을 입력하세요." />
  <a href="#" class="search"><span onclick="search_input()"><i class="fa-sharp fa-solid fa-magnifying-glass"></i></span></a>
</form>
</div>


<div class="container" style="height:750px;">
	

<%


if(alist != null){
for(int i=0; i<alist.size(); i++) {
		ProductVO article = alist.get(i);

%>  
	
  	<article class="at_list">  
     	<div class="view_box">
			<div class="view_box_block">	
			   <a href="procontent.jsp?pnum=<%=article.getPnum()%>&pageNum=<%=currentPage%>&coffee=<%=article.getPid()%>">
			      <img class="img_list" src="../img/<%=article.getPimage()%>" /></a>
			</div>
			<div class="info">
				<br>
				<p><a href="procontent.jsp?pnum=<%=article.getPnum()%>&pageNum=<%=currentPage%>"><%=article.getPtitle()%></a></p>
				<br>
				
			</div>
		</div>
  	</article>
 
<% 	} }  %>
	<br>
	<div class="page">
<%
//------------------페이지 번호 목록
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize==0 ? 0 : 1); //12/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1;
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1;
		}
		
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock - 1; //1+10-1=10
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10) {
%>
			<a href="productlist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%			
		}
		
		for(int i=startPage; i<=endPage; i++) {
%>
			<a href="productlist.jsp?pageNum=<%=i%>"><%= i %></a>
<%			
		}
		
		if(endPage < pageCount) {
%>
			<a href="productlist.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%			
		}		
	}
//------------------
%>
</div>
</div>	
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>