<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="freeboard.FreeboardDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<% 
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int num = Integer.parseInt(request.getParameter("num"));

	String id = (String) session.getAttribute("id");
	if(id==null || id.equals("")) {
		response.sendRedirect("../main/main.jsp");	
	} else {
		FreeboardDAO fdao = FreeboardDAO.getInstance();
		fdao.deleteFreeboard(num);					
		response.sendRedirect("./freeboard.jsp?pageNum=" + pageNum);	
	}
%>	
