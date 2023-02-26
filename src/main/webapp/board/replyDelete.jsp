<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO" %>    

<% request.setCharacterEncoding("utf-8");%>
<% 
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int rnum = Integer.parseInt(request.getParameter("rnum"));

	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		ReplyDAO fdao = ReplyDAO.getInstance();
		fdao.deleteReply(rnum);					
		response.sendRedirect("freeboard.jsp?pageNum=" + pageNum);	
	}
%>	
	<script>
		alert("댓글이 삭제되었습니다.");
	</script>