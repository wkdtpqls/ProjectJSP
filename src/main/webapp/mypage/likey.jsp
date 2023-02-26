<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.ProductVO" %>    
<%@ page import = "product.LikeyVO" %>
<%@ page import = "product.LikeyDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%


	product.ProductDAO pdao = product.ProductDAO.getInstance();


	int count = 0; // 총글수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List<LikeyVO> alist = null;
	LikeyDAO ldao = LikeyDAO.getInstance();

	String id = (String) session.getAttribute("id"); //아이디
	count = ldao.getArticleCount();
	//---------------------------- 페이지 처리
	int pageSize = 5;
	int number = 0; //현재 페이지의 시작 번호
	String pageNum =null; //현재 페이지 번호 
	 
	pageNum = request.getParameter("pageNum");
	if(pageNum == null){ //처음 접속하면 항상 1페이지
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum); 	//1 			//2
	int startRow = (currentPage-1) * pageSize + 1; 	//(1-1)*10+1=1	//(2-1)*10+1=11
	int endRow = currentPage * pageSize;			//1*10=10 		//2*10=20
	
	//number = count - (currentPage -1)* pageSize;	//12-(1-1)*10=12 //12-(2-1)*10=2	
	//----------------------------
	if (count > 0) {
		alist = ldao.getArticles(startRow, pageSize);
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/acfbc5814d.js" ></script>
<script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
</head>

<script>
function search_input() {
    if (!document.search_form.sword.value) {
        alert("검색어를 입력하세요");    
        document.search_form.sword.value.focus();
        return;
    }    
    document.search_form.submit();
}

function del(num, pageNum) {	  
	  if (confirm("삭제하시겠습니까?")) {
		  location.href="../board/deletePro.jsp?num=" + num + "&pageNum=" + pageNum;
	  } else {
		  location.href="../mypage/freeboard.jsp?pageNum=" + pageNum;
	  }
 }
</script>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>

<div class="con">
	<div class="text">
		<p>OUR COFFEE</p>
		<h1>마이페이지 > 북마크 내역</h1>
		<p>OUR COFFEE은 항상 여러분과의 즐거움을 위해 노력합니다. <br>궁금하신 사항은 언제든지 문의해주셔도 됩니다. 항상 고객님들의 입장에서 생각합니다</p>
	</div>
</div>
	
<div class="container">
<div class="search_box">
<form name="search_form" method="get" action="freeboard.jsp">
  <input type="search" name="sword" placeholder="검색할 내용을 입력하세요." />
  <a href="#" class="search"><span onclick="search_input()"><i class="fa-sharp fa-solid fa-magnifying-glass"></i></span></a>
</form>
</div>
 
  <div id="board_box">
  <ul id="board_list">
   <li>
      <span class="col1"><b>No</b></span>
      <span class="col2"><b>제 목</b></span>
      <span class="col4"><b>등록일</b></span>
      <span class="col5"><b>비고</b></span>
   </li>

<%	
	
		for(int i=0; i<alist.size();i++){
			LikeyVO article = alist.get(i);
%>
		<li>
      <span class="col1"><%=article.getNumber()%></span>  
      <span class="col2"><i class="fa-solid fa-lock-open"></i><a href="../board/content.jsp"><%=article.get%></a></span>
      <span class="col4"><%=sdf.format(article.getReg_date())%></span>
     <span class="col5"><button onclick="del(<%=article.getNum()%>,<%=pageNum%>)">삭제</button></span>
  	 </li>
<%		
		}  
%>
	</ul>   
  <br>
 </div>

 
</div>
  <div class="page">

<%
//---------------- 페이지 번호 목록
	if(count > 0){
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		int startPage=1;
		if(currentPage % 10 != 0){
			startPage = (int)(currentPage/10)*10+1;
			
		}else{
			startPage = ((int)(currentPage/10)-1)*10+1;
		}
		
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;
		if(endPage>pageCount){
			endPage = pageCount;
		}
		if(startPage>10){
%>
			<a href = "freeboard.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%			
		}
		
		for(int i=startPage; i<=endPage; i++){
%>
			<a href = "freeboard.jsp?pageNum=<%=i %>"><%=i %> </a>
<%			
		}
	if(endPage < pageCount){
%>
			<a href = "freeboard.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%			
		}
	}
//----------------
%>
</div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>

</body>
</html>