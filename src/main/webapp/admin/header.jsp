<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 모드</title>
<link href="./common.css" rel="stylesheet" type="text/css">
</head>
<body>
  <div id="top">
	<h3><a href="main.jsp">OUR COFFEE &nbsp;관리자 모드</a></h3>
	<ul id="topmenu">
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
		if (managerId==null || managerId.equals("")) { 
			response.sendRedirect("main.jsp");	
		} else {
%>
			<li><%=managerId %> 님 안녕하세요</li>
			<li> | </li>
			<li><a href="logoutPro.jsp">로그 아웃</a></li>
	     		
<%
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
	</ul>
  </div> 
  <nav id="menubar">
    <ul>
      <li><a href="./main.jsp">HOME</a></li>
      <li><a href="freeboardlist.jsp">Q&A 관리</a></li>
      <li><a href="fnqlist.jsp">FAQ 관리</a></li>
      <li><a href="productlist.jsp">제품 관리</a></li>
      <li><a href="memberlist.jsp">회원 관리</a></li>
    </ul>
  </nav>
</body>
</html>