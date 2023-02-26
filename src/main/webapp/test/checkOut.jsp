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

    <% request.setCharacterEncoding("UTF-8"); %>
 	<% String product = (String) session.getAttribute("productName"); %>
    <% ArrayList<String> arrr = (ArrayList) (session.getAttribute("productList")); %>
    <center>
        <h1>상품 결과</h1>
        <hr>
        <hr>
        <% if (arrr == null) { %>
        장바구니에 넣은 상품이 없습니다.
        <% } else {
        	if(product.equals("")) {
        		
        	}
                for (String i : arrr) {
                    out.println(i); %><br>
                <% }
        } %>
        <br><br><hr>
        <table>
            <tr>
                <td><input type=button onClick="history.back()" value="뒤로가기"></td>
                <td>
                    
            </tr>
        </table>
    </center>
</body>
</html>