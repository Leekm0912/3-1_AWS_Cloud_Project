<%@page import="db.SMTP_AmazonSESS"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.stream.Stream"%>
<%@ page import="java.util.Collection.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
Enumeration<String> temp = request.getParameterNames();
Iterator<String> i = temp.asIterator();
String num = "";
while(i.hasNext()){
	String name = i.next();
	if(name.contains("data")){
		num = name.split("data")[1];
		System.out.println(num);
		if(!num.equals("")){
			break;
		}
	}
}

String userType = (String)session.getAttribute("userType");
if (userType == "매도자") {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('매도자는 매수할 수 없습니다.')");
	script.println("history.back();");
	script.println("</script>");
	if(true) return; // 왜인지 이거 안넣으면 중단이 안됨;;

} else if(userType == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인이 필요합니다.')");
	//script.println("location.href = 'login.jsp'");
	script.println("history.back();");
	script.println("</script>");
	if(true) return; // 왜인지 이거 안넣으면 중단이 안됨;;
}
request.setCharacterEncoding("utf-8");
Connection con = null;
String url = "jdbc:oracle:thin:@prdb.c5hn3vvddcdf.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
String userid = "leekm";
String pwd = "12121212";

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

SimpleDateFormat timeformat = new SimpleDateFormat("yyyy-MM-dd");
Date time = new Date();
int cnt = 0;
String query = "select 주문번호 from (select 주문번호 from 주문 order by 주문번호 desc) where rownum = 1"; /* 가장 높은 등록번호 추출 */
try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);

	while (rs.next()) {
		cnt = rs.getInt(1);
		cnt += 1;
	}
} catch (SQLException e) {
	e.printStackTrace();
}
if(cnt == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('DB오류')");
	script.println("history.back()");
	script.println("</script>");
}
query = "select 매도자ID from 매물 where 등록번호="+num; 
String sellername = "";

try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);

	while (rs.next()) {
		sellername = rs.getString(1);
	}
} catch (SQLException e) {
	e.printStackTrace();
}

// 매물 중복등록 방지
/*
query = "select 매물_등록번호 from 주문 where 매물_등록번호 = " + num; 
int overlap = 0;
try {
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery(query);

	while (rs.next()) {
		overlap = rs.getInt(1);
	}
} catch (SQLException e) {
	e.printStackTrace();
}
if(overlap != 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이미 주문된 매물입니다')");
	script.println("history.back()");
	script.println("</script>");
	return;
}
*/

//query = "exec 매물삽입(" + ++count + ",'" + timeformat.format(time) +"',"+ request.getParameter("id") +",'"+ request.getParameter("address") +"',"+ request.getParameter("price") +")"; /* 미리 만들어놓은 프로시저 이용 */

query = "insert into 주문 values(?,?,?,?,?)";
try { /* 데이터베이스에 질의 결과를 가져오는 과정 */
	PreparedStatement ppst = null;
	ppst = con.prepareStatement(query); // PreparedStatement 객체 생성(쿼리 생성)
	ppst.setInt(1, cnt);
	ppst.setString(2, num);
	String userID = (String)session.getAttribute("userID");
	ppst.setString(3, userID);
	ppst.setString(4, sellername);
	ppst.setString(5, timeformat.format(time));
	ppst.executeUpdate(); // 쿼리(sql) 실행
} catch (SQLException e) {
	PrintWriter script = response.getWriter();
	e.printStackTrace();
	script.println("<script>");
	script.println("alert('잘못된 사용입니다(DB오류)')");
	script.println("history.back()");
	script.println("</script>");

	if (true) return;
}

con.close();
SMTP_AmazonSESS.sendEmail((String)session.getAttribute("email"), "등록한 매물번호 "+ Integer.toString(cnt) +"이(가) 판매되었습니다!", "sold out!");
//response.sendRedirect("order_result.jsp");
%>
<jsp:forward page="order_result.jsp" />

