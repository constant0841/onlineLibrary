<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료 - BookHub</title>
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

        .success-animation {
            animation: checkmark 0.6s ease-in-out;
        }

        @keyframes checkmark {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
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

<main class="max-w-4xl mx-auto px-4 py-8">
    <!-- 성공 메시지 -->
    <div class="text-center mb-8">
        <div class="w-24 h-24 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6 success-animation">
            <i data-lucide="check" class="h-12 w-12 text-green-600"></i>
        </div>
        <h1 class="text-3xl font-light text-gray-900 mb-4">결제가 완료되었습니다!</h1>
        <p class="text-gray-600 text-lg">카카오페이 결제가 성공적으로 처리되었습니다.</p>
    </div>

    <!-- 결제 정보 -->
    <div class="bg-white rounded-lg border border-beige-200 overflow-hidden mb-6">
        <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
            <h2 class="text-lg font-medium text-gray-900 flex items-center">
                <i data-lucide="credit-card" class="h-5 w-5 text-beige-600 mr-2"></i>
                결제 정보
            </h2>
        </div>
        <div class="p-6">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-gray-600">주문번호</span>
                        <span class="font-medium">${orderNumber}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">결제방법</span>
                        <span class="flex items-center">
                            <img src="https://developers.kakao.com/tool/resource/static/img/button/pay/payment_icon_yellow_small.png"
                                 alt="카카오페이" class="h-4 mr-2">
                            카카오페이
                        </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">결제시간</span>
                        <span>
                            <c:choose>
                                <c:when test="${not empty paymentInfo.approved_at}">
                                    ${paymentInfo.approved_at}
                                </c:when>
                                <c:otherwise>
                                    방금 전
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                <div class="space-y-3">
                    <div class="flex justify-between">
                        <span class="text-gray-600">상품명</span>
                        <span>
                            <c:choose>
                                <c:when test="${not empty paymentInfo.item_name}">
                                    ${paymentInfo.item_name}
                                </c:when>
                                <c:otherwise>
                                    도서 주문
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">수량</span>
                        <span>
                            <c:choose>
                                <c:when test="${not empty paymentInfo.quantity}">
                                    ${paymentInfo.quantity}개
                                </c:when>
                                <c:otherwise>
                                    1개
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex justify-between text-lg font-medium">
                        <span class="text-gray-600">결제금액</span>
                        <span class="text-beige-600">
                            <c:choose>
                                <c:when test="${not empty paymentInfo.amount.total}">
                                    <fmt:formatNumber value="${paymentInfo.amount.total}" pattern="#,###"/>원
                                </c:when>
                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 카카오페이 상세 정보 (선택사항) -->
    <c:if test="${not empty paymentInfo.card_info}">
        <div class="bg-white rounded-lg border border-beige-200 overflow-hidden mb-6">
            <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                <h2 class="text-lg font-medium text-gray-900 flex items-center">
                    <i data-lucide="credit-card" class="h-5 w-5 text-beige-600 mr-2"></i>
                    카드 정보
                </h2>
            </div>
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="flex justify-between">
                        <span class="text-gray-600">카드사</span>
                        <span>${paymentInfo.card_info.kakaopay_issuer_corp}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">카드번호</span>
                        <span>****-****-****-${paymentInfo.card_info.bin}</span>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- 안내사항 -->
    <div class="bg-blue-50 border border-blue-200 rounded-lg p-6 mb-6">
        <div class="flex items-start">
            <i data-lucide="info" class="h-5 w-5 text-blue-600 mr-3 mt-0.5"></i>
            <div>
                <h3 class="font-medium text-blue-900 mb-2">안내사항</h3>
                <ul class="text-sm text-blue-800 space-y-1">
                    <li>• 결제 완료 메일이 등록하신 이메일로 발송됩니다.</li>
                    <li>• 주문 상품은 영업일 기준 2-3일 내 배송됩니다.</li>
                    <li>• 결제 관련 문의사항은 고객센터로 연락해주세요.</li>
                    <li>• 카카오페이 결제 내역은 카카오톡에서 확인 가능합니다.</li>
                </ul>
            </div>
        </div>
    </div>

    <!-- 버튼 영역 -->
    <div class="flex flex-col sm:flex-row gap-4 justify-center">
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

        // 결제 완료 후 장바구니 비우기
        sessionStorage.removeItem('cartItems');
        localStorage.removeItem('orderData');

        // 성공 애니메이션
        setTimeout(() => {
            const checkIcon = document.querySelector('.success-animation');
            if (checkIcon) {
                checkIcon.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    checkIcon.style.transform = 'scale(1)';
                }, 200);
            }
        }, 500);

        console.log('카카오페이 결제 완료 페이지 로드');
    });
</script>
</body>
</html>