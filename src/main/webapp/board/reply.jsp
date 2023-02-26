<%@ page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="article" class="freeboard.FreeboardVO" scope="session"/>
<%
		  String pageNum = request.getParameter("pageNum");
		  String writer = article.getWriter();
		  String subject = article.getSubject();
		  String content = article.getContent(); 
%>
<html>
<head>
<title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br><br>
 <table width="600" cellpadding="3">
  <tr>
   <td bgcolor="#CCCC00" height="21" align="center">답변하기</td>
  </tr>
</table>
<form method="post" action="replyPro.jsp" >
<table width="600" cellpadding="7">
 <tr>
  <td>
   <table>
    <tr>
     <td width="20%"><%=writer %></td>
     <td width="80%">
	  <input name="name" size="30" maxlength="20"></td>
    </tr>
    <tr>
     <td>제 목</td>
     <td>
	  <input name="subject" size="50" value="답글 : <%=subject%>" maxlength="50"></td> 
    </tr>
	<tr>
     <td>내 용</td>
     <td>
	  <textarea name="content" rows="12" cols="50">
      	<%=content %>
      	========답변 글을 쓰세요.=======
      	</textarea>
      </td>
    </tr>
    <tr>
     <td>비밀 번호</td> 
     <td>
	  <input type="password" name="pass" size="15" maxlength="15"></td> 
    </tr>
    <tr>
     <td colspan="2" height="5"><hr/></td>
    </tr>
	<tr> 
     <td colspan="2">
	  <input type="submit" value="답변등록" >
      <input type="reset" value="다시쓰기">
      <input type="button" value="뒤로" onClick="history.back()"></td>
    </tr> 
   </table>
  </td>
 </tr>
</table>
 <input type="hidden" name="pageNum" value="<%=pageNum%>">
</form> 
</div>
</body>
</html>