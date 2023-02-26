<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>
<link href="../css/board.css" rel="stylesheet" type="text/css">
<style>

input[type=text], select, textarea, file {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}
.file{ width: 100%;}

input[type=submit] {
  background-color: blue;
  color: white;
  padding: 20px 30px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  text-align:center;
  justify-content:center;
  margin:8px;
  font-size:0.95rem;

}
input[type=button] {
  background-color: black;
  color: white;
  padding: 20px 30px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
   font-size:.95rem;

}
input[type=submit]:hover {
  opacity:.7;
}

input[type=button]:hover {
  opacity:.8;
}

.container {
  width:750px;
  height:950px;
  margin:20px auto;
  font-size:1.1rem;

}
.txt > h3 {
	text-align:center;
	font-size:1.6rem;
	font-weight:700;
	margin:25px;
	letter-spacing:1px;
}
.container > .btn{
	text-align:center;
	margin:20px;
}
</style>
<script>
function check_input()
{
   if (!document.form.company.value) {
       alert("회사명을 입력하세요!");    
       document.form.company.focus();
       return false;
   }

   if (!document.form.name.value) {
       alert("담당자명을 입력하세요!");    
       document.form.name.focus();
       return false;
   }

   if (!document.form.contact.value) {
       alert("연락처를 입력하세요!");    
       document.form.contact.focus();
       return;
   }

   if (!document.form.email.value) {
       alert("이메일을 입력하세요!");    
       document.form.email.focus();
       return;
   }

   if (!document.form.text.value) {
       alert("내용을 입력하세요!");    
       document.form.text.focus();
       return;
   }
   document.form.submit();
}

function reset_form() {
	   document.form.company.value = "";  
	   document.form.name.value = "";
	   document.form.contact.value = "";
	   document.form.email.value = "";
	   document.form.text.value = "";
	   document.form.image.value = "";
	   document.form.company.focus();
	   return;
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
		<h1>문의하기</h1>
	</div>
</div>

	<div class="txt_box">
        <ul class="menu">
            <li class="menu-item"><a href="./freeboard.jsp" class="menu-link" >Q & A</a></li>
            <li class="menu-item"><a href="./fnq.jsp" class="menu-link">자주하는 질문</a></li>
            <li class="menu-item"><a href="./contact.jsp" class="menu-link" style="background-color:#000040; color:white;">문의하기</a></li>
        </ul>
    </div> 
<div class="container">
	<div class="txt">
		<h3>CONTACT US</h3>
	</div>
	
  <form action="contactPro.jsp" method="post" name="form">

    <label for="lname">이름</label>
    <input type="text" id="lname" name="name" placeholder="담당자명을 입력하세요">
    
    <label for="lname">연락처</label>
    <input type="text" id="lname" name="contact" placeholder="연락처를 입력하세요">
    
    <label for="lname">이메일</label>
    <input type="text" id="email" name="email" placeholder="이메일을 입력하세요">

	<label for="lname">창업희망지역</label>
	<select>
		<option value=>서울</option>
		<option>부산</option>
		<option>대구</option>
	</select>
	
	<label for="lanme">점포 유무</label>
	<select>
		<option>점포있음</option>
		<option>점포없음</option>
	</select>

    <label for="subject">문의내용</label>
    <textarea id="subject" name="text" placeholder="내용을 입력하세요" style="height:200px"></textarea>
   
  </form>
  <div class="btn">
   		<input type="button" value="다시작성" onclick="reset_form()">
   		<input type="submit" value="작성완료" onclick="check_input()">	
    </div>
</div>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>

</body>
</html>