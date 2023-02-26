<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "freeboard.FreeboardDAO" %>

<% request.setCharacterEncoding("utf-8"); %>
<%
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="article" class="freeboard.FreeboardVO">
		<jsp:setProperty name="article" property ="*" />
	</jsp:useBean>
<%	
	FreeboardDAO bdao = FreeboardDAO.getInstance();
	bdao.updateFreeboard(article);
	

	response.sendRedirect("freeboard.jsp?pageNum="+pageNum);
	
%>
		<script type = "text/javascript">
			alert("작성한 글이 수정완료되었습니다!");
			
		</script>

</body>
</html>