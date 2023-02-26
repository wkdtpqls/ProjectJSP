<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="fnq.FnqDAO" %>
<%@ page import="fnq.FnqVO" %>
<%@ page import="java.util.List" %>
<%
String managerId = (String) session.getAttribute("managerId");
if(managerId==null || managerId.equals("")) {
	response.sendRedirect("main.jsp");	
} else {

	//페이지처리
	int pageSize = 10;
	String pageNum = null;

	pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);    // 1			/2 
	int startRow = (currentPage - 1) * pageSize + 1;//(1-1)*10+1=1	/(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10		/(2*10)=20
	//-----------------

	List<FnqVO> articleList = null;
	int count = 0; //총 글수
	int number = 0; //현재 페이지의 시작 번호

	FnqDAO fdao = FnqDAO.getInstance();
	count = fdao.getArticleCount();
	
	if (count > 0) {
		articleList = fdao.getArticles(startRow, pageSize);
	}
	
	number = count - (currentPage - 1) * pageSize; //14-(1-1)*10=14 / 14-(2-1)*10=4

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ리스트</title>
<link href="./common.css" rel="stylesheet" type="text/css">
<link href="./admin.css" rel="stylesheet" type="text/css">
</head>
<script>
  function check(num) {
	  var ret = confirm("삭제하시겠습니까??");
	  if(ret == true) { 
		  document.location.href="deletePro.jsp?num=" + num +"&pageNum="+<%=currentPage%>;
      } else {
    	  return;
      }      
   }
  function content(num) {
	  document.location.href="fcontent.jsp?num=" + num + "&pageNum="+<%=currentPage%>;     
   }
</script>
<body>
<header>
  <jsp:include page="./header.jsp" flush="false"/>
</header>
<section>
<h2>관리자 페이지 > FAQ 관리</h2>

  <div>
  <ul id="fnq_list">
	<li>
		<span class="col1"><b>번호</b></span>
		<span class="col2"><b>제 목</b></span>
		<span class="col3"><b>수정</b></span>
		<span class="col4"><b>삭제</b></span>
		</li>

<%
for(int i=0; i<articleList.size(); i++) {
  		FnqVO article = articleList.get(i);
%> 
	<li>
	<span class="col1"><%=number--%></span>
		<span class="col2"  name="question" ><a href="fcontent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getQuestion()%></a>	</span>
		<span class="col3"  name="answer" ><button onclick="location.href='./updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">수정</button></span>
		<span class="col4"  name="answer" ><button type="button" name="num" onclick="check(<%=article.getNum()%>)">삭제</button></span>
	
	</li>
<% 	} %>  
  </ul>	
  <br>
  <div class="page">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count%pageSize == 0 ? 0 : 1); // 14/10+1=2
		int startPage = 1;
		if(currentPage%10 != 0) {
			startPage = (int)(currentPage/10) * 10 + 1; // (14/10)*10+1=11 / (2/10)*10+1=1
		} else {
			startPage = ((int)(currentPage/10)-1) * 10 + 1; // (10/10-1)*10+1=1 / (20/10-1)*10+1=11
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1; // 1+10-1=10 / 11+10-1=20
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10 ) { %>
			<a href="fnqlist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
<%		}
		
		for(int i=startPage; i<=endPage; i++) { %>
			<a href="fnqist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		
		if(endPage < pageCount ) { %>
			<a href="fnqlist.jsp?pageNum=<%=startPage+10%>">[다음]</a>
<%		}
	}
%>
  </div>
 <%} %>
       <button onclick="location.href='./writeForm.jsp'">글쓰기</button>
 </div>
</section>
</body>
</html>