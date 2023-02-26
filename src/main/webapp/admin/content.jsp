<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="freeboard.FreeboardDAO" %>
<%@ page import="freeboard.FreeboardVO" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.ReplyVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	String managerId = "";
	managerId = (String) session.getAttribute("managerId");
	
	int num = Integer.parseInt(request.getParameter("num"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");	
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
	FreeboardDAO fbdao = FreeboardDAO.getInstance();
	FreeboardVO article = fbdao.getArticle(num);
	
	List<ReplyVO> replyList = null;
	int count = 0; //총 댓글수
	
	ReplyDAO rdao = ReplyDAO.getInstance();
	count = rdao.getArticleCount(num);
	
	if (count > 0) {
		replyList = rdao.getArticles(num);
	}
%>

<html>
<head>
<title>공지사항</title>
<link href="./board.css" rel="stylesheet" type="text/css">
<link href="./common.css" rel="stylesheet" type="text/css">
<script>
  function check_input() {
      if (!document.reply_form.reply.value)
      {
          alert("댓글을 입력하세요!");    
          document.reply_form.reply.focus();
          return;
      }
      document.reply_form.submit();
   }

   function del(rnum, pageNum) {	  
		  if (confirm("삭제하시겠습니까?")) {
			  location.href="replyDelete.jsp?rnum=" + rnum + "&pageNum=" + pageNum;
		  } else {
			  location.href="list.jsp?pageNum=" + pageNum;
		  }
	   }
</script>
</head>
<body>
<header>
  <jsp:include page="./header.jsp" flush="false"/>
</header>
<section>
<div class="txt_box" >
	  <h3>1 : 1 문의게시판 > 내용보기</h3>
</div>
<div class="container">
  <div id="board_box">
    <ul id="view_content">
		<li>
			<span class="col1"><b>제 목 :</b> <%=article.getSubject()%> </span>
			<span class="col2"> <%=article.getWriter()%> | <%=sdf.format(article.getReg_date())%> </span>
		</li>
		<li>
			<%=article.getContent().replace("\r\n", "<br><br>")%>
		</li>		
    </ul>
<%
if (count > 0) {
%>
	  <ul id="reply_content">
<%
for(int i=0; i<replyList.size(); i++) {
  		ReplyVO reply = replyList.get(i);
%>	
		<li>
			<span class="col1"><%=reply.getRwriter()%></span>
			<span class="col2"><%=reply.getReply().replace("\r\n", "<br>")%></span>
			<span class="col3"><%=sdf2.format(reply.getRreg_date())%></span>

			<span class="col4"><button onclick="del(<%=reply.getRnum()%>,<%=pageNum%>)">삭제</button></span>
 	
		</li>	
<%    } %>
    </ul>
<%  } %>
  <form  name="reply_form" method="post" action="replyPro.jsp">
    <input type="hidden" name="rwriter" value="<%=managerId%>">
  	<input type="hidden" name="ref" value="<%=article.getNum() %>">
    <input type="hidden" name="pageNum" value="<%=pageNum %>">
	<ul id="reply_form">
<%

		if (managerId==null || managerId.equals("")) { 
			response.sendRedirect("main.jsp");	
		} else {
%>

	   	<li>	
   			<span class="col1"><%=managerId%></span>
   			<span class="col2"><textarea name="reply"></textarea></span>
   			<span class="col3"><button onclick="check_input()">입력</button></span>
   		</li>

<%} %>

    </ul>
  </form>
  </div>
  <div class="button" style="width:1100px;text-align:right;margin-top:10px;"><button onclick="location.href='./freeboardlist.jsp?pageNum=<%=pageNum%>'" >목록</button></div>
  </div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>      
</body>
</html>