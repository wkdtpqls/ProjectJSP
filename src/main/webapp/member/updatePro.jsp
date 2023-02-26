<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@ page import = "javax.naming.*" %>

<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberVO" %>
<% request.setCharacterEncoding("utf-8"); %>
<% String id = (String) session.getAttribute("id"); %>	
	<jsp:useBean id="article" class="member.MemberVO">
		<jsp:setProperty name="article" property ="*" />
	</jsp:useBean>
	
<%	
MemberDAO mdao = MemberDAO.getInstance();
int check = mdao.updateMember(id, article);

if(check == 1){
	//response.sendRedirect("memberupdateForm.jsp");
	out.println("<script>alert('회원정보가 수정완료 되었습니다.');</script>");
	out.println("<script>document.location.href='../main/main.jsp';</script>"); // 쿼리가 다 완료되면 페이지 이동
%>
	<script type = "text/javascript">
		alert("회원정보가 수정완료 되었습니다.");
	</script>
<%
}else{
%>
	<script type = "text/javascript">
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%		
}

%>
