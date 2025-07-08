<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>

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
    <link rel="stylesheet" href="/static/css/globals.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../common/header.jsp"/>
<main class="max-w-6xl mx-auto px-4 py-12">
    <div class="flex justify-between items-center mb-8">
        <h1 class="text-3xl font-light text-gray-900">주문 내역</h1>
    </div>

    <!-- Search and Filter -->
    <div class="bg-white border border-beige-200 rounded-lg mb-6">
        <div class="p-6">
            <div class="flex flex-col md:flex-row gap-4">
                <div class="flex gap-2 md:ml-auto">
                    <div class="relative">
                        <i data-lucide="search"
                           class="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-beige-400"></i>
                        <input type="text" placeholder="검색어를 입력하세요" id="search"
                               class="pl-10 pr-4 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                    </div>
                    <button onclick="searOrderName()" class="border border-beige-300 px-4 py-2 rounded-lg hover:bg-beige-100">검색</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Posts List -->
    <div class="bg-white border border-beige-200 rounded-lg">
        <div class="p-6 border-b border-beige-100">
            <h2 class="text-xl font-medium text-gray-900">주문 목록</h2>
        </div>
        <div class="divide-y divide-beige-200">
            <c:forEach var="item" items="${orderList}">
            <div class="p-6 hover:bg-beige-50 transition-colors">
                <div class="flex items-start justify-between">
                    <div class="flex-1">
                        <div class="flex items-center gap-2 mb-2">
                            <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">${item.orderStatus}</span>
                        </div>
                        <a href="orderDetl?orderNumber=${item.orderId}" class="block">
                            <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                                주문 번호: ${item.orderId}
                            </h3>
                        </a>
                        <div class="flex items-center gap-4 text-sm text-beige-600">
                            <span>결제 금액: ₩<fmt:formatNumber value="${item.totalAmount}" type="number" groupingUsed="true"/>원</span>
                            <span>구매 종류: ${item.productTypeCount}개</span>
                            <span>주문 날짜: <fmt:formatDate value="${item.orderDate}" pattern="yyyy-MM-dd" /></span>
                            <span>결제수단: ${item.paymentMethod}</span>
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

<script>
    // Initialize Lucide icons
    lucide.createIcons();
    function searOrderName() {
        const search = document.getElementById('search').value;
        if (!search) {
            alert("검색어를 입력해주세요.");
            return;
        }
        fetch('/searchOrder', {
            // method: 'POST',
            // headers: {
            //     'Content-Type': 'application/x-www-form-urlencoded'
            //
            // },
            // body: "userEmail=" + encodeURIComponent(email)
        })
            .then(res => res.text())
            .then(data => alert(data))
            .catch(err => alert("메일 전송 실패: " + err));
    }
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>