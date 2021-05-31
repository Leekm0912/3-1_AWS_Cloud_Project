<%@ page contentType="text/html; charset=utf-8"%>
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


	<!-- 로긴폼 -->

	<div class="container">

		<div class="col-lg-4" style="margin: auto">

			<!-- 점보트론 -->

			<div class="jumbotron">

				<!-- 로그인 정보를 숨기면서 전송post -->

				<form method="post" action="loginAction.jsp" style="text-align: center;">

					<h3 style="text-align: center;">로그인화면</h3>

					<div class="form-group">

						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>



					<div class="form-group">

						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="btn-group" data-toggle="buttons">

						<label> <input type="radio" name="userType" autocomplete="off" value="매수자" checked>매수자
						</label> <label> <input type="radio" name="userType" autocomplete="off" value="매도자">매도자
						</label>

					</div>
					<input type="submit" class="btn btn-primary form-control" value="로그인">
				</form>
				<br/><h4 style="text-align:center;">or</h4><br/>
				<!-- 카카오 로그인 -->
				<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
				<h5 style="text-align:center;">매수자 카카오톡 로그인</h5> 
				<a id="custom-login-btn" href="javascript:loginWithKakao('매수자')" style="text-align:center;"> <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="270" /> </a> <br/><br/>
				<h5 style="text-align:center;">매도자 카카오톡 로그인</h5>
				<a id="custom-login-btn" href="javascript:loginWithKakao('매도자')" style="text-align:center;"> <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="270" />
				</a>
				<br/>
				<p id="token-result"></p>
				<!--  카카오 로그인 -->
			</div>

		</div>

	</div>


	<script type="text/javascript">
		// input your appkey
		Kakao.init('baca3a5f6f931f8a69d6569bf6473bf5')
		function loginWithKakao(type) {
			Kakao.Auth.login({
				success : function(authObj) {
					var parseObj = JSON.parse(JSON.stringify(authObj));
					console.log("access_token : " + parseObj.access_token);
					Kakao.Auth.setAccessToken(parseObj.access_token);
					console.log(Kakao.Auth.getAccessToken());
					Kakao.API.request({
						url : '/v2/user/me',
						//url : '/v1/api/talk/profile',
						success : function(res) {
							console.log(res);
							var userName = res.properties.nickname;
							var userID = res.id; //유저의 카카오톡 고유 id
							var email = res.properties.email;

							console.log(userName);
							console.log(userID);
							location.href="loginAction.jsp?type=kakao"+type+"&id="+userName+"&pw="+userID+"&email="+email;
						},
						fail : function(error) {
							alert(JSON.stringify(error));
						}
					});
				},
				fail : function(err) {
					alert(JSON.stringify(err))
				},
			})
		}

		// UI code below
		getToken()
		function getToken() {
			const token = getCookie('authorize-access-token')
			if (token) {
				Kakao.Auth.setAccessToken(token)
				document.getElementById('token-result').innerText = 'login success. token: '
						+ Kakao.Auth.getAccessToken()
			}
		}
		function getCookie(name) {
			const value = "; " + document.cookie;
			const parts = value.split("; " + name + "=");
			if (parts.length === 2)
				return parts.pop().split(";").shift();
		}
	</script>


	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>



</body>

</html>
