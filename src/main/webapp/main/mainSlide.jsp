<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing:border-box;
}

/* Slideshow container */
.slideshow-container {
  max-width: 100%;
  max-height: 650px;
  position: relative;
  margin: auto;
  margin-top:130px;
}
.slideshow-container > .mySlides > img {
  height: 600px;

}

/* Hide the images by default */
.mySlides {
  display: none;
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  margin-top: -22px;
  padding: 16px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.9);
}
.mySlides {
	position:relative;
}
.mySlides > .txt-box {
	position:absolute;
	top:46%;
	left:25%;
	transform: translate(-50%,-50%);
	text-align:left;
	width: 520px;
}	

/* The dots/bullets/indicators */
.dot {
  display:none;
}

.active, .dot:hover {
  background-color: #717171;
}


@-webkit-keyframes fade {
  from {opacity: .6}
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .6}
  to {opacity: 1}
}
.txt-box > h1{
	color:#fff;
	line-height:80px;
	font-size:3rem;
	letter-spacing:3px;
	font-weight: bold;
}
.txt-box > h2{
	color:#fff;
	font-weight:lighter;
	font-size:1.4rem;
}
.more{
	width:200px;
	height:30px;
	line-height:50px;
	margin:16px auto;
	border:1px solid white;
	background:#e1dee2;
	cursor:pointer;
	color:black;
}
.more a:hover{
	color:black;
}

  </style>
<body>
  <div class="slideshow-container">

    <!-- Full-width images with number and caption text -->
    <div class="mySlides">
      <img src="../img/main01.png" style="width:100%">
	   
	      
    </div>

    <div class="mySlides">
      <img src="../img/main04.png" style="width:100%">
      	
    </div>

    <div class="mySlides">
      <img src="../img/main03.png" style="width:100%">
     
    </div>


    <!-- Next and previous buttons -->
    <a class="prev" onclick="moveSlides(-1)">&#10094;</a>
    <a class="next" onclick="moveSlides(1)">&#10095;</a>
  
<!-- The dots/circles -->
  <div>
    <span class="dot" onclick="currentSlide(0)"></span>
    <span class="dot" onclick="currentSlide(1)"></span>
    <span class="dot" onclick="currentSlide(2)"></span>
  </div>
  
</div>
<script>
	var slideIndex = 0; //slide index
	
	// HTML 로드가 끝난 후 동작
	window.onload=function(){
	  showSlides(slideIndex);
	
	  // Auto Move Slide
	  var sec = 5000;
	  setInterval(function(){
	    slideIndex++;
	    showSlides(slideIndex);
	
	  }, sec);
	}
	
	
	// Next/previous controls
	function moveSlides(n) {
	  slideIndex = slideIndex + n
	  showSlides(slideIndex);
	}
	
	// Thumbnail image controls
	function currentSlide(n) {
	  slideIndex = n;
	  showSlides(slideIndex);
	}
	
	function showSlides(n) {
	
	  var slides = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("dot");
	  var size = slides.length;
	
	  if ((n+1) > size) {
	    slideIndex = 0; n = 0;
	  }else if (n < 0) {
	    slideIndex = (size-1);
	    n = (size-1);
	  }
	
	  for (i = 0; i < slides.length; i++) {
	      slides[i].style.display = "none";
	  }
	  for (i = 0; i < dots.length; i++) {
	      dots[i].className = dots[i].className.replace(" active", "");
	  }
	
	  slides[n].style.display = "block";
	  dots[n].className += " active";
	}

</script>

</body>
</html>
    