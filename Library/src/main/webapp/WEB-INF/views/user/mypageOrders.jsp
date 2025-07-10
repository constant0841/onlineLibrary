<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>주문 내역 - BookHub</title>
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
        .focus\:ring-beige-600:focus { --tw-ring-color: #8b7355; }
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
                <li class="text-gray-900">주문 내역</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
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
                            <a href="/mypage" class="flex items-center px-3 py-2 text-sm font-medium text-gray-600 hover:text-beige-600 hover:bg-beige-100 rounded-lg transition-colors">
                                <i data-lucide="home" class="h-4 w-4 mr-3"></i>
                                대시보드
                            </a>
                        </li>
                        <li>
                            <a href="/mypage/orders" class="flex items-center px-3 py-2 text-sm font-medium text-beige-600 bg-beige-100 rounded-lg">
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
            <div class="flex items-center justify-between mb-6">
                <h1 class="text-2xl font-light text-gray-900 flex items-center">
                    <i data-lucide="shopping-bag" class="h-6 w-6 text-beige-600 mr-3"></i>
                    주문 내역
                </h1>
                <p class="text-sm text-gray-600">총 ${totalOrders}개의 주문</p>
            </div>

            <!-- 필터 -->
            <div class="bg-white rounded-lg border border-beige-200 p-4 mb-6">
                <form method="get" action="/mypage/orders" class="flex flex-wrap items-center gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">주문 상태</label>
                        <select name="status" class="border border-beige-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-beige-600">
                            <option value="">전체</option>
                            <option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>대기중</option>
                            <option value="PAYMENT_CONFIRMED" ${selectedStatus == 'PAYMENT_CONFIRMED' ? 'selected' : ''}>결제완료</option>
                            <option value="PREPARING" ${selectedStatus == 'PREPARING' ? 'selected' : ''}>준비중</option>
                            <option value="SHIPPING" ${selectedStatus == 'SHIPPING' ? 'selected' : ''}>배송중</option>
                            <option value="COMPLETED" ${selectedStatus == 'COMPLETED' ? 'selected' : ''}>완료</option>
                            <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>취소</option>
                        </select>
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">시작일</label>
                        <input type="date" name="startDate" value="${startDate}"
                               class="border border-beige-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-beige-600">
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-1">종료일</label>
                        <input type="date" name="endDate" value="${endDate}"
                               class="border border-beige-300 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-beige-600">
                    </div>
                    <div class="self-end">
                        <button type="submit" class="bg-beige-600 hover:bg-beige-700 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                            <i data-lucide="search" class="h-4 w-4 inline mr-1"></i>
                            검색
                        </button>
                    </div>
                </form>
            </div>

            <!-- 주문 목록 -->
            <div class="space-y-4">
                <c:choose>
                    <c:when test="${not empty orders}">
                        <c:forEach var="order" items="${orders}">
                            <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                                <div class="p-6">
                                    <div class="flex items-center justify-between mb-4">
                                        <div class="flex items-center space-x-4">
                                            <div>
                                                <h3 class="font-medium text-gray-900">주문 #${order.orderId}</h3>
                                                <p class="text-sm text-gray-600">${order.orderDate}</p>
                                            </div>
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
                                        <div class="text-right">
                                            <p class="font-medium text-gray-900">
                                                <c:choose>
                                                    <c:when test="${not empty order.delivery and not empty order.delivery.deliveryPrice}">
                                                        <fmt:formatNumber value="${order.totalPrice + order.delivery.deliveryPrice}" pattern="#,###"/>원
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/>원
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p class="text-sm text-gray-600">${order.paymentMethod}</p>
                                        </div>
                                    </div>

                                    <div class="flex items-center justify-between">
                                        <div class="flex-1">
                                            <c:if test="${not empty order.delivery && not empty order.delivery.deliveryRequest}">
                                                <p class="text-sm text-gray-600 mb-2">
                                                    <i data-lucide="truck" class="h-4 w-4 inline mr-1"></i>
                                                        ${order.delivery.deliveryRequest}
                                                </p>
                                            </c:if>
                                        </div>
                                        <div class="flex space-x-2">
                                            <a href="/mypage/orders/${order.orderId}"
                                               class="bg-beige-600 hover:bg-beige-700 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                                상세 보기
                                            </a>
                                            <c:if test='${order.orderStatusCode.orderStatusCode != "COMPLETED" && order.orderStatusCode.orderStatusCode != "CANCELLED" && order.orderStatusCode.orderStatusCode != "SHIPPING"}'>
                                                <button onclick="cancelOrder(${order.orderId})"
                                                        class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                                                    주문 취소
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- 페이징 -->
                        <c:if test="${totalPages > 1}">
                            <div class="flex justify-center mt-8">
                                <nav class="flex items-center space-x-1">
                                    <c:if test="${currentPage > 0}">
                                        <a href="?page=${currentPage - 1}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}"
                                           class="px-3 py-2 text-sm text-gray-500 hover:text-beige-600">
                                            <i data-lucide="chevron-left" class="h-4 w-4"></i>
                                        </a>
                                    </c:if>

                                    <c:forEach begin="0" end="${totalPages - 1}" var="i">
                                        <a href="?page=${i}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}"
                                           class="px-3 py-2 text-sm ${i == currentPage ? 'bg-beige-600 text-white' : 'text-gray-500 hover:text-beige-600'} rounded">
                                                ${i + 1}
                                        </a>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages - 1}">
                                        <a href="?page=${currentPage + 1}&status=${selectedStatus}&startDate=${startDate}&endDate=${endDate}"
                                           class="px-3 py-2 text-sm text-gray-500 hover:text-beige-600">
                                            <i data-lucide="chevron-right" class="h-4 w-4"></i>
                                        </a>
                                    </c:if>
                                </nav>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-white rounded-lg border border-beige-200 p-12 text-center">
                            <i data-lucide="shopping-bag" class="h-16 w-16 text-gray-300 mx-auto mb-4"></i>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">주문 내역이 없습니다</h3>
                            <p class="text-gray-500 mb-6">아직 주문한 상품이 없습니다.</p>
                            <a href="/" class="bg-beige-600 hover:bg-beige-700 text-white px-6 py-3 rounded-lg transition-colors">
                                쇼핑하러 가기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
