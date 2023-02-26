<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%

	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	product.ProductDAO pdao = product.ProductDAO.getInstance();
	ProductVO article = pdao.getArticle(pnum);
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 소개</title>
<script type="text/javascript">
	function addToCart() {
		if (confirm("찜을 하시겠습니까?")) {
			document.addForm.submit();
		} else {		
			document.addForm.reset();
		}
	}
</script>
<link href="../css/product.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
  <div class="container" style="margin-top:120px;">

  	<article class="at_content">  
     	<div class="view_context">
			<div class="view_img">
			    <img class="img_content" src="../img/<%=article.getPimage()%>"/>
			    <br>
			   
			    <a href="#"><span id="btn" onclick="document.location.href='productlist.jsp?pageNum=<%=pageNum%>'">목록</span></a>
			     
			      																			
				
			</div>
		
			<div class="view_info">
				<h2><%=article.getPtitle()%></h2>
				<br>
					
				<ul class="info_list">          
            		<li><span><strong>가 격</strong></span><%=article.getPrice()%>원</li>
            		<li><span><strong>칼 로 리 </strong></span><%=article.getCalory()%>kcal</li>
            		<li><span><strong>당 류</strong></span><%=article.getSugar()%>g</li>
            		<li><span><strong>카페인</strong></span><%=article.getCaffeine()%>mg</li>
                </ul>
                <hr>
				<%=article.getPcontent().replace("\r\n", "<br>")%> 
					
				              
			</div>
		</div>
			
  	</article>
  </div>
  <div class="page"></div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>