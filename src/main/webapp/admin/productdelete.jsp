<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>
<%@ page import="java.io.File" %>     

<%
    request.setCharacterEncoding("utf-8");
    %>

<%
	int pnum = Integer.parseInt(request.getParameter("pnum"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		ProductDAO pdao = ProductDAO.getInstance();
		ProductVO product = pdao.getArticle(pnum);		
		pdao.deleteProduct(pnum);	
		
		//저장되어 있는 파일 삭제
		new File("C://WS-JSPMySQL/ProjectJSP/src/main/webapp/img/" + product.getPimage()).delete(); 

		response.sendRedirect("productlist.jsp?pageNum=" + pageNum);
	}
%>