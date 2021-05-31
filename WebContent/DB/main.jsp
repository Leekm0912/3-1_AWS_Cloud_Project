<%@ page contentType="text/html; charset=utf-8"%>
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

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
		<div class="container">
			<jsp:include page="./layout/top.jsp" flush="false" />
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">
		<c:if test='<%=session.getAttribute("userType") != null%>'>
			<c:choose>
				<c:when test='<%=session.getAttribute("userType").toString() == "매수자"%>'>
					<div class="row">
						<div class="col-lg-12 text-center">
							<h1 class="mt-5"><%=session.getAttribute("userName")%>
								매수자님 환영합니다!
							</h1>
							<p>클라우드 프로젝트 연암부동산 입니다!</p>
						</div>
					</div>
				</c:when>
				<c:when test='<%=session.getAttribute("userType").toString() == "매도자"%>'>

					<div class="row">
						<div class="col-lg-12 text-center">
							<h1 class="mt-5"><%=session.getAttribute("userName")%>
								매도자님 환영합니다!
							</h1>

							<p>클라우드 프로젝트 연암부동산 입니다!</p>
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row">
						<div class="col-lg-12 text-center">
							<h1 class="mt-5">연암공과대학교 3A 이경민</h1>
							<p class="lead">학번 : 21660072</p>
							<p>클라우드 프로젝트 연암부동산 입니다!</p>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</c:if>
	</div>
	<c:if test='<%=session.getAttribute("userType") == null%>'>
		<div class="row">
			<div class="col-lg-12 text-center">
				<h1 class="mt-5">연암공과대학교 스마트SW 학과 3A 이경민</h1>
				<p class="lead">학번 : 21660072</p>
				<p>클라우드 프로젝트 연암부동산 입니다!</p>
			</div>
		</div>
	</c:if>
	
	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.slim.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
