<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="stylesheet" type="text/css" href="../css/common.css">
  <title>Swiper demo</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
  <!-- Link Swiper's CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />

  <!-- Demo styles -->
  <style>
    html,
    body {
      position: relative;
      height: 100%;
      font-family: 'SUIT-Regular';
    }

    body {
      background: #fff;
      font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
      font-size: 14px;
      color: #000;
      margin: 0;
      padding: 0;
    }

	.swiper-wrapper{
		height:700px;
	}
    .swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;

      /* Center slide text vertically */
      display: flex;
      justify-content: center;
      align-items: center;
    }
	.swiper-slide{
		width: 360px;
      	height: 400px;
	}
    .swiper-slide img {
      display: block;
      width: 300px;
      height: 300px;
      object-fit: cover;
    }
    .swiper-slide img:hover{
    	width:310px;
    	height: 310px;
    	transition:0.5s;
    }
     .swiper-slide{
     	float:left;
     }
     .swiper-slide > a > p{
     	margin:30px auto;
     	font-size:1.2rem;
     }
	.swiper-slide > .text{
		width:200ox;
		height: 300px;
	}
    .swiper-container {
      width: 100%;
      height: 300px;
      margin: 20px auto;
    }

  </style>
</head>

<body>
  <!-- Swiper -->
<div class="conA"> 
	<div class="main_text0">
        <h1>OUR MENU</h1>
        <div class="contests1">
            차별화된 서비스를 제공합니다.
        </div>   

  <div class="swiper-container mySwiper">
    <div class="swiper-wrapper">
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img3.png"><p>아메리카노</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img2.png"><p>카페라떼</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img6.png"><p>카푸치노</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img4.png"><p>말차라떼</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img3.png"><p>아메리카노</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img1.png"><p>컵케이크</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img5.png"><p>베이글</p></a></div>
      <div class="swiper-slide"><a href="#"><img src="../img/c3_img4.png"><p>말차라떼</p></a></div>
    </div>
  </div>
</div>
</div> <!-- 메인 텍스트 --> 

 <div class="main_text2">
 	<ul>
 		<li>
	<div><h1>CONTACT</h1></div>
	<div>우리에게 파트너십을 신청하거나, 고객이 되어주세요.</div>
	<div class="more"><a href="../board/contact.jsp">MORE</a></div>
		</li>
 		
 	</ul>
 </div>
  <!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.mySwiper', {
    	slidesPerView: 3,
        spaceBetween: -50,
        slidesPerGroup: 1,
        loop: true,
        loopFillGroupWithBlank: true,
      centeredSlides: true,
      autoplay: {
        delay: 3000,
        disableOnInteraction: true,
      }
    });

 
  </script>
</body>

</html>
