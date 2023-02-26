<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="product.ProductDAO" %>   
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>

<% request.setCharacterEncoding("utf-8");%>

<%
	String managerId = (String) session.getAttribute("managerId");
	if(managerId==null || managerId.equals("")) {
		response.sendRedirect("main.jsp");	
	} else {
		//파일이 업로드되는 폴더를 지정한다.
		String saveFolder = "C://WS-JSPMySQL/ProjectJSP/src/main/webapp/img/"; 
		//String saveFolder = "../bookimg"; //상대경로 X
		String encType = "utf-8"; //엔코딩타입
		int maxSize = 5*1024*1024;  //최대 업로될 파일크기 5Mb
		MultipartRequest multi = null;
		String filename = "";

		try{
		   multi = new MultipartRequest(request, saveFolder, maxSize, encType, new DefaultFileRenamePolicy());
		   out.println("업로드 성공");
		   filename = multi.getFilesystemName("pimage"); //서버에 저장된 파일 이름
		}catch(Exception e){
		 	System.out.println(e);
		}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 
	<jsp:useBean id="article" class="product.ProductVO">
		<!--<jsp:setProperty name="article" property="*" />-->
		<!--  multipart/form-data 방식이기 때문에 동작하지 않음 -->
	</jsp:useBean>
<%
	article.setPid(Integer.parseInt(multi.getParameter("pid")));
	article.setPtitle(multi.getParameter("ptitle"));
	article.setPrice(Integer.parseInt(multi.getParameter("price")));
	article.setCalory(Integer.parseInt(multi.getParameter("calory")));
	article.setSugar(Integer.parseInt(multi.getParameter("sugar")));
	article.setPimage(filename);	
	article.setPcontent(multi.getParameter("pcontent"));
	
	ProductDAO pdao = ProductDAO.getInstance();
	pdao.insertProduct(article);
	
	response.sendRedirect("productlist.jsp");
%>	
</body>
</html>
<%} %>