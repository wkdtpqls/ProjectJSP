<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="fnq.FnqDAO" %>    

<% request.setCharacterEncoding("utf-8");%>

<% 
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	int num = Integer.parseInt(request.getParameter("num"));

	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("./main.jsp");	
	} else {
		FnqDAO fdao = FnqDAO.getInstance();
		fdao.deleteFnq(num);					
		response.sendRedirect("./fnqlist.jsp?pageNum=" + pageNum);	
	}
%>	
