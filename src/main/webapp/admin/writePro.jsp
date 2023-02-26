<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="fnq.FnqDAO" %>  
<%@ page import="fnq.FnqVO" %>
<% request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {	
%>
	<jsp:useBean id="article" class="fnq.FnqVO">
		<jsp:setProperty name="article" property="*" />
	</jsp:useBean>
<%
	FnqDAO fdao = FnqDAO.getInstance();
	fdao.insertFnq(article);
	
	}
%>	
<script type="text/javascript">
	alert("정상적으로 글이 작성되었습니다.");
	location.href="fnqlist.jsp";
</script>
</body>
</html>