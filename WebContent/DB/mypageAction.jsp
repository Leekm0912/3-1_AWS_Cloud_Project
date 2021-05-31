<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.CallableStatement"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
request.setCharacterEncoding("utf-8");

int type = 0;
Enumeration<String> temp = request.getParameterNames();
Iterator<String> i = temp.asIterator();
while (i.hasNext()) {
	String name = i.next();
	if(name.equals("type1") | name.equals("type2") | name.equals("type3")){
		type = Integer.parseInt(name.split("type")[1]);
		if (type != 0) {
			break;
		}
	}
}
request.setAttribute("type", type);
%>
<c:choose>
	<c:when test='${ type == 1 }'> <%-- 매수자 확인 --%>
		<jsp:forward page="order_result.jsp" />
	</c:when>
	<c:when test='${ type == 2 }'> <%-- 매도자 확인 --%>
		<jsp:forward page="add_data_result.jsp" />
	</c:when>
	<c:when test='${ type == 3}'> <%-- 비밀번호 변경 --%>
		<jsp:forward page="change_password.jsp" />
	</c:when>
</c:choose>