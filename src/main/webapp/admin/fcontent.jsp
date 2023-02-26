<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="fnq.FnqDAO" %>
<%@ page import="fnq.FnqVO" %>
<%@ page import="java.util.List" %>

<%
	String managerId = "";
	managerId = (String) session.getAttribute("managerId");
	
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	FnqDAO fdao = FnqDAO.getInstance();
	FnqVO article = fdao.getArticle(num);
	
%>

<html>
<head>
<title>FAQ내용보기</title>
<link href="./board.css" rel="stylesheet" type="text/css">
<script>
function del(num, pageNum) {	  
	  if (confirm("삭제하시겠습니까?")) {
		  location.href="deletePro.jsp?num=" + num + "&pageNum=" + pageNum;
	  } else {
		  location.href="fnqlist.jsp?pageNum=" + pageNum;
	  }
 }
</script>
<link href="./board.css" rel="stylesheet" type="text/css">
<link href="../css/common.css" rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <jsp:include page="./header.jsp" flush="false"/>
</header>
<section>
<div class="txt_box">
	  <h3>FAQ 관리 게시판 > 내용보기</h3>
</div>
<div class="container">
  <div id="board_box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>질 문 :</b> <%=article.getQuestion()%> </span>
			
		</li>
		<li>
			<b>답 변 :</b> <%=article.getAnswer()%>
		</li>		
    </ul>
  <ul class="buttons">
  	<li><button onclick="location.href='./updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">수정</button></li>
	<li><button onclick="del(<%=article.getNum()%>,<%=pageNum%>)">삭제</button></li>
	<li><button onclick="location.href='./fnqlist.jsp?pageNum=<%=pageNum%>'">목록</button></li>
  
  </ul>
  </div>
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>      
</body>
</html>