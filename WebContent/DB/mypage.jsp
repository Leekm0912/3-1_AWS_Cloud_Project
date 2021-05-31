<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->
<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css"></style>
<title>연암 부동산</title>

</head>

<body>
	<%
		request.setCharacterEncoding("utf-8");
	Connection con = null;
	String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
	String userid = "leekm";
	String pwd = "12121212";
	String query = "";
	Statement stmt = null;
	ResultSet rs = null;
	try { /* 드라이버를 찾는 과정 */
		Class.forName("oracle.jdbc.driver.OracleDriver");
		//System.out.println("드라이버 로드 성공");
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	}

	try { /* 데이터베이스를 연결하는 과정 */
		//System.out.println("데이터베이스 연결 준비 ...");
		con = DriverManager.getConnection(url, userid, pwd);
		//System.out.println("데이터베이스 연결 성공");
	} catch (SQLException e) {
		e.printStackTrace();
	}

	String userID = (String) session.getAttribute("userID");
	String userType = (String) session.getAttribute("userType");
	if (userType.equals("매수자")) {
		query = "select 전화번호 from 매수자 where 매수자id = " + "'" + userID + "'";
	} else if (userType.equals("매도자")) {
		query = "select 전화번호 from 매도자 where 매도자id = " + "'" + userID + "'";
	}
	String name = (String) session.getAttribute("userName");
	String ID = (String) session.getAttribute("userID");
	String phone = "";
	try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
		stmt = con.createStatement();
		rs = stmt.executeQuery(query);
		phone = rs.getString(1);
	} catch (Exception e) {

	}
	%>

	<!-- 네비게이션  -->

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
		<div class="container">
			<jsp:include page="./layout/top.jsp" flush="true" />
		</div>
	</nav>

	<!-- 로긴폼 -->

	<div class="container">

		<div style="margin: auto;">

			<!-- 점보트론 -->

			<div style="padding-top: 20px; width: 60%; margin: auto; background-color: lightgray; border-radius: 10px;">

				<!-- 로그인 정보를 숨기면서 전송post -->

				<form method="post" action="mypageAction.jsp">
				<% 
				out.print("<input type='hidden' name='page' value='info'>");
				%>
					<h3 style="text-align: center;"><%=name%>
						회원님의 정보창 입니다.
					</h3>
					<br />
					<c:if test='<%=session.getAttribute("userType") != null%>'>
						<c:choose>
							<c:when test='<%=session.getAttribute("userType").toString() == "매수자"%>'>
								<div class="row">
									<div class="col-lg-12 text-center">
										<input type="submit" class="btn btn-primary form-control" value="매수 주문 확인" name="type1" style="border-radius: 10px;"> <br />
									</div>
								</div>
							</c:when>
							<c:when test='<%=session.getAttribute("userType").toString() == "매도자"%>'>

								<div class="row">
									<div class="col-lg-12 text-center">
										<input type="submit" class="btn btn-primary form-control" value="등록한 매물 목록 확인" name="type2" style="border-radius: 10px;"> <br />
									</div>
								</div>
							</c:when>
						</c:choose>
					</c:if>
					<c:if test='${isKakao == false }'>
					<br /> <input type="submit" class="btn btn-primary form-control" value="비밀번호 변경" name="type3" style="border-radius: 10px;">
					</c:if>
				</form>

			</div>

		</div>

	</div>





	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>
	<script src="../js/bootstrap.js"></script>



</body>

</html>
