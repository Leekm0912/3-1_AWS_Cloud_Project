<%-- 전달받은 몸체의 종류를 empty로 지정한다. 즉 몸체를 전달받지 않는다.  --%>
<%@ tag body-content="empty" pageEncoding="utf-8"%>
<%@ tag import="java.util.Calendar"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	    Calendar time = Calendar.getInstance();
		out.print(time.get(Calendar.YEAR)+"년");
		out.print(time.get(Calendar.MONTH)+1+"월");
		out.print(time.get(Calendar.DATE)+"일");
%>