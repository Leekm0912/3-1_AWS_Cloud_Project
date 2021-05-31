<%@ tag body-content="empty" pageEncoding="utf-8"%>
<%@ tag trimDirectiveWhitespaces="true"%>
<%-- attribute 디렉티브를 사용하여 전달받는 속성을 content 변수에 저장한다.  --%>
<%@ attribute name="content" required="true"%>
<%-- attribute 디렉티브를 사용하여 전달받는 속성을 size 변수에 저장한다.  --%>
<%@ attribute name="size" type="java.lang.Integer"%>
<%
		String StartTag = null;
		String EndTag = null;
		if (size == null) {
			StartTag = "<em>";
			EndTag = "</em>";
		} else {
			StartTag = "<h"+size+">";
			EndTag = "</h"+size+">";
		}
%>
<%= StartTag %>
${content}
<%= EndTag %>