<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">

	<!-- 스타일시트 참조  -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css"></style>
<title>연암 부동산</title>

</head>

<body>

	<!-- 네비게이션  -->

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
		<div class="container">
			<jsp:include page="./layout/top.jsp" flush="true" />
		</div>
	</nav>

	<!-- 로긴폼 -->

	<div class="container">

		<div class="col-lg-4" style="margin: auto">

			<!-- 점보트론 -->

			<div class="jumbotron" style="padding-top: 20px;">

				<!-- 로그인 정보를 숨기면서 전송post -->

				<form method="post" action="joinAction.jsp">

					<h3 style="text-align: center;">회원가입</h3>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>

					<div class="form-group">

						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<div class="form-group">

						<input type="text" class="form-control" placeholder="전화번호" name="userPhone" maxlength="20">
					</div>
					<div class="form-group">

						<input type="text" class="form-control" placeholder="이메일" name="email" maxlength="40">
						<h6 style="font-size:10pt;">이메일 등록 후 관리자에게 요청을 하면 알림메일이 갑니다!</h6>
						<h6 style="font-size:10pt;">관리자 메일<br>skatjrdndqo@naver.com</h6>
					</div>

					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label> <input type="radio" name="userType" autocomplete="off" value="매수자" checked>매수자 </label> 
							<label> <input type="radio" name="userType" autocomplete="off" value="매도자">매도자 </label>
						</div>

					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
				</form>

			</div>

		</div>

	</div>





	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>



</body>

</html>
