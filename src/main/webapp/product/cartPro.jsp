<%@page import="product.ProductVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String ptitle = request.getParameter("ptitle");
String price = request.getParameter("price");
ArrayList<ProductVO> cart = null;
Object obj = session.getAttribute("cart");	//세션 객체에서 cart 값을 가져온다.
if(obj == null) {	//세션 정보가 없으면 배열을 생성 : 최초 주문한 경우
	cart = new ArrayList<ProductVO>();	
} else {			//세션 정보가 있으면 강제로 캐스팅 : 추가 주문
	cart = (ArrayList<ProductVO>) obj;
}
int pos = 0;	//등록된 제품이 없다

//장바구니 세션에 등록된 제품이 없을 경우 : CartDTO 객체를 생성하여 배열에 등록(add())
if(pos == -1) {
	ProductVO dto = new ProductVO();
	dto.setPtitle(ptitle);
	dto.setPrice(Integer.parseInt(price));	//1,500 ▶ 1500 : 쉼표 제거 후 정수형으로 랩핑

	cart.add(dto);
}
//cart 세션 객체를 만들어 준다.
session.setAttribute("cart", cart);
%>

<script>
	alert("장바구니에 담았습니다."); 
	location.href = "./cart.jsp"
</script>