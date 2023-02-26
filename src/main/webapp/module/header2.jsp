<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
<body>
	<div class="wrap">
			<div class="header2">
			  <ul class="nav3">
               		<li><a href="#" class="icon"><i class="fa-brands fa-square-facebook"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-twitch"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
               </ul> 
				<ul class="nav2">
					<%
						String id = "";
							try {
								id = (String) session.getAttribute("id");
							if (id==null || id.equals("")) { %>
                        <li><a href="../member/memberForm.jsp">회원가입</a></li>
                       	<li>|</li>
                        <li><a href="../member/loginForm.jsp" class="login">로그인</a></li>
                        
                        <%		
						} else {
						%>
						<li><%=id %> 님</li>
						<li>|</li>
						<li><a href="../member/logoutPro.jsp">로그아웃</a></li>
	        			<li>|</li>
	        			<li><a href="../member/memberupdateForm.jsp" class="login">정보수정</a></li>	
               			<%
						}
						} catch(Exception e) {
								e.printStackTrace();
						}
						%>
                </ul>
			</div>
			
			
			
			<div class="header3">
				<div class="logo">
				<h2><a href="../main/main.jsp">Company</a></h2>		
				</div>
			    <div class="searchArea">
                    <form>
                        <input type="search" placeholder="Search">
                        <i class="fa-sharp fa-solid fa-magnifying-glass"></i>
                    </form>
                </div>
             </div>   
             
            <div class="header" >
                    <ul class="nav">
                    	<li><a href="#"><i class="fa-sharp fa-solid fa-bars"></i></a></li>
                        <li><a href="../main/main.jsp">HOME</a></li>
                        <li><a href="../company/intro.jsp">회사소개</a></li>
                        <li><a href="../product/productlist.jsp">제품소개</a></li>
                        <li><a href="../board/freeboard.jsp">공지사항</a></li>
                    </ul>
        	</div>
        </div>   

</body>
</html>