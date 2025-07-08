<%--
  Created by IntelliJ IDEA.
  User: monae
  Date: 25. 6. 24.
  Time: 오후 6:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Sha_Jang_Tumbler</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-VTmh+5lDQgxBgaA8cD3X2iKQk4YI3sYeEjwA0kaOK1Z3XM3+o2D4w9abEzoS4V6L"
          crossorigin="anonymous"/>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="/static/css/globals.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../common/header.jsp" />
<main class="max-w-6xl mx-auto px-4 py-12">
<div class="flex justify-between items-center mb-8">
    <h1 class="text-3xl font-light text-gray-900">게시판</h1>
    <a href="/board/write" class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg flex items-center gap-2">
        <i data-lucide="edit" class="h-4 w-4"></i>
        글쓰기
    </a>
</div>

<!-- Search and Filter -->
<div class="bg-white border border-beige-200 rounded-lg mb-6">
    <div class="p-6">
        <div class="flex flex-col md:flex-row gap-4">
            <div class="flex gap-2 flex-wrap">
                <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm bg-beige-100">전체</button>
                <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">공지사항</button>
                <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">FAQ</button>
                <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">문의</button>
                <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">이벤트</button>
            </div>
            <div class="flex gap-2 md:ml-auto">
                <div class="relative">
                    <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-beige-400"></i>
                    <input type="text" placeholder="검색어를 입력하세요" class="pl-10 pr-4 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                </div>
                <button class="border border-beige-300 px-4 py-2 rounded-lg hover:bg-beige-100">검색</button>
            </div>
        </div>
    </div>
</div>

<%--    Bord List    --%>
<div class="bg-white border border-beige-200 rounded-lg">
    <div class="p-6 border-b border-beige-100">
        <h2 class="text-xl font-medium text-gray-900">게시글 목록</h2>
    </div>
<div class="divide-y divide-beige-200">
    <c:forEach var="post" items="${boardList}">
        <div class="p-6 hover:bg-beige-50 transition-colors">
            <div class="flex items-start justify-between">
                <div class="flex-1">
                    <div class="flex items-center gap-2 mb-2">
                        <c:choose>
                            <c:when test="${post.boardType eq 'QNA'}">
                                <span class="bg-yellow-100 text-yellow-700 px-2 py-1 text-xs rounded">${post.boardType}</span>
                            </c:when>
                            <c:when test="${post.boardType eq 'EVN'}">
                                <span class="bg-blue-100 text-blue-700 px-2 py-1 text-xs rounded">${post.boardType}</span>
                            </c:when>
                            <c:when test="${post.boardType eq 'REV'}">
                                <span class="bg-green-100 text-blue-700 px-2 py-1 text-xs rounded">${post.boardType}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="bg-red-100 text-gray-700 px-2 py-1 text-xs rounded">${post.boardType}
                                    <c:if test="${post.isPinned == \"Y\"}">
                                        <span> 📌 </span>
                                    </c:if>
                                </span>
                            </c:otherwise>
                        </c:choose>
<%--                        --%>
<%--                        <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">${post.boardType}</span>--%>
                    </div>
                    <a href="/postContext/${post.postId}" class="block">
                            ${post.postTitle}
                    </a>
                    <div class="flex items-center gap-4 text-sm text-beige-600">
                        <span>${post.postWriter}</span>
                        <span>${post.writeAt}</span>
                        <span>${post.viewCount}</span>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
        <!-- Pagination -->
        <div class="flex justify-center mt-8">
            <div class="flex gap-2">
                <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">이전</button>
                <button class="bg-gray-900 text-white px-3 py-2 rounded">1</button>
                <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">2</button>
                <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">3</button>
                <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">다음</button>
            </div>
        </div>
</main>

<%--<script>--%>
<%--    // Initialize Lucide icons--%>
<%--    lucide.createIcons();--%>
<%--</script>--%>
<%--<jsp:include page="../common/footer.jsp" />--%>
</body>
</html>

<%--  퍼온 코드  --%>
<%--<div class="p-6 hover:bg-beige-50 transition-colors">--%>
<%--    <div class="flex items-start justify-between">--%>
<%--        <div class="flex-1">--%>
<%--            <div class="flex items-center gap-2 mb-2">--%>
<%--                <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">${post.boardType}</span>--%>
<%--            </div>--%>
<%--            <a href="boardDetl?id=1" class="block">--%>
<%--                ${post.postTitle}--%>
<%--            </a>--%>
<%--            <div class="flex items-center gap-4 text-sm text-beige-600">--%>
<%--                <span>${post.postWriter}</span>--%>
<%--                <span>${post.writeAt}</span>--%>
<%--                <span>${post.viewCount}</span>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%-- 기존에 대충 복붙해온 칼럼들 --%>
<%--<div>--%>
<%--    <p>${post.boardType} ${post.postTitle} ${post.postWriter} ${post.writeAt} ${post.viewCount}</p>--%>


<%--</div>--%>