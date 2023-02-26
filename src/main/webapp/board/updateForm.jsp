<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "freeboard.FreeboardDAO" %>
<%@ page import = "freeboard.FreeboardVO" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	FreeboardDAO fdao = FreeboardDAO.getInstance();
	FreeboardVO article = fdao.getArticleUpdate(num);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="style.css">
<script type="text/javascript" src="script.js"></script>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<style>
	.txt_box{
		margin-top:200px;	
	}
	th { width:80pt;}
	td { width:300pt;}
</style>
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<h2 style="margin-top:190px; margin-left:250px;">1 : 1 문의게시판 > 수정하기</h2>
  <div id="board_box">
<form method="post" action="updatePro.jsp" name="board_form"  onsubmit="return writeSave()">
		 <ul id="board_form">
			<li>
				<span class="col1">&nbsp;&nbsp;작성자</span>
				
					<span class="col2" type="text" size="10" maxlength="20" name="writer" ><%= article.getWriter() %></span>
					<input type="hidden" name="num" value="<%= article.getNum() %>"> 
					<input type="hidden" name="pageNum" value="<%= pageNum %>"> 
					<!-- 글 내용보기에는 num의 정보가 없기 때문에 hidden으로 num 정보를 넘겨주어야 한다. -->
				
			</li>
			
			<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="subject" type="text" value="<%= article.getSubject() %>"></span>
   		</li>	    	
   		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;내&nbsp;&nbsp;용</span>
   			<span class="col2">
   				<textarea name="content"><%= article.getContent() %></textarea>
   			</span>
   		</li>
    </ul>
				<ul class="buttons">
					<li><input type="submit" value="수정하기" ></li>
					<li><input type="reset" value="다시 작성" ></li>
					<li><input type="button" value="목록보기" onclick="window.location='../board/freeboard.jsp?pageNum=<%=pageNum %>'" ></li>
				</ul>
  	</div>
</section>
</form>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>