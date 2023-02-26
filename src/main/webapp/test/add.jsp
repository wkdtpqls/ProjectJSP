<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <%
        request.setCharacterEncoding("UTF-8");
 
        ArrayList<String> arr = (ArrayList<String>) (session.getAttribute("productList"));
 
        String productName = request.getParameter("product");
 
        /* arrayList 안에 아무것도 없으면 arrayList 생성 */
        if (session.getAttribute("productList") == null) {
            arr = new ArrayList<String>();
        }
        arr.add(productName);
        session.setAttribute("productList", arr);
    %>
 
    <script>alert("<%=productName%>가 추가되었습니다.");history.back();</script>
</body>
</html>