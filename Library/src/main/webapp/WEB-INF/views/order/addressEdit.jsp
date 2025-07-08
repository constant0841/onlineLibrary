<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송지</title>
    <!-- 필요 시 CSS/JS 프레임워크 (예: Bootstrap) 추가 -->
    <%--  <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">--%>
    <%--  <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>--%>
    <%--  <script src="<c:url value='/resources/js/bootstrap.bundle.min.js'/>"></script>--%>
    <style>
        /* 간단한 스타일 예시 */
        .default-label {
            font-weight: bold;
            color: #007bff;
        }

        .action-btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h2>배송지</h2>
    <!-- 새 배송지 등록 버튼 -->
    <div class="mb-3">
        <%--    <a href="<c:url value='/address/new'/>" class="btn btn-primary">새 배송지 등록</a>--%>
    </div>

    <!-- 배송지 리스트가 비어 있는 경우 -->
    <c:if test="${empty addressList}">
        <div class="alert alert-info">등록된 배송지가 없습니다.</div>
    </c:if>

    <!-- 배송지 리스트 출력 테이블 -->
    <c:if test="${not empty addressList}">
        <table class="table table-striped table-bordered">
            <thead class="thead-light">
            <tr>
                <th>번호</th>
                <th>배송지명</th>
                <th>수령인명</th>
                <th>연락처</th>
                <th>주소</th>
                <th>상세주소</th>
                <th>우편번호</th>
                <th>기본배송지</th>
                <th>작업</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="addr" items="${addressList}">
                <tr>
                    <td><c:out value="${addr.adressBookId}"/></td>
                    <td><c:out value="${addr.adressName}"/></td>
                    <td><c:out value="${addr.recipientName}"/></td>
                    <td><c:out value="${addr.recipientPhone}"/></td>
                    <td><c:out value="${addr.address}"/></td>
                    <td><c:out value="${addr.addressDetail}"/></td>
                    <td><c:out value="${addr.postalCode}"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${'Y' eq addr.isDefault.toString()}">
                                <span class="default-label">기본배송지</span>
                            </c:when>
                            <c:otherwise>
                                <!-- 기본배송지 설정 폼/버튼 -->
                                <form action="<c:url value='/'/>" method="post" style="display:inline;">
                                    <!-- CSRF 토큰이 필요하면 hidden 필드로 삽입 -->
                                    <input type="hidden" name="addressBookId" value="${addr.adressBookId}"/>
                                    <button type="submit" class="btn btn-sm btn-outline-primary action-btn">기본 설정
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <!-- 수정 버튼 -->
                        <a href="<c:url value='/address/edit/${addr.adressBookId}'/>"
                           class="btn btn-sm btn-warning action-btn">수정</a>
                        <!-- 삭제 버튼 -->
                        <form action="<c:url value='/'/>" method="post" style="display:inline;"
                              onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <!-- CSRF 토큰 필요 시 삽입 -->
                            <input type="hidden" name="addressBookId" value="${addr.adressBookId}"/>
                            <button type="submit" class="btn btn-sm btn-danger action-btn">삭제</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>
