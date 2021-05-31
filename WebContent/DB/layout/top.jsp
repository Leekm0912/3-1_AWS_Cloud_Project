<%@ page contentType="text/html; charset=utf-8"%>
<%@ page session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>연암 부동산</title>


<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<h1>
		<a href="main.jsp" style="color: white;">연암부동산</a>
	</h1>
	&nbsp&nbsp&nbsp&nbsp
	<c:if test='<%=session.getAttribute("userType") != null%>'>
		<c:choose>
			<c:when test='<%=session.getAttribute("userType").toString() == "매수자"%>'>
				<a href="logout.jsp" style="color: white;">로그아웃</a>
			&nbsp&nbsp&nbsp&nbsp
			<a href="mypage.jsp" style="color: white;">내정보</a>
			</c:when>
			<c:when test='<%=session.getAttribute("userType").toString() == "매도자"%>'>
				<a href="logout.jsp" style="color: white;">로그아웃</a>
			&nbsp&nbsp&nbsp&nbsp
			<a href="mypage.jsp" style="color: white;">내정보</a>
			</c:when>
			<c:otherwise>
				<a href="login.jsp" style="color: white;">로그인</a>
			&nbsp&nbsp&nbsp&nbsp
			<a href="join.jsp" style="color: white;">회원가입</a>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test='<%=session.getAttribute("userType") == null%>'>
		<a href="login.jsp" style="color: white;">로그인</a>
	&nbsp&nbsp&nbsp&nbsp
	<a href="join.jsp" style="color: white;">회원가입</a>
	</c:if>
	&nbsp&nbsp&nbsp&nbsp
	
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarResponsive">
		<ul class="navbar-nav ml-auto">
			<li class="nav-item active"><a class="nav-link" href="main.jsp">Home <span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item"><a class="nav-link" href="ViewTable.jsp">매물 보기</a></li>
			<li class="nav-item"><a class="nav-link" href="InsertTable.jsp">매물 등록</a></li>
			<li class="nav-item"><a class="nav-link" href="Order.jsp">매물 구매 신청</a></li>
		</ul>
	</div>


	<%-- 
<h1 style="color:white;">연암 부동산</h1>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="main.jsp">Home
              <span class="sr-only">(current)</span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="ViewTable.jsp">매물 보기</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="InsertTable.jsp">매물 등록</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Order.jsp">매물 구매 신청</a>
          </li>
        </ul>
      </div>
--%>
</body>