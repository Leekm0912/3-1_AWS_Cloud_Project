<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>매매</title>

<!-- Bootstrap core CSS -->
<link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../mycss.css" rel="stylesheet">
<style type="text/css">
</style>
</head>
<body>
	<%
		Connection con = null;
	String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
	String userid = "leekm";
	String pwd = "12121212";
	String query = "";
	String type = request.getParameter("type");
	String id = (String) session.getAttribute("userID");

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
	if (type.equals("view")) {
		query = "select * from 상세매물_매매 order by 매물등록번호"; /* SQL 문 */
	} else if (type.equals("sell")) {
		query = "select * from 상세매물_매매 where 상세매물_매매.매물등록번호 not in (select 주문.매물_등록번호 from 주문) order by 상세매물_매매.매물등록번호";
	}else if (type.equals("update")) {
		query = "select * from 상세매물_매매 where 매도자명 = (select 매도자_이름 from 매도자 where id='" + id + "') order by 매물등록번호";
	}
	try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
		Statement stmt = con.createStatement();
		ResultSet rs = stmt.executeQuery(query);
		List<Integer> row1 = new ArrayList<Integer>();
		List<String> row2 = new ArrayList<String>();
		List<String> row3 = new ArrayList<String>();
		List<String> row4 = new ArrayList<String>();
		List<Long> row5 = new ArrayList<Long>();
		while (rs.next()) {
			row1.add(rs.getInt("매물등록번호"));
			row2.add(rs.getString("등록일자"));
			row3.add(rs.getString("매도자명"));
			row4.add(rs.getString("주소"));
			row5.add(rs.getLong("가격"));
		}
	%>
	<form action="to.jsp" method="post">
		<table class="type1">
		<% 
		out.print("<input type='hidden' name='type' value='"+ type +"'>");
		%>
			<tr>
				<th scope="cols">매물등록번호</th>
				<th scope="cols">등록일자</th>
				<th scope="cols">매도자명</th>
				<th scope="cols">주소</th>
				<th scope="cols">가격</th>
				<%
				if (type.equals("sell")) {
					out.print("<th scope='cols'>구매 버튼</th>");
					out.print("<th scope='cols'>지도 보기</th>");
				} else if (type.equals("update")) {
					out.print("<th scope='cols'>삭제 버튼</th>");
				} else {
					out.print("<th scope='cols'>지도 보기</th>");
				}
				%>
			</tr>
			<%
				DecimalFormat formatter = new DecimalFormat("###,###");
			for (int i = 0; i < row1.size(); i++) {
				out.print("<tr>");
				out.print("<td style='text-align:center;'>" + row1.get(i) + "</td>");
				out.print("<td>" + row2.get(i).substring(0, 11) + "</td>");
				out.print("<td style='text-align:center;'>" + row3.get(i) + "</td>");
				out.print("<td>" + row4.get(i) + "</td>");
				out.print("<td>" + formatter.format(row5.get(i)) + "원" + "</td>");
				if (type.equals("sell")) {
					out.print("<td><input type='submit' value='구매신청' name='data" + row1.get(i) + "' class='btn btn-primary'></td>");
					out.print("<td style='text-align:center;'><span onclick=\"btn('" + row4.get(i) + "', '" + row1.get(i)
					+ "번 매물')\" class='btn btn-primary'>지도 보기</span></td>");

				} else if (type.equals("update")) {
					out.print("<td><input type='submit' value='삭제' name='remove_data" + row1.get(i)
					+ "' class='btn btn-primary'></td>");
				} else {
					out.print("<td style='text-align:center;'><span onclick=\"btn('" + row4.get(i) + "', '" + row1.get(i)
					+ "번 매물')\" class='btn btn-primary'>지도 보기</span></td>");

				}
				out.print("</tr>");
			}
			%>
		</table>
	</form>




	<%
		con.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>
	<script>
		btn();
		function btn(address,locate="") {
			parent.viewInKakaoMap(address,locate);
		}
	</script>
	<!-- Bootstrap core JavaScript -->
	<script src="../vendor/jquery/jquery.slim.min.js"></script>
	<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>