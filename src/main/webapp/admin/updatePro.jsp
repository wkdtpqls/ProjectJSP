<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "fnq.FnqDAO" %>

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
	<jsp:useBean id="article" class="fnq.FnqVO">
		<jsp:setProperty name="article" property ="*" />
	</jsp:useBean>
<%	
	FnqDAO fdao = FnqDAO.getInstance();
	fdao.updateFnq(article);
	
		response.sendRedirect("fnqlist.jsp?pageNum="+pageNum);
	
%>
		<script type = "text/javascript">
			alert("작성한 글이 수정완료되었습니다!");
			
		</script>

</body>
</html>