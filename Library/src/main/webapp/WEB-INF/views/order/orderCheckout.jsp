<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문서 작성 - BookHub</title>
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
                <li class="text-gray-900">주문서 작성</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-8">
        <h1 class="text-3xl font-light text-gray-900 flex items-center">
            <i data-lucide="credit-card" class="h-8 w-8 text-beige-600 mr-3"></i>
            주문서 작성
        </h1>
        <div class="text-sm text-gray-600">
            총 <span class="font-medium text-beige-600">${itemCount}</span>개 상품
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- 주문 상품 목록 -->
        <div class="lg:col-span-2 space-y-6">
            <!-- 주문 상품 -->
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">주문 상품</h2>
                </div>
                <div class="divide-y divide-beige-200">
                    <c:forEach items="${orderItems}" var="item">
                        <div class="p-6">
                            <div class="flex items-start space-x-4">
                                <div class="flex-shrink-0">
                                    <div class="w-20 h-28 bg-beige-100 rounded-lg flex items-center justify-center overflow-hidden">
                                        <c:choose>
                                            <c:when test="${not empty item.product and not empty item.product.imageUrl and item.product.imageUrl != '/images/no-image.png'}">
                                                <img src="${item.product.imageUrl}" alt="${item.product.productName}"
                                                     class="w-full h-full object-cover">
                                            </c:when>
                                            <c:otherwise>
                                                <i data-lucide="book" class="h-8 w-8 text-beige-600"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h3 class="text-gray-900 font-medium mb-1">${item.product.productName}</h3>
                                    <p class="text-sm text-gray-600 mb-1">${item.product.author}</p>
                                    <p class="text-sm text-gray-500 mb-3">${item.product.publisher}</p>
                                    <div class="flex items-center justify-between">
                                        <div class="text-sm text-gray-600">
                                            수량: <span class="font-medium">${item.quantity}</span>개
                                        </div>
                                        <div class="text-lg font-medium text-gray-900">
                                            <fmt:formatNumber value="${item.subtotal}" pattern="#,###"/>원
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- 배송 정보 -->
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">배송 정보</h2>
                </div>
                <div class="p-6">
                    <form id="orderForm">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">받는 분</label>
                                <input type="text" id="receiverName" value="${user.userName}"
                                       class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                       required>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-2">연락처</label>
                                <input type="text" id="receiverPhone" value="${user.userPhone}"
                                       class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                       required>
                            </div>
                        </div>
                        <div class="mb-4">
                            <label class="block text-sm font-medium text-gray-700 mb-2">배송 주소</label>
                            <textarea id="deliveryAddress" rows="3"
                                      class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                      placeholder="배송받을 주소를 입력해주세요" required>${user.userAddress}</textarea>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">배송 요청사항</label>
                            <textarea id="deliveryRequest" rows="2"
                                      class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                      placeholder="배송 시 요청사항이 있으시면 입력해주세요 (선택사항)"></textarea>
                        </div>
                    </form>
                </div>
            </div>

            <!-- 결제 방법 -->
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">결제 방법</h2>
                </div>
                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <label class="flex items-center p-4 border border-beige-300 rounded-lg cursor-pointer hover:bg-beige-100 transition-colors">
                            <input type="radio" name="paymentMethod" value="카드결제" checked
                                   class="h-4 w-4 text-beige-600 focus:ring-beige-600 border-gray-300">
                            <div class="ml-3">
                                <div class="flex items-center">
                                    <i data-lucide="credit-card" class="h-5 w-5 text-beige-600 mr-2"></i>
                                    <span class="font-medium text-gray-900">카드결제</span>
                                </div>
                            </div>
                        </label>
                        <label class="flex items-center p-4 border border-beige-300 rounded-lg cursor-pointer hover:bg-beige-100 transition-colors">
                            <input type="radio" name="paymentMethod" value="계좌이체"
                                   class="h-4 w-4 text-beige-600 focus:ring-beige-600 border-gray-300">
                            <div class="ml-3">
                                <div class="flex items-center">
                                    <i data-lucide="building" class="h-5 w-5 text-beige-600 mr-2"></i>
                                    <span class="font-medium text-gray-900">계좌이체</span>
                                </div>
                            </div>
                        </label>
                        <label class="flex items-center p-4 border border-yellow-300 rounded-lg cursor-pointer hover:bg-yellow-50 transition-colors">
                            <input type="radio" name="paymentMethod" value="카카오페이"
                                   class="h-4 w-4 text-yellow-600 focus:ring-yellow-600 border-gray-300">
                            <div class="ml-3">
                                <div class="flex items-center">
                                    <img src="https://developers.kakao.com/tool/resource/static/img/button/pay/payment_icon_yellow_small.png"
                                         alt="카카오페이" class="h-5 w-5 mr-2">
                                    <span class="font-medium text-gray-900">카카오페이</span>
                                </div>
                                <p class="text-xs text-gray-500 mt-1">간편하고 안전한 카카오페이 결제</p>
                            </div>
                        </label>
                    </div>
                </div>
            </div>
        </div>

        <!-- 주문 요약 -->
        <div class="lg:col-span-1">
            <div class="bg-white rounded-lg border border-beige-200 p-6 sticky top-8">
                <h3 class="text-lg font-medium text-gray-900 mb-6">결제 정보</h3>

                <div class="space-y-3 mb-6">
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">상품 금액 (${itemCount}개)</span>
                        <span class="font-medium"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/>원</span>
                    </div>
                    <div class="flex justify-between text-sm">
                        <span class="text-gray-600">배송비</span>
                        <span class="font-medium">
                            <c:choose>
                                <c:when test="${shippingFee == 0}">
                                    <span class="text-green-600">무료</span>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber value="${shippingFee}" pattern="#,###"/>원
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="border-t border-beige-200 pt-3">
                        <div class="flex justify-between text-lg font-medium">
                            <span>총 결제 금액</span>
                            <span class="text-beige-600"><fmt:formatNumber value="${finalTotal}" pattern="#,###"/>원</span>
                        </div>
                    </div>
                </div>

                <div class="text-xs text-gray-500 mb-6">
                    <div class="flex items-center mb-2">
                        <i data-lucide="truck" class="h-4 w-4 mr-1"></i>
                        2만원 이상 구매 시 무료배송
                    </div>
                    <div class="flex items-center">
                        <i data-lucide="shield-check" class="h-4 w-4 mr-1"></i>
                        안전한 결제 시스템
                    </div>
                </div>

                <div class="space-y-3">
                    <button onclick="submitOrder()"
                            class="w-full bg-beige-600 hover:bg-beige-700 text-white py-3 rounded-lg transition-colors font-medium">
                        <i data-lucide="lock" class="h-4 w-4 inline mr-2"></i>
                        주문하기
                    </button>
                    <button onclick="history.back()"
                            class="w-full border border-beige-300 text-gray-700 py-3 rounded-lg hover:bg-beige-100 transition-colors">
                        <i data-lucide="arrow-left" class="h-4 w-4 inline mr-2"></i>
                        이전으로
                    </button>
                </div>

                <div class="mt-4 p-3 bg-blue-50 rounded-lg">
                    <div class="text-xs text-blue-800">
                        <i data-lucide="info" class="h-4 w-4 inline mr-1"></i>
                        주문 후 취소/변경은 고객센터로 문의해주세요.
                    </div>
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
    });

    function submitOrder() {
        // 폼 유효성 검사
        const deliveryAddress = document.getElementById('deliveryAddress').value.trim();
        const receiverName = document.getElementById('receiverName').value.trim();
        const receiverPhone = document.getElementById('receiverPhone').value.trim();

        if (!deliveryAddress || !receiverName || !receiverPhone) {
            alert('필수 정보를 모두 입력해주세요.');
            return;
        }

        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;

        // 카카오페이 결제인 경우
        if (paymentMethod === '카카오페이') {
            processKakaoPayment();
            return;
        }

        // 기존 일반 주문 처리
        processNormalOrder();
    }

    function processKakaoPayment() {
        // 카카오페이 결제 처리
        const paymentData = {
            itemName: '도서 주문 (${itemCount}개)',
            quantity: ${itemCount},
            totalAmount: ${finalTotal},
            deliveryAddress: document.getElementById('deliveryAddress').value.trim(),
            deliveryRequest: document.getElementById('deliveryRequest').value.trim(),
            receiverName: document.getElementById('receiverName').value.trim(),
            receiverPhone: document.getElementById('receiverPhone').value.trim(),
            items: [
                <c:forEach var="item" items="${orderItems}" varStatus="status">
                {
                    productId: ${item.product.productId},
                    productName: '${item.product.productName}',
                    quantity: ${item.quantity},
                    unitPrice: ${item.product.productPrice},
                    subtotal: ${item.subtotal}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ]
        };

        // 로딩 상태 표시
        const submitBtn = event.target;
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i data-lucide="loader" class="h-4 w-4 inline mr-2 animate-spin"></i>카카오페이 결제 준비중...';
        submitBtn.disabled = true;

        // 카카오페이 결제 준비 요청
        fetch('/payment/kakao/ready', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(paymentData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 카카오페이 결제 페이지로 리다이렉트
                    window.location.href = data.redirectUrl;
                } else {
                    alert('카카오페이 결제 준비 중 오류가 발생했습니다: ' + data.message);
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    if (typeof lucide !== 'undefined') {
                        lucide.createIcons();
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('카카오페이 결제 준비 중 오류가 발생했습니다.');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                if (typeof lucide !== 'undefined') {
                    lucide.createIcons();
                }
            });
    }

    function processNormalOrder() {
        // 기존 일반 주문 처리 로직
        const orderData = {
            deliveryAddress: document.getElementById('deliveryAddress').value.trim(),
            deliveryRequest: document.getElementById('deliveryRequest').value.trim(),
            paymentMethod: document.querySelector('input[name="paymentMethod"]:checked').value,
            receiverName: document.getElementById('receiverName').value.trim(),
            receiverPhone: document.getElementById('receiverPhone').value.trim(),
            items: [
                <c:forEach var="item" items="${orderItems}" varStatus="status">
                {
                    productId: ${item.product.productId},
                    productName: '${item.product.productName}',
                    quantity: ${item.quantity},
                    unitPrice: ${item.product.productPrice},
                    subtotal: ${item.subtotal}
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ]
        };

        // 로딩 상태 표시
        const submitBtn = event.target;
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i data-lucide="loader" class="h-4 w-4 inline mr-2 animate-spin"></i>주문 처리중...';
        submitBtn.disabled = true;

        // 일반 주문 요청
        fetch('/order/complete', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(orderData)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('주문이 완료되었습니다!');
                    window.location.href = '/order/success/' + data.orderId;
                } else {
                    alert('주문 처리 중 오류가 발생했습니다: ' + data.message);
                    submitBtn.innerHTML = originalText;
                    submitBtn.disabled = false;
                    if (typeof lucide !== 'undefined') {
                        lucide.createIcons();
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('주문 처리 중 오류가 발생했습니다.');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
                if (typeof lucide !== 'undefined') {
                    lucide.createIcons();
                }
            });
    }
</script>
</body>
</html>