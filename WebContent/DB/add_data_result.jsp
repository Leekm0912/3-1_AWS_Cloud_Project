<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
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
<link href="mycss.css" rel="stylesheet">
</head>

<body>
	<% 
	String isInfoPage = request.getParameter("page");
	if(isInfoPage != null){
		if(isInfoPage.equals("info")){
	
	%>
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
			<div class="container">
				<jsp:include page="./layout/top.jsp" flush="false" />
			</div>
		</nav>
	
	<%
		}
	}
	%>

	<h1 style="text-align: center;">${ userName }님이 등록한 매물 목록</h1>
		<div class="container">
		<a href="./view/전세.jsp?type=update" target="main_frame" class="btn btn-primary">전세</a>
		<a href="./view/월세.jsp?type=update" target="main_frame" class="btn btn-primary">월세</a>
		<a href="./view/토지.jsp?type=update" target="main_frame" class="btn btn-primary">토지</a>
		<a href="./view/매매.jsp?type=update" target="main_frame" class="btn btn-primary">매매</a>

	</div>
	<iframe src="./view/전세.jsp?type=update" style="display: block; margin: auto; width: 95vw; height: 80vh" id="main_frame" name="main_frame"> </iframe>
	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.slim.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>