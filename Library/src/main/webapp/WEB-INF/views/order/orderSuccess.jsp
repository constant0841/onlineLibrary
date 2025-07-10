<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 완료 - BookHub</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <style>
        .beige-100 { background-color: #f7f5f3; }
        .beige-200 { background-color: #ede8e3; }
        .beige-300 { background-color: #e3ddd6; }
        .beige-600 { color: #8b7355; }
        .beige-700 { color: #6b5b47; }
        .beige-800 { background-color: #5a4a38; }
        .text-beige-600 { color: #8b7355; }
        .text-beige-700 { color: #6b5b47; }
        .border-beige-200 { border-color: #ede8e3; }
        .border-beige-300 { border-color: #e3ddd6; }
        .bg-beige-800:hover { background-color: #5a4a38; }

        .success-animation {
            animation: checkmark 0.6s ease-in-out;
        }

        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }

        .fade-in {
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
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
                <c:choose>
                    <c:when test="${not empty sessionScope.userEmail}">
                        <div class="flex items-center space-x-3">
                            <span class="text-gray-700">${sessionScope.userName}님</span>
                            <a href="/cart" class="text-beige-600 hover:text-beige-700 transition-colors">
                                <i data-lucide="shopping-cart" class="h-5 w-5"></i>
                            </a>
                            <a href="/mypage" class="text-beige-600 hover:text-beige-700 transition-colors">
                                <i data-lucide="user" class="h-5 w-5"></i>
                            </a>
                            <c:if test="${sessionScope.isAdmin}">
                                <a href="/admin" class="text-beige-600 hover:text-beige-700 transition-colors text-sm">관리자</a>
                            </c:if>
                            <a href="/logout" class="text-gray-500 hover:text-beige-600 transition-colors">
                                <i data-lucide="log-out" class="h-5 w-5"></i>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center space-x-3">
                            <a href="/login" class="text-beige-600 hover:text-beige-700 transition-colors">로그인</a>
                            <a href="/register" class="bg-beige-600 hover:bg-beige-700 text-white px-4 py-2 rounded-lg transition-colors">회원가입</a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                <li><a href="/cart" class="text-beige-600 hover:text-beige-700">장바구니</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">주문 완료</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-4xl mx-auto px-4 py-8">
    <!-- 성공 메시지 -->
    <div class="text-center mb-8 fade-in">
        <div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6 success-animation">
            <i data-lucide="check" class="h-12 w-12 text-green-600"></i>
        </div>
        <h1 class="text-3xl font-light text-gray-900 mb-4">주문이 완료되었습니다!</h1>
        <p class="text-gray-600 text-lg">주문해 주셔서 감사합니다. 빠른 시일 내에 배송해드리겠습니다.</p>
    </div>

    <!-- 주문 정보 -->
    <div class="bg-white rounded-lg border border-beige-200 overflow-hidden mb-6 fade-in">
        <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
            <h2 class="text-lg font-medium text-gray-900 flex items-center">
                <i data-lucide="receipt" class="h-5 w-5 text-beige-600 mr-2"></i>
                주문 정보
            </h2>
        </div>
        <div class="p-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-gray-600">주문번호</span>
                        <span class="font-medium">${order.orderId}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">주문일시</span>
                        <span>
                            <c:choose>
                                <c:when test="${not empty orderDate}">
                                    <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd"/>
                                </c:when>
                                <c:otherwise>
                                    ${order.orderDate}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">결제방법</span>
                        <span>${order.paymentMethod}</span>
                    </div>
                </div>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-gray-600">주문상태</span>
                        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                            ${order.orderStatusCode.orderStatus}
                        </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">총 결제금액</span>
                        <span class="text-lg font-medium text-beige-600">
                            <fmt:formatNumber value="${order.totalPrice + order.delivery.deliveryPrice}" pattern="#,###"/>원
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 배송 정보 -->
    <c:if test="${not empty order.delivery}">
        <div class="bg-white rounded-lg border border-beige-200 overflow-hidden mb-6 fade-in">
            <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                <h2 class="text-lg font-medium text-gray-900 flex items-center">
                    <i data-lucide="truck" class="h-5 w-5 text-beige-600 mr-2"></i>
                    배송 정보
                </h2>
            </div>
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h3 class="font-medium text-gray-900 mb-2">배송 상태</h3>
                        <p class="text-gray-600">${order.delivery.orderStatusCode.orderStatus}</p>
                    </div>
                    <div>
                        <h3 class="font-medium text-gray-900 mb-2">배송비</h3>
                        <p class="text-gray-600">
                            <c:choose>
                                <c:when test="${order.delivery.deliveryPrice == 0}">
                                    <span class="text-green-600 font-medium">무료배송</span>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${order.delivery.deliveryPrice}" pattern="#,###"/>원
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
                <c:if test="${not empty order.delivery.deliveryRequest}">
                    <div class="mt-4 p-3 bg-gray-50 rounded-lg">
                        <h3 class="font-medium text-gray-900 mb-1">배송 요청사항</h3>
                        <p class="text-gray-600 text-sm">${order.delivery.deliveryRequest}</p>
                    </div>
                </c:if>
            </div>
        </div>
    </c:if>

    <!-- 주문 진행 상황 -->
    <div class="bg-white rounded-lg border border-beige-200 overflow-hidden mb-6 fade-in">
        <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
            <h2 class="text-lg font-medium text-gray-900 flex items-center">
                <i data-lucide="list-ordered" class="h-5 w-5 text-beige-600 mr-2"></i>
                주문 진행 상황
            </h2>
        </div>
        <div class="p-6">
            <div class="space-y-4">
                <div class="flex items-center">
                    <div class="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center mr-4">
                        <i data-lucide="check" class="h-4 w-4 text-white"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-medium text-gray-900">주문 완료</h3>
                        <p class="text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${not empty orderDate}">
                                    <fmt:formatDate value="${orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                                </c:when>
                                <c:otherwise>
                                    ${order.orderDate}
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </div>
                <div class="flex items-center">
                    <div class="w-8 h-8 bg-yellow-500 rounded-full flex items-center justify-center mr-4">
                        <i data-lucide="clock" class="h-4 w-4 text-white"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-medium text-gray-900">결제 확인 중</h3>
                        <p class="text-sm text-gray-600">결제 확인 후 배송 준비가 시작됩니다.</p>
                    </div>
                </div>
                <div class="flex items-center opacity-50">
                    <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center mr-4">
                        <i data-lucide="package" class="h-4 w-4 text-white"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-medium text-gray-900">배송 준비</h3>
                        <p class="text-sm text-gray-600">상품 포장 및 배송 준비</p>
                    </div>
                </div>
                <div class="flex items-center opacity-50">
                    <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center mr-4">
                        <i data-lucide="truck" class="h-4 w-4 text-white"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-medium text-gray-900">배송 중</h3>
                        <p class="text-sm text-gray-600">고객님께 배송 중입니다.</p>
                    </div>
                </div>
                <div class="flex items-center opacity-50">
                    <div class="w-8 h-8 bg-gray-300 rounded-full flex items-center justify-center mr-4">
                        <i data-lucide="home" class="h-4 w-4 text-white"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="font-medium text-gray-900">배송 완료</h3>
                        <p class="text-sm text-gray-600">상품이 안전하게 도착했습니다.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 안내사항 -->
    <div class="bg-blue-50 border border-blue-200 rounded-lg p-6 mb-6 fade-in">
        <div class="flex items-start">
            <i data-lucide="info" class="h-5 w-5 text-blue-600 mr-3 mt-0.5"></i>
            <div>
                <h3 class="font-medium text-blue-900 mb-2">안내사항</h3>
                <ul class="text-sm text-blue-800 space-y-1">
                    <li>• 주문 확인 메일이 등록하신 이메일로 발송됩니다.</li>
                    <li>• 배송은 영업일 기준 2-3일 소요됩니다.</li>
                    <li>• 주문 취소는 배송 준비 전까지만 가능합니다.</li>
                    <li>• 문의사항이 있으시면 고객센터로 연락해주세요.</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="flex flex-col sm:flex-row gap-4 justify-center fade-in">
        <a href="/mypage/orders"
           class="inline-flex items-center justify-center px-6 py-3 border border-transparent text-base font-medium rounded-lg text-white bg-beige-600 hover:bg-beige-700 transition-colors">
            <i data-lucide="list" class="h-5 w-5 mr-2"></i>
            주문 내역 보기
        </a>
        <a href="/"
           class="inline-flex items-center justify-center px-6 py-3 border border-beige-300 text-base font-medium rounded-lg text-gray-700 bg-white hover:bg-beige-100 transition-colors">
            <i data-lucide="home" class="h-5 w-5 mr-2"></i>
            홈으로 가기
        </a>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // 주문 정보를 로컬 스토리지에서 제거 (있다면)
        localStorage.removeItem('orderData');
        sessionStorage.removeItem('cartItems');

        // 성공 애니메이션 트리거
        setTimeout(() => {
            const elements = document.querySelectorAll('.fade-in');
            elements.forEach((el, index) => {
                setTimeout(() => {
                    el.style.opacity = '1';
                    el.style.transform = 'translateY(0)';
                }, index * 200);
            });
        }, 100);
    });
</script>
</body>
</html>