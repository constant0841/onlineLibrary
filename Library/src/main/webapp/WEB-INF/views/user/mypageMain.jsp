<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지 - BookHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <style>
        .beige-100 { background-color: #f7f5f3; }
        .beige-200 { background-color: #ede8e3; }
        .beige-300 { background-color: #e3ddd6; }
        .beige-600 { color: #8b7355; }
        .beige-700 { color: #6b5b47; }
        .text-beige-600 { color: #8b7355; }
        .border-beige-200 { border-color: #ede8e3; }
        .border-beige-300 { border-color: #e3ddd6; }
    </style>
</head>
<body class="bg-gray-50">

<header class="bg-white shadow-sm border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center">
                <a href="/" class="text-2xl font-light text-gray-900 hover:text-beige-600 transition-colors">
                    <span class="text-beige-600">Book</span>Hub
                </a>
            </div>

            <div class="flex items-center space-x-4">
                <div class="flex items-center space-x-3">
                    <span class="text-gray-700">${userName}님</span>
                    <a href="/cart" class="text-beige-600 hover:text-beige-700 transition-colors">
                        <i data-lucide="shopping-cart" class="h-5 w-5"></i>
                    </a>
                    <a href="/mypage" class="text-beige-600 hover:text-beige-700 transition-colors">
                        <i data-lucide="user" class="h-5 w-5"></i>
                    </a>
                    <c:if test="${isAdmin}">
                        <a href="/admin" class="text-beige-600 hover:text-beige-700 transition-colors text-sm">관리자</a>
                    </c:if>
                    <a href="/logout" class="text-gray-500 hover:text-beige-600 transition-colors">
                        <i data-lucide="log-out" class="h-5 w-5"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>

<div class="bg-white border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4 py-3">
        <nav class="flex" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="/" class="text-beige-600 hover:text-beige-700">홈</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">마이페이지</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-8">
        <h1 class="text-3xl font-light text-gray-900 flex items-center">
            <i data-lucide="user" class="h-8 w-8 text-beige-600 mr-3"></i>
            마이페이지
        </h1>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-4 gap-8">
        <!-- 사이드바 메뉴 -->
        <div class="lg:col-span-1">
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-4 py-3 border-b border-beige-200">
                    <h2 class="font-medium text-gray-900">메뉴</h2>
                </div>
                <nav class="p-4">
                    <ul class="space-y-2">
                        <li>
                            <a href="/mypage" class="flex items-center px-3 py-2 text-sm font-medium text-beige-600 bg-beige-100 rounded-lg">
                                <i data-lucide="home" class="h-4 w-4 mr-3"></i>
                                대시보드
                            </a>
                        </li>
                        <li>
                            <a href="/mypage/orders" class="flex items-center px-3 py-2 text-sm font-medium text-gray-600 hover:text-beige-600 hover:bg-beige-100 rounded-lg transition-colors">
                                <i data-lucide="shopping-bag" class="h-4 w-4 mr-3"></i>
                                주문 내역
                            </a>
                        </li>
                        <li>
                            <a href="/mypage/profile" class="flex items-center px-3 py-2 text-sm font-medium text-gray-600 hover:text-beige-600 hover:bg-beige-100 rounded-lg transition-colors">
                                <i data-lucide="settings" class="h-4 w-4 mr-3"></i>
                                개인정보 수정
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="lg:col-span-3">
            <!-- 사용자 정보 요약 -->
            <div class="bg-white rounded-lg border border-beige-200 p-6 mb-6">
                <div class="flex items-center">
                    <div class="w-16 h-16 bg-beige-100 rounded-full flex items-center justify-center mr-6">
                        <i data-lucide="user" class="h-8 w-8 text-beige-600"></i>
                    </div>
                    <div>
                        <h2 class="text-xl font-medium text-gray-900">${user.userName}님</h2>
                        <p class="text-gray-600">${user.userEmail}</p>
                        <p class="text-sm text-gray-500 mt-1">BookHub 회원</p>
                    </div>
                </div>
            </div>

            <!-- 주문 통계 -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                <div class="bg-white rounded-lg border border-beige-200 p-6">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center mr-4">
                            <i data-lucide="shopping-bag" class="h-6 w-6 text-blue-600"></i>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-600">총 주문 수</p>
                            <p class="text-2xl font-bold text-gray-900">${totalOrders}</p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg border border-beige-200 p-6">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center mr-4">
                            <i data-lucide="check-circle" class="h-6 w-6 text-green-600"></i>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-600">완료된 주문</p>
                            <p class="text-2xl font-bold text-gray-900">
                                <c:set var="completedCount" value="0"/>
                                <c:forEach var="order" items="${recentOrders}">
                                    <c:if test="${order.orderStatusCode.orderStatusCode == 'COMPLETED'}">
                                        <c:set var="completedCount" value="${completedCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${completedCount}
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-lg border border-beige-200 p-6">
                    <div class="flex items-center">
                        <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4">
                            <i data-lucide="clock" class="h-6 w-6 text-yellow-600"></i>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-600">진행 중인 주문</p>
                            <p class="text-2xl font-bold text-gray-900">
                                <c:set var="pendingCount" value="0"/>
                                <c:forEach var="order" items="${recentOrders}">
                                    <c:if test="${order.orderStatusCode.orderStatusCode != 'COMPLETED' && order.orderStatusCode.orderStatusCode != 'CANCELLED'}">
                                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                    </c:if>
                                </c:forEach>
                                ${pendingCount}
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 최근 주문 내역 -->
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200 flex items-center justify-between">
                    <h3 class="text-lg font-medium text-gray-900">최근 주문 내역</h3>
                    <a href="/mypage/orders" class="text-sm text-beige-600 hover:text-beige-700">전체 보기</a>
                </div>
                <div class="p-6">
                    <c:choose>
                        <c:when test="${not empty recentOrders}">
                            <div class="space-y-4">
                                <c:forEach var="order" items="${recentOrders}">
                                    <div class="border border-gray-200 rounded-lg p-4 hover:bg-gray-50 transition-colors">
                                        <div class="flex items-center justify-between">
                                            <div class="flex-1">
                                                <div class="flex items-center space-x-4">
                                                    <div>
                                                        <p class="font-medium text-gray-900">주문 #${order.orderId}</p>
                                                        <p class="text-sm text-gray-600">${order.orderDate}</p>
                                                    </div>
                                                    <div>
                                                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                            <c:choose>
                                                                <c:when test='${order.orderStatusCode.orderStatusCode == "COMPLETED"}'>bg-green-100 text-green-800</c:when>
                                                                <c:when test='${order.orderStatusCode.orderStatusCode == "CANCELLED"}'>bg-red-100 text-red-800</c:when>
                                                                <c:otherwise>bg-blue-100 text-blue-800</c:otherwise>
                                                            </c:choose>">
                                                                ${order.orderStatusCode.orderStatus}
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <p class="font-medium text-gray-900">
                                                    <fmt:formatNumber value="${order.totalPrice + order.delivery.deliveryPrice}" pattern="#,###"/>원
                                                </p>
                                                <a href="/mypage/orders/${order.orderId}"
                                                   class="text-sm text-beige-600 hover:text-beige-700">상세 보기</a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-8">
                                <i data-lucide="shopping-bag" class="h-12 w-12 text-gray-300 mx-auto mb-4"></i>
                                <p class="text-gray-500 mb-4">아직 주문 내역이 없습니다.</p>
                                <a href="/" class="text-beige-600 hover:text-beige-700 font-medium">쇼핑하러 가기</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
        console.log('마이페이지 로드 완료');
    });
</script>
</body>
</html>