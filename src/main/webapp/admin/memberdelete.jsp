<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %> 
<%@ page import="member.MemberVO" %>
<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="java.util.List" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	int mpageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
			FreeboardDAO fdao = FreeboardDAO.getInstance();
			fdao.deleteMemberFreeboard(id);
					
			MemberDAO mDAO = MemberDAO.getInstance();
			mDAO.deleteMember(id);
			
			out.println("<script>alert('삭제되었습니다.');</script>");
			out.println("<script>document.location.href='memberlist.jsp?pageNum=" + mpageNum + "';</script>");
			
			}
		
		
%>
