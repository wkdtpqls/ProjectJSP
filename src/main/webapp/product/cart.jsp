<%@page import="java.text.DecimalFormat"%>
<%@page import="product.ProductVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
ArrayList<ProductVO> cart = null;
Object obj = session.getAttribute("cart");	//세션 객체에서 cart 값을 가져온다.
if(obj == null) {	//세션 정보가 없으면 배열을 생성 : 주문한 제품이 없다
	cart = new ArrayList<ProductVO>();	
} else {			//세션 정보가 있으면 강제로 캐스팅 : 주문한 제품이 있다
	cart = (ArrayList<ProductVO>) obj;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>

<script type="text/javascript">
function fnPay(){
	alert("결제 기능을 지원하지 않습니다.");
}
function fnClear(){
	if(confirm("장바구니를 비우시겠습니까?")) {
		location.href = "../main/main.jsp";	
	}
}
function fnGo(){
	location.href = "./productlist.jsp";
}
</script>
</head>
<body>
<div align="center">
	<h3>[장바구니 보기]</h3>
	<table border="1">
		<tr>

			<th>메뉴</th>
			<th>가격</th>

		</tr>
<%
		if(cart.size() == 0) {
%>
		<tr align='center'>
			<td colspan= '3'>
				장바구니에 담긴 상품이 없습니다.
			
			</td>
		</tr>
<%
		} else {
			
			for(int i = 0; i < cart.size(); i++) {
				ProductVO dto = cart.get(i);
		%>
		<tr align= 'center'>
			<td><%=dto.getPtitle() %></td>
			<td><%=dto.getPrice() %></td>

		</tr>
		<% 
			
		}
			}//if else
		%>
			<tr align = 'center'>
			<td colspan= '3'>
				<input type='button' value='결제하기' onclick='fnPay()' />
				<input type='button' value='장바구니 비우기' onclick='fnClear()' />
				<input type='button' value='쇼핑 계속하기' onclick='fnGo()' />
			</td>
		<td>
		
		 </td>
			</tr>
	</table>
</div>