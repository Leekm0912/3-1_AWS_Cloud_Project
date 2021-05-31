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
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
	<div style="text-align:center;">
	<h1>토지 등록</h1>
	<form action="../add_data.jsp" method="post">
		<input type="hidden" name="sellType" value="토지"/>
		<h5>주소</h5>
		<input type="text" name="address" size="50" class="form-control" id="exampleTextarea" style="width: 60%; margin:auto"> <br>
		<h5>평수</h5> 
		<input type="text" name="price" size="20" class="form-control" id="exampleTextarea" style="width: 60%; margin:auto;"> <br>
		<h5>평당가격</h5> 
		<input type="text" name="price2" size="20" class="form-control" id="exampleTextarea" style="width: 60%; margin:auto;"> <br>
		
		<div style="margin: auto; text-align: center;">
			<input type="submit" value="입력완료" class="btn btn-primary">
		</div>
	</form>
	</div>
	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.slim.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/jquery/jquery.slim.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>