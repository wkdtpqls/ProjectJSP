<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>    

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
	if(id==null || id.equals("")) {
		response.sendRedirect("../board/freeboard.jsp");	
	} else {
%>
	<jsp:useBean id="article" class="freeboard.FreeboardVO">
		<jsp:setProperty name="article" property="*" />
	</jsp:useBean>
<%
	FreeboardDAO fbdao = FreeboardDAO.getInstance();
	fbdao.insertFreeboard(article);
	
	}
%>	
<script type="text/javascript">
	alert("정상적으로 글이 작성되었습니다.");
	location.href="freeboard.jsp";
</script>
</body>
</html>