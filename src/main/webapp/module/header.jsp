<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberVO" %>
<% 	
	String id = (String) session.getAttribute("id");
	
	MemberDAO mdao = MemberDAO.getInstance();
	MemberVO article = mdao.getArticleUpdate(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
<script>
function search_input() {
    if (!document.search_form.sword.value) {
        alert("검색어를 입력하세요");    
        document.search_form.sword.focus();
        return;
    }    
    document.search_form.submit();
}
</script>
<body>

	<div class="wrap">
			<div class="header2">
			  <ul class="nav3">
               		<li><a href="#" class="icon"><i class="fa-brands fa-square-facebook"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-twitch"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fa-brands fa-twitter"></i></a></li>
               </ul> 
               	<div class="logo">
				<h2><a href="../main/main.jsp">OUR COFFEE</a></h2>		
				</div>
				<ul class="nav2">
					<%
							try {
								
							if (id==null || id.equals("")) { %>
                        <li><a href="../member/memberForm.jsp">회원가입</a></li>
                        <li>|</li>
                        <li><a href="../member/loginForm.jsp" class="login">로그인</a></li> 
                        <%		
						} else {
						%>
						<li><%=id %>  님 안녕하세요</li>
						<li>|</li>
						<li><a href="../member/logoutPro.jsp">로그아웃</a></li>
	        			<li>|</li>
	        			<li><a href="../member/memberupdateForm.jsp" class="login">정보수정</a></li>	
	        			<li>|</li>
						<li><a href="../mypage/freeboard.jsp">마이페이지</a></li>
               			<%
						}
						} catch(Exception e) {
								e.printStackTrace();
						}
						%>
                </ul>
			</div>
				
				
				
            <div class="header" >
                    <ul class="nav">
                    	<li><a href="#"><i class="fa-sharp fa-solid fa-bars"></i></a></li>
                        <li><a href="../main/main.jsp">HOME</a></li>
                        <li><a href="../company/intro.jsp">회사소개</a></li>
                        <li><a href="../product/productlist.jsp">메뉴</a></li>
                        <li><a href="../board/freeboard.jsp">커뮤니티</a></li>
                    </ul>
        	</div>   
	</div>
</body>
</html>