<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="fnq.FnqDAO" %>
<%@ page import="fnq.FnqVO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ 작성하기</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.board_form.question.value)
      {
          alert("질문을 입력하세요!");
          document.board_form.question.focus();
          return;
      }
      if (!document.board_form.answer.value)
      {
          alert("답변을 입력하세요!");    
          document.board_form.answer.focus();
          return;
      }
      document.board_form.submit();
   }
</script>
</head>
<body>
<% 

String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {	//페이지처리
	int pageSize = 20;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------

	List<FnqVO> aList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	FnqDAO fdao = FnqDAO.getInstance();
	count = fdao.getArticleCount();
	
	if (count > 0) {
		aList = fdao.getArticles(startRow, pageSize);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4
%>

<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<h2 style="margin-top:190px; margin-left:200px;">FAQ 글쓰기</h2>
  <div id="board_box">
  <form  name="board_form" method="post" action="writePro.jsp">
   	 <ul id="board_form">
		<li>
			<span class="col1">&nbsp;&nbsp;작성자</span>
			<span class="col2"><%=managerId %></span>
		</li>		
   		<li>
   			<span class="col1">&nbsp;&nbsp;제&nbsp;&nbsp;목</span>
   			<span class="col2"><input name="question" type="text"></span>
   		</li>	    	
   		<li id="text_area">	
   			<span class="col1">&nbsp;&nbsp;답&nbsp;&nbsp;변</span>
   			<span class="col2">
   				<textarea name="answer"></textarea>
   			</span>
   		</li>
    </ul>
   	<ul class="buttons">
		<li><button type="button" onclick="check_input()">완료</button></li>
		<li><button type="button" onclick="location.href='./fnqlist.jsp'">목록</button></li>
	</ul>
  </form>
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
<% } %>
</body>
</html>