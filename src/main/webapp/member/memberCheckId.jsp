<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="member.MemberDAO" %> 

<% request.setCharacterEncoding("utf-8");%>

<%
	String id = request.getParameter("id");
	
	MemberDAO mdao = MemberDAO.getInstance();
	int check = mdao.idCheck(id);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
*{
	list-style:none;
	line-height:25px;
}
h3 {
   padding-left: 10px;
}
#close {
   margin:20px 0 0 100px;
   cursor:pointer;
}
</style>
</head>
<body>
<h3>아이디 중복체크</h3>
<p>
<%	
if(id == "") {
%>
	<li>아이디를 입력해 주세요!</li>
<%	
} else {
	if(check == 1) {
%>
	<li><%=id %>는 이미 존재하는 아이디 입니다.</li>
	<li>다른 아이디를 사용해 주세요!</li>
<%
	} else {
%>
	<li>"<%=id %>" 아이디는 사용 가능합니다.</li>
<%		
	}
}
%>
</p>
<div id="close">
   <img src="../img/close.png" onclick="javascript:self.close()">
</div>
</body>
</html>