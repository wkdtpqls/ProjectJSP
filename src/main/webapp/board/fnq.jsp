<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "fnq.FnqDAO" %>
<%@ page import = "fnq.FnqVO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
	int count = 0; // 총글수
	List<FnqVO> alist = null;
	FnqDAO fdao = FnqDAO.getInstance();
	count = fdao.getArticleCount();

	//---------------------------- 페이지 처리
	int pageSize = 15;
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
	      count = fdao.getArticleCount();   
	      if(count > 0) {
	         alist = fdao.getArticles(startRow, pageSize);
	      }
	   } else {
	      count = fdao.getArticleCount("%"+sword+"%");   
	      if(count > 0) {
	         alist = fdao.getArticles(startRow, pageSize, "%"+sword+"%");
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../css/board.css" rel="stylesheet" type="text/css">
    <script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
    <title>자주하는 질문</title>
    <!-- 폰트 -->
<style>

.faq-box {
    border:2px solid black;
    background-color:#fff;
    color:inherit;
    padding:10px;
  }
  
  .faq-box__question {
    cursor:pointer;
  }
  
  .faq-box__question::after {
    content:"▼";
    float:right;
  }
  
  .faq-box > ul > li {
    padding:20px;
  }
  
  .faq-box > ul > li.hover > .faq-box__question::after {
    content:"▲";
  }
  
  .faq-box__answer {
    display:none;
    background-color:#D5D5D5;
    border-radius:10px;
    padding:30px;
  }
  .faq-box__answer > i{
  	color:#000054;
  }
    
  .faq-box__question > i {
    color:#000054;
  }
  </style>
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
</head>
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>

<div class="con">
	<div class="text">
		<p>OUR COFFEE</p>
		<h1>FAQ</h1>
		<p>OUR COFFEE은 항상 여러분과의 즐거움을 위해 노력합니다. <br>궁금하신 사항은 언제든지 문의해주셔도 됩니다. 항상 고객님들의 입장에서 생각합니다</p>
	</div>
</div>
	<div class="txt_box">
        <ul class="menu">
            <li class="menu-item"><a href="./freeboard.jsp" class="menu-link" >Q & A</a></li>
            <li class="menu-item"><a href="./fnq.jsp" class="menu-link" style="background-color:#000040; color:white;">자주하는 질문</a></li>
          
        </ul>
    </div> 
	
<div class="container" style="width:1300px; margin:auto; height:900px;">

<div class="search_box">
<form name="search_form" method="get" action="fnq.jsp">
  <input type="search" name="sword" placeholder="검색할 내용을 입력하세요." />
  <a href="#" class="search"><span onclick="search_input()"><i class="fa-sharp fa-solid fa-magnifying-glass"></i></span></a>
</form>
</div>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <div class="container mx-auto">
    <h1>FAQ</h1>

    <div class="faq-box">
      <ul>
<%	
		if(alist != null){
		for(int i=0; i<alist.size();i++){
			FnqVO article = alist.get(i);
%>
        <li>

          <div class="faq-box__question"><i class="fa-solid fa-q"></i><span><%=article.getQuestion() %></span></div>
          <div class="faq-box__answer"><i class="fa-solid fa-a"></i>&nbsp;<%= article.getAnswer().replace("\r\n", "<br>") %> </div>
        </li>
<%} } %>           
        
        
      </ul>
    </div>
  </div>
</div>


  <script>

function FaqBox__init() {
  $('.faq-box > ul > li').click(function() {
    let $this = $(this);
    
    $this.siblings('.hover').find(' > .faq-box__answer').stop().slideUp(300); 
    $this.siblings('.hover').removeClass('hover');
    
    if ( $this.hasClass('hover') ) {
      $this.find(' > .faq-box__answer').stop().slideUp(300); 
      $this.removeClass('hover');
    }
    else {
      $this.find(' > .faq-box__answer').stop().slideDown(300); 
      $this.addClass('hover');
    }
  });
  
  $('.faq-box__answer').click(function() {
    return false;
  });
}

FaqBox__init();
  </script>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>


