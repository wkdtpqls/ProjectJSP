<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인화면</title>

<link rel="stylesheet" type="text/css" href="../css/common.css">
<script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
</head>
<body>    
<div class="conA"> 
	<div class="main_text0">
        <h1>OUR SERVICE</h1>
        <div class="contests1">
            차별화된 서비스를 제공합니다.
        </div>
    
         <section class="listA">
          <div class="container">
            <article>
                <a href="../product/productlist.jsp">
                    <div class="photo" style="background-image:url(../img/macaron.jpg);">
                   	<div class="text">
                        
                    </div>
                    </div>
               
                </a>
            </article>

            <article>
                <a href="../product/productlist.jsp">
                    <div class="photo" style="background-image:url(../img/cake.jpg);">
                    <div class="text">
                      
                    </div>
                    </div>
                   
                </a>
            </article>

            <article>
                <a href="../product/productlist.jsp">
                    <div class="photo" style="background-image:url(../img/coffee.jpg);">
                    <div class="text">
                        
                    </div>
                    </div>
                    
                </a>
            </article>
           </div>
        </section>
   </div> <!-- 메인 텍스트 --> 
     
    <div class="main_text2">
    	<ul>
    		<li>
				<div><h1>CONTACT</h1></div>
				<div>우리에게 파트너십을 신청하거나, 고객이 되어주세요.</div>
				<div class="more"><a href="../contact/contact.jsp">MORE</a></div>
			</li>
    		
    	</ul>
    </div>
    
</div>  <!-- conA -->  
</body>
</html>