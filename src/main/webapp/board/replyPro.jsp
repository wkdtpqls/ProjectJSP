<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>  
<%@ page import="reply.ReplyDAO" %>
<% request.setCharacterEncoding("utf-8");%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("./main.jsp");	
} else {
%>
	<jsp:useBean id="reply" class="reply.ReplyVO">
		<jsp:setProperty name="reply" property="*" />
	</jsp:useBean>
<%
	ReplyDAO replyDAO = ReplyDAO.getInstance();
	replyDAO.insertReply(reply);
	
	response.sendRedirect("content.jsp?num=" + reply.getRef() + "&pageNum=" + pageNum);
	
	}
%>		
<script type="text/javascript">
	alert("정상적으로 글이 작성되었습니다.");

</script>
</body>
</html>