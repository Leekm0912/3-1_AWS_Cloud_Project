<%@ tag body-content="empty" pageEncoding="utf-8"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%-- 속성이 동적으로 전달될 때에는 동적 속성 변수를 
	dynamic-attributes 속성으로 지정한다.  --%>
<%-- 이때 dynamic-attributes 속성 변수는 java.util.map 객체로 지정된다.  --%>
<%@ tag dynamic-attributes="dynamicVar"%>
<%@ attribute name="name" required="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<select name="${name}">
	<%-- 동적 속성들을 forEach로 처리하고 있다.  --%>
	<c:forEach items="${dynamicVar}" var="dVar">
		<option value="${dVar.key}">${dVar.value}</option>
	</c:forEach>
</select>