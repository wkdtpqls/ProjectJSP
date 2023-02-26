<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

 
<center>
    <h1>상품 추가 리스트</h1>
    <hr>

    <hr>
    <form method="post" action="add.jsp">
        <select name=product>
            <option value="사과">사과</option>
            <option value="포도">포도</option>
            <option value="레몬">레몬</option>
            <option value="복숭아">복숭아</option>
        </select> <input value="추가" type="submit"> <br>
        <br>
        <br> <a href="checkOut.jsp" name="add">계산</a>
    </form>
    <br><br>

 
    </center>
    
</body>
</html>