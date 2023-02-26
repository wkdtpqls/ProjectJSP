<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="product.ProductDAO" %>  
<%@ page import="product.LikeyDAO" %>    
<%@ page import="product.ProductVO" %> 
<% request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	String id = (String) session.getAttribute("id");
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	


%>
	<jsp:useBean id="article" class="product.LikeyVO">
		<jsp:setProperty name="article" property="*" />
	</jsp:useBean>
<%
	ProductDAO pdao = ProductDAO.getInstance();
	LikeyDAO ldao = LikeyDAO.getInstance();
	ldao.insertLikey(id);
	
	
%>	
<script type="text/javascript">
	alert("정상적으로 글이 작성되었습니다.");
	location.href="freeboard.jsp";
</script>
</body>
</html>