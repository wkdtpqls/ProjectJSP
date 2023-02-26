<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 소개</title>
<script src="https://kit.fontawesome.com/acfbc5814d.js" crossorigin="anonymous"></script>
<style>


ul.tabs {

position:relative;
float:left;
list-style: none;
height: 50px;
width: 100%;
box-sizing:border-box;
margin:auto;
padding: 0;
margin-top:50px;
text-align:center;
}

ul.tabs li {
float: left;
text-align:center;
cursor: pointer;
width:33.3%;
padding: 0;
margin:auto;
line-height: 50px;
height:50px;
border: 1px solid #dedede;
color:black;
box-sizing:border-box;
}
ul.tabs > li:hover{
transition:0.5s;
background-color:#000040;
color:white;
}
ul.tabs li:first-child {border:1px solid #dedede;}

ul.tabs li.active {
background-color:#000040;
color:#fff;
}

.tab_container {
position:relative;
float:left;
border: 1px solid #dedede;
width:100%;
padding:30px;
box-sizing:border-box;
}



</style>


</head>
<link href="../css/company.css" rel="stylesheet" type="text/css">
<body>
<header>
  <jsp:include page="../module/header.jsp" flush="false"/>
</header>
<section>
<div class="con">
	<div class="text">
		<p>OUR COFFEE</p>
		<h1>회사소개</h1>
		<ul class="tabs">
		    <li class="active" rel="tab1">OUR COFFEE</li>
		    <li rel="tab2">CEO 인사말</li>
		    <li rel="tab3">오시는 길</li>
		</ul>
	</div>
</div>


<!-- tab-->


    <div id="tab1" class="tab_content">
		<div class="tab_container">
			<div class="container1">
	 			<div class="txtbox1">
	 				<h1>아우어 커피</h1>
	 				<p>Always Beside You, 항상 고객님과 함께 합니다.</p>
	 			</div>
	
			<div class="intro1">
				<img src="https://cdn.pixabay.com/photo/2016/11/29/08/35/black-coffee-1868462__340.jpg">
				<div class="txt">
					<h1>커피 한잔의 진심</h1>
					<p>해외에 로열티를 내지 않는 순수 국내 브랜드 커피, 품질 좋고 맛있는 커피를 합리적인
						가격으로 소비자에게 제공하는 것을 우리의 진심이라 믿습니다. 더 맛있는 커피를 만들기위해 
						더 나은 커피를 위해 끊임없는 연구 개발을 진행하고 있습니다. 
					</p>
				</div>
			</div>
			
				<div class="intro2">
				<div class="txt">
					<h1>함께 행복하기 위한 상생 협력</h1>
					<p>고객, 가맹점주, 협력사와의 상생협력을 무엇보다 소중하게 생각합니다. '상생협력'은 정직과 신뢰를 기반으로 장기적으로 구축되었습니다. 
						고객들에겐 우리의 진심을 제골하고, 가맹점주에게는 다양한 지원정책으로 미래의 행복으로 인도하며, 협력사와는 오랜 기간 쌓아온 굳건한 신뢰로 양질의 원부자재를 공급받고 있습니다. 
					</p>
				</div>
				<img src="https://cdn.pixabay.com/photo/2019/12/02/18/44/coffee-4668463__340.jpg">
			 </div>
			
	   		 </div>
    	</div>
   </div> 
    <!-- #tab2 --> 
    <div id="tab2" class="tab_content">
<div class="tab_container">	
	<div class="container">
		<div class="txtbox">
	 				<h1>CEO 인사말</h1>
	 				<p>대한민국을 대표하는 커피브랜드를 만들다.</p>
	 	</div>
		<div class="txt-box">
			<div class="ceo-message">CEO MESSAGE</div>
				<h1>홈페이지를 방문해주신 <span>고객 여러분 반갑습니다.</span></h1>
				<div class="txt">
					<h4>
					취향, 기분에 따라 선택할 수 있는 BLACK & WHITE 여러가지의 원두를 만나보세요
					</h4>
					<br>
					<p>
					 	BLACK & WHITE가 제공하는 좋은 원두로 BLACK & WHITE로 마련한 아름다운 공간에서 향기로운 커피 한잔과 함께 당신에게 소중한 추억이 
	    		   		될 수 있도록 노력하겠습니다. 단순히 좋은 원두와 디저트를 소개하고 제공하는 것을넘어 맛과 향, 품질, 
	    		   		서비스를 포함해 경험과, 추억을 나눌 수 있는 공간이 될 수 있도록 항상 노력하겠습니다. 감사합니다.
					</p>
				</div>
			<div class="sign"><h3>대표이사 &nbsp;&nbsp;<span>장 세 빈</span></h3></div>
			<img src="../img/gre_sign.png">
		</div>
	</div>
	</div>
</div>
				
    
    <!-- #tab3 -->
    <div id="tab3" class="tab_content">
		<div class="tab_container">	
			<div class="container">
				<div class="txtbox">
					<h1>본사 오시는 길</h1>
				</div>

			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d6329.784823046295!2d127.02412186977537!3d37.510455600000014!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357ca3f0921cfcbd%3A0xeeccc9d0ef3f4ad4!2z7J2065SU7JW8IOy7pO2UvOueqQ!5e0!3m2!1sko!2skr!4v1675002964112!5m2!1sko!2skr" 
				width="1000px" height="550px" loading="lazy" ></iframe>
      		</div>
      		
      		<div class="conT">
      			<div class="add">
      			
	      			<ul class="add1">
	      				<li>주소</li>
	      				<li>서울특별시 강남구 논현로 123 OURCOFFEE 빌딩</li>
	      			</ul>
	      		
	      			
		      			<ul class="tel">
		      				<li>대표전화</li>
		      				<li>02-123-4567</li>
		      			</ul>
	      			
      			</div>
      			
      			<div class="car">
      			
      			<ul class="vehicle">
      				<li><i class="fa-solid fa-car"></i></li>
      				<li>승용차 이용시</li>
      				<li>9호선 언주역사거리에서 학동역 사거리 방면으로 350m 직진하여 우측 위치(힐탑 호텔 건너편 방면 위치)</li>
      				
      			</ul>
      				
      			
      			<ul class="bus">
      				<li><i class="fa-sharp fa-solid fa-bus"></i></li>
      				<li>대중교통 이용시</li>
      				<li>9호선 : 언주역(9호선) 하차 후 3번 출구 학동역 방향으로 350m 주유소 옆</li>
      				<li>7호선 : 학동역(7호선) 하차 후 3번출구 언주역 방향으로 400m SK주유소 옆</li>
      			</ul>
      			

      			<ul class="park">
      				<li><i class="fa-solid fa-p"></i></li>
      				<li>주차장 이용안내</li>
      				<li>이디야빌딩 내 지하주차장 및 주차타워 이용가능</li>
      				<li>(이디야커피랩 운영시간에 근무하는 주차관리요원 문의)</li>
      			</ul>
      			</div>
      		</div>
		</div>
	</div>   


<!-- .tab_container -->










<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
$(function () {

$(".tab_content").hide();
$(".tab_content:first").show();

$("ul.tabs li").click(function () {
$("ul.tabs li").removeClass("active").css("color", "#555");
$(this).addClass("active").css("color", "#fff");
$(".tab_content").hide()
var activeTab = $(this).attr("rel");
$("#" + activeTab).fadeIn()
});
});
</script>
</section>
<footer>
  <jsp:include page="../module/footer.jsp" flush="false"/>
</footer>
</body>
</html>