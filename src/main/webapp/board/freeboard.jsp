<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "freeboard.FreeboardDAO" %>
<%@ page import = "freeboard.FreeboardVO" %>
<%@ page import = "reply.ReplyVO" %>
<%@ page import = "reply.ReplyDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%
	int count = 0; // 총글수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	List<FreeboardVO> alist = null;
	FreeboardDAO fbdao = FreeboardDAO.getInstance();
	count = fbdao.getArticleCount();
	
	int replycount = 0; //총 댓글 수
	ReplyDAO rdao = ReplyDAO.getInstance();

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
	
	number = count - (currentPage -1)* pageSize;	//12-(1-1)*10=12 //12-(2-1)*10=2	
	//----------------------------

	String sword = request.getParameter("sword");
	   if (sword==null || sword.equals("")) {
	      count = fbdao.getArticleCount();   
	      if(count > 0) {
	         alist = fbdao.getArticles(startRow, pageSize);
	      }
	   } else {
	      count = fbdao.getArticleCount("%"+sword+"%");   
	      if(count > 0) {
	         alist = fbdao.getArticles(startRow, pageSize, "%"+sword+"%");
	      }else{
%>
	  		<script>
	  			alert("검색결과가 없습니다!");
	  			history.go(-1);
	  		</script>
<%	    	
	   }
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
</script>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>

<div class="con">
	<div class="text">
		<p>OUR COFFEE</p>
		<h1>공지사항</h1>
		<p>OUR COFFEE은 항상 여러분과의 즐거움을 위해 노력합니다. <br>궁금하신 사항은 언제든지 문의해주셔도 됩니다. 항상 고객님들의 입장에서 생각합니다</p>
	</div>
</div>
	<div class="txt_box">
        <ul class="menu">
            <li class="menu-item"><a href="./freeboard.jsp" class="menu-link" style="background-color:#000040; color:white;">Q & A</a></li>
            <li class="menu-item"><a href="./fnq.jsp" class="menu-link">자주하는 질문</a></li>
            
        </ul>
    </div> 
	
<div class="container" style="height:600px;">
	<select id="search_select" onchange="ChangeValue()">
		<option value="1" selected>제목</option>
		<option value="2">작성자</option>
	</select>
<script>
function ChangeValue(){
var value22 = document.getElementById('search_select');
int index = value22.options[value22.selectedIndex].value;
}
</script>
<div class="search_box">
<form name="search_form" method="get" action="freeboard.jsp">
  <input type="search" name="sword" placeholder="검색할 내용을 입력하세요." />
  <a href="#" class="search"><span onclick="search_input()"><i class="fa-sharp fa-solid fa-magnifying-glass"></i></span></a>
</form>
</div>
  <div id="board_box" style="height:400px;">
  <ul id="board_list">
   <li>
      <span class="col1"><b>No</b></span>
      <span class="col2"><b>제 목</b></span>
      <span class="col3"><b>작성자</b></span>
      <span class="col4"><b>등록일</b></span>
      <span class="col5"><b>조회</b></span>
   </li>

<%	
		if(alist != null){
		for(int i=0; i<alist.size();i++){
			FreeboardVO article = alist.get(i);
			replycount = rdao.getArticleCount(article.getNum());

%>
		<li>
      <span class="col1"><%=number--%></span>
      
<%   String id = (String) session.getAttribute("id");
   if (!(id==null) && id.equals(article.getWriter())) { %>
      <span class="col2"><i class="fa-sharp fa-solid fa-lock"></i><a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject()%></a>
		          <span class="replycount">
<%			if(replycount > 0) { %>
				 [답변완료]
<%				 
			}else{
%>				
				[미답변]				 
<% 			} %>    
     </span>
<%   } else { %>
      <span class="col2"><i class="fa-sharp fa-solid fa-lock"></i><a href="javascript:alert('권한이 없습니다!\n하단에 문의글을 작성해주세요')" onclick="location.href='./freeboard.jsp'">
      <%=article.getSubject()%></a>
      
      		         <span class="replycount">
<%			if(replycount > 0) { %>
				 [답변완료]
<%				 
			}else{
%>				
				[미답변]				 
<% 			} %>
      
      </span>
<%   } %>

         </span>
      </span>
      <span class="col3"><%=article.getWriter()%></span>
      <span class="col4"><%=sdf.format(article.getReg_date())%></span>
      <span class="col5"><%=article.getReadcount()%></span>
  	 </li>
<%		
		} } 
%>
	</ul>   

 </div>

  <div class="page">

<%
//---------------- 페이지 번호 목록
	if(count > 0){
		int pageCount = count/pageSize + (count%pageSize==0?0:1);
		int startPage=5;
		if(currentPage % 5 != 0){
			startPage = (int)(currentPage/5)*5+1;
			
		}else{
			startPage = ((int)(currentPage/5)-1)*5+1;
		}
		
		int pageBlock = 5;
		int endPage = startPage + pageBlock -1;
		if(endPage>pageCount){
			endPage = pageCount;
		}
		if(startPage>5){
%>
			<a href = "freeboard.jsp?pageNum=<%=startPage-5 %>" class="pre"><</a>
<%			
		}
		
		for(int i=startPage; i<=endPage; i++){
%>
			<a href = "freeboard.jsp?pageNum=<%=i %>" class="select-page"><%=i %></a>
<%			
		}
	if(endPage < pageCount){
%>
			<a href = "freeboard.jsp?pageNum=<%=startPage+5 %>" class="next">></a>
<%			
		}
	}
//----------------
%>

  <ul class="buttons">
     <li>
<%
   String id = (String) session.getAttribute("id");
   if (id==null || id.equals("")) { %>
      <a href="javascript:alert('로그인 후 이용해 주세요! \n로그인 페이지로 이동합니다.')" onclick="location.href='../member/loginForm.jsp'">
      <button>글쓰기</button></a>
<%   } else { %>
      <button onclick="location.href='writeForm.jsp'">글쓰기</button>
<%   } %>
   </li>
  </ul>  
  </div>
  
  </div> 

</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>

</body>
</html>