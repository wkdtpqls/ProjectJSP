<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberVO" %>

<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="article" class="member.MemberVO">
		<jsp:setProperty name="article" property ="*" />
	</jsp:useBean>

<% 
	MemberDAO mdao = MemberDAO.getInstance();
	mdao.insertMember(article);
	
	
%>
<script type="text/javascript">
	alert("회원가입에 성공하였습니다! \n로그인 페이지로 이동합니다.");
	location.href="loginForm.jsp";
</script>

</body>
</html>