<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 상세 - BookHub</title>
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
        .bg-beige-600 { background-color: #8b7355; }
        .bg-beige-700 { background-color: #6b5b47; }
        .bg-beige-100 { background-color: #f7f5f3; }
        .hover\:bg-beige-100:hover { background-color: #f7f5f3; }
        .hover\:bg-beige-700:hover { background-color: #6b5b47; }
        .hover\:text-beige-600:hover { color: #8b7355; }
        .hover\:text-beige-700:hover { color: #6b5b47; }
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
                <li><a href="/mypage" class="text-beige-600 hover:text-beige-700">마이페이지</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li><a href="/mypage/orders" class="text-beige-600 hover:text-beige-700">주문 내역</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">주문 상세</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-2xl font-light text-gray-900 flex items-center">
            <i data-lucide="file-text" class="h-6 w-6 text-beige-600 mr-3"></i>
            주문 상세
        </h1>
        <a href="/mypage/orders" class="text-beige-600 hover:text-beige-700 text-sm">
            <i data-lucide="arrow-left" class="h-4 w-4 inline mr-1"></i>
            주문 내역으로 돌아가기
        </a>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- 주문 정보 -->
        <div class="lg:col-span-2 space-y-6">
            <!-- 주문 기본 정보 -->
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">주문 정보</h2>
                </div>
                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <p class="text-sm font-medium text-gray-700 mb-1">주문 번호</p>
                            <p class="text-lg font-bold text-gray-900">#${order.orderId}</p>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-700 mb-1">주문 일시</p>
                            <p class="text-gray-900">${order.orderDate}</p>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-700 mb-1">주문 상태</p>
                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                <c:choose>
                                    <c:when test='${order.orderStatusCode.orderStatusCode == "COMPLETED"}'>bg-green-100 text-green-800</c:when>
                                    <c:when test='${order.orderStatusCode.orderStatusCode == "CANCELLED"}'>bg-red-100 text-red-800</c:when>
                                    <c:when test='${order.orderStatusCode.orderStatusCode == "SHIPPING"}'>bg-blue-100 text-blue-800</c:when>
                                    <c:otherwise>bg-yellow-100 text-yellow-800</c:otherwise>
                                </c:choose>">
                                ${order.orderStatusCode.orderStatus}
                            </span>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-700 mb-1">결제 방법</p>
                            <p class="text-gray-900">${order.paymentMethod}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 배송 정보 -->
            <c:if test="${not empty order.delivery}">
                <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                    <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                        <h2 class="text-lg font-medium text-gray-900">배송 정보</h2>
                    </div>
                    <div class="p-6">
                        <div class="space-y-4">
                            <c:if test="${not empty order.delivery.deliveryRequest}">
                                <div>
                                    <p class="text-sm font-medium text-gray-700 mb-1">배송 요청사항</p>
                                    <p class="text-gray-900">${order.delivery.deliveryRequest}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty order.delivery.deliveryPrice}">
                                <div>
                                    <p class="text-sm font-medium text-gray-700 mb-1">배송비</p>
                                    <p class="text-gray-900">
                                        <fmt:formatNumber value="${order.delivery.deliveryPrice}" pattern="#,###"/>원
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- 결제 정보 -->
        <div class="lg:col-span-1">
            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">결제 정보</h2>
                </div>
                <div class="p-6">
                    <div class="space-y-4">
                        <div class="flex justify-between">
                            <span class="text-gray-600">상품 금액</span>
                            <span class="text-gray-900">
                                <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>원
                            </span>
                        </div>
                        <c:if test="${not empty order.delivery and not empty order.delivery.deliveryPrice}">
                            <div class="flex justify-between">
                                <span class="text-gray-600">배송비</span>
                                <span class="text-gray-900">
                                    <fmt:formatNumber value="${order.delivery.deliveryPrice}" pattern="#,###"/>원
                                </span>
                            </div>
                        </c:if>
                        <div class="border-t border-gray-200 pt-4">
                            <div class="flex justify-between">
                                <span class="text-lg font-medium text-gray-900">총 결제 금액</span>
                                <span class="text-lg font-bold text-gray-900">
                                    <c:choose>
                                        <c:when test="${not empty order.delivery and not empty order.delivery.deliveryPrice}">
                                            <fmt:formatNumber value="${order.totalPrice + order.delivery.deliveryPrice}" pattern="#,###"/>원
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>원
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>

                    <c:if test="${canCancel}">
                        <div class="mt-6 pt-6 border-t border-gray-200">
                            <button onclick="showCancelModal()"
                                    class="w-full bg-red-600 hover:bg-red-700 text-white py-3 px-4 rounded-lg font-medium transition-colors">
                                <i data-lucide="x-circle" class="h-4 w-4 inline mr-2"></i>
                                주문 취소
                            </button>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- 주문 취소 모달 -->
<div id="cancelModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 hidden z-50">
    <div class="flex items-center justify-center min-h-screen p-4">
        <div class="bg-white rounded-lg max-w-md w-full p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">주문 취소</h3>
            <p class="text-sm text-gray-600 mb-4">정말로 이 주문을 취소하시겠습니까?</p>

            <div class="mb-4">
                <label class="block text-sm font-medium text-gray-700 mb-2">취소 사유</label>
                <textarea id="cancelReason" rows="3"
                          class="w-full border border-gray-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-beige-600"
                          placeholder="취소 사유를 입력해주세요 (선택사항)"></textarea>
            </div>

            <div class="flex space-x-3">
                <button onclick="confirmCancel()"
                        class="flex-1 bg-red-600 hover:bg-red-700 text-white py-2 px-4 rounded-lg text-sm transition-colors">
                    취소하기
                </button>
                <button onclick="closeCancelModal()"
                        class="flex-1 bg-gray-300 hover:bg-gray-400 text-gray-700 py-2 px-4 rounded-lg text-sm transition-colors">
                    닫기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
        console.log('주문 상세 페이지 로드 완료');
    });

    function showCancelModal() {
        document.getElementById('cancelModal').classList.remove('hidden');
    }

    function closeCancelModal() {
        document.getElementById('cancelModal').classList.add('hidden');
        document.getElementById('cancelReason').value = '';
    }

    function confirmCancel() {
        if (!orderIdToCancel) {
            alert('취소할 주문이 선택되지 않았습니다.');
            return;
        }

        const reason = document.getElementById('cancelReason').value.trim();

        // 로딩 상태 표시
        const cancelButton = document.querySelector('#cancelModal button[onclick="confirmCancel()"]');
        if (!cancelButton) {
            console.error('Cancel button not found');
            return;
        }

        const originalText = cancelButton.textContent;
        cancelButton.textContent = '처리중...';
        cancelButton.disabled = true;

        console.log('주문 취소 요청:', {
            orderId: orderIdToCancel,
            reason: reason || '고객 요청'
        });

        fetch(`/mypage/orders/${orderIdToCancel}/cancel`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-Requested-With': 'XMLHttpRequest'
            },
            credentials: 'same-origin', // 세션 쿠키 포함
            body: JSON.stringify({
                reason: reason || '고객 요청'
            })
        })
            .then(response => {
                console.log('Response status:', response.status);
                console.log('Response headers:', response.headers);

                // 응답이 JSON인지 확인
                const contentType = response.headers.get('content-type');
                if (!contentType || !contentType.includes('application/json')) {
                    throw new Error('서버에서 JSON 응답을 받지 못했습니다.');
                }

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                return response.json();
            })
            .then(data => {
                console.log('Response data:', data);

                if (data && data.success === true) {
                    alert('주문이 취소되었습니다.');
                    location.reload();
                } else {
                    const errorMessage = data && data.message ? data.message : '알 수 없는 오류가 발생했습니다.';
                    alert('주문 취소 실패: ' + errorMessage);
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
                alert('주문 취소 중 오류가 발생했습니다: ' + error.message);
            })
            .finally(() => {
                // 버튼 상태 복구
                if (cancelButton) {
                    cancelButton.textContent = originalText;
                    cancelButton.disabled = false;
                }
                closeCancelModal();
            });
    }
</script>
</body>
</html>