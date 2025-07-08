<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-19
  Time: 오후 9:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>userInfo</title>
</head>
<body>
    <h1>
        여기는 user info 페이지 입니다!!!!!!!!!!!!
    </h1>
    <div>
        <c:forEach var="userInfoRes" items="${userInfoRes}">
            <p style="color: darkolivegreen">${userInfoRes.name}</p>
            <p style="color: darkolivegreen">${userInfoRes.phone}</p>
            <p style="color: darkolivegreen">${userInfoRes.email}</p>
            <p style="color: darkolivegreen">${userInfoRes.remarks}</p>
        </c:forEach>
    </div>
</body>
</html>