let selectedOrderId = null;

document.addEventListener('DOMContentLoaded', function() {
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
    console.log('주문 내역 페이지 로드 완료 - 최종 버전');
});

function cancelOrder(orderId) {
    console.log('=== cancelOrder 호출됨 ===');
    console.log('전달받은 orderId:', orderId, 'typeof:', typeof orderId);

    if (!orderId) {
        alert('주문 ID가 올바르지 않습니다.');
        return;
    }

    selectedOrderId = parseInt(orderId);
    console.log('설정된 selectedOrderId:', selectedOrderId);

    document.getElementById('cancelModal').classList.remove('hidden');
}

function closeCancelModal() {
    document.getElementById('cancelModal').classList.add('hidden');
    selectedOrderId = null;
    document.getElementById('cancelReason').value = '';
}

function confirmCancel() {
    console.log('=== confirmCancel 시작 ===');
    console.log('selectedOrderId:', selectedOrderId);

    if (!selectedOrderId) {
        alert('취소할 주문이 선택되지 않았습니다.');
        return;
    }

    const reason = document.getElementById('cancelReason').value.trim();

    // 로딩 상태 표시
    const cancelButton = document.querySelector('#cancelModal button[onclick="confirmCancel()"]');
    const originalText = cancelButton.textContent;
    cancelButton.textContent = '처리중...';
    cancelButton.disabled = true;

    // URL 구성 - 확실히 숫자로 변환
    const orderIdNumber = parseInt(selectedOrderId);
    const requestUrl = '/mypage/orders/' + orderIdNumber + '/cancel';
    console.log('요청 URL:', requestUrl);
    console.log('URL 길이:', requestUrl.length);

    // 간단한 FormData만 사용 (CSRF 제거)
    const formData = new FormData();
    formData.append('reason', reason || '고객 요청');

    console.log('FormData 준비 완료');

    fetch(requestUrl, {
        method: 'POST',
        body: formData,
        credentials: 'same-origin'
    })
        .then(response => {
            console.log('Response status:', response.status);
            console.log('Response URL:', response.url);

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
            cancelButton.textContent = originalText;
            cancelButton.disabled = false;
            closeCancelModal();
        });
}
</script>
</body>
</html>