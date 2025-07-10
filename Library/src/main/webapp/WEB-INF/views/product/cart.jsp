<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니 - BookHub</title>
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

        .quantity-input {
            -moz-appearance: textfield;
        }
        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
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

            <div class="flex-1 max-w-lg mx-8">
                <form action="/" method="get" class="relative">
                    <input type="text" name="keyword"
                           placeholder="책 제목, 저자, 출판사를 검색하세요..."
                           class="w-full px-4 py-2 pl-10 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent">
                    <button type="submit" class="absolute left-3 top-1/2 transform -translate-y-1/2 text-beige-600">
                        <i data-lucide="search" class="h-4 w-4"></i>
                    </button>
                </form>
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
                <li class="text-gray-900">장바구니</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="flex items-center justify-between mb-8">
        <h1 class="text-3xl font-light text-gray-900 flex items-center">
            <i data-lucide="shopping-cart" class="h-8 w-8 text-beige-600 mr-3"></i>
            장바구니
        </h1>
        <%-- cartItems는 CartController에서 Model에 추가한 이름입니다. --%>
        <c:if test="${not empty cartItems}">
            <div class="text-sm text-gray-600">
                총 <span class="font-medium text-beige-600">${cartItems.size()}</span>개 상품 <%-- cartItems 리스트의 크기 --%>
            </div>
        </c:if>
    </div>

    <%-- cartItems는 CartController에서 Model에 추가한 이름입니다. --%>
    <c:choose>
        <c:when test="${not empty cartItems}">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
                <div class="lg:col-span-2">
                    <div class="bg-white rounded-lg border border-beige-200 overflow-hidden">
                        <div class="bg-beige-100 px-6 py-4 border-b border-beige-200">
                            <div class="flex items-center justify-between">
                                <label class="flex items-center">
                                    <input type="checkbox" id="selectAll"
                                           class="rounded border-gray-300 text-beige-600 focus:ring-beige-600 focus:ring-2">
                                    <span class="ml-2 text-gray-700">전체선택</span>
                                </label>
                                <div class="flex items-center space-x-4">
                                    <button onclick="deleteSelected()"
                                            class="text-sm text-gray-500 hover:text-red-600 transition-colors">
                                        선택삭제
                                    </button>
                                    <button onclick="clearCart()"
                                            class="text-sm text-gray-500 hover:text-red-600 transition-colors">
                                        전체삭제
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="divide-y divide-beige-200">
                                <%-- item은 CartEntity 객체입니다. --%>
                            <c:forEach items="${cartItems}" var="item">
                                <%-- data-product-id는 CartEntity의 productId가 아니라 product 필드의 productId여야 합니다. --%>
                                <div class="cart-item p-6" data-product-id="${item.product.productId}">
                                    <div class="flex items-start space-x-4">
                                        <div class="flex-shrink-0 pt-2">
                                            <input type="checkbox" class="item-checkbox rounded border-gray-300 text-beige-600 focus:ring-beige-600 focus:ring-2"
                                                   data-product-id="${item.product.productId}"
                                                   data-price="${item.product.productPrice}" <%-- ProductEntity의 가격 --%>
                                                   data-quantity="${item.productCount}"> <%-- CartEntity의 상품 수량 --%>
                                        </div>

                                        <div class="flex-shrink-0">
                                            <div class="w-20 h-28 bg-beige-100 rounded-lg flex items-center justify-center overflow-hidden">
                                                    <%-- item.product가 null이 아닌지 먼저 확인합니다. --%>
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
                                            <h3 class="text-gray-900 font-medium mb-1">
                                                    <%-- item.product가 null이 아닌지 먼저 확인합니다. --%>
                                                <c:if test="${not empty item.product}">
                                                    <a href="/product/${item.product.productId}" class="hover:text-beige-600 transition-colors">
                                                            ${item.product.productName}
                                                    </a>
                                                </c:if>
                                            </h3>
                                            <p class="text-sm text-gray-600 mb-1">
                                                <c:if test="${not empty item.product}">${item.product.author}</c:if>
                                            </p>
                                            <p class="text-sm text-gray-500 mb-3">
                                                <c:if test="${not empty item.product}">${item.product.publisher}</c:if>
                                            </p>

                                            <div class="flex items-center space-x-2 mb-3">
                                                    <%-- item.productCount와 item.product.stockQuantity 사용 --%>
                                                <button onclick="updateQuantity(${item.product.productId}, ${item.productCount - 1})"
                                                        class="w-8 h-8 rounded border border-beige-300 flex items-center justify-center hover:bg-beige-100 transition-colors"
                                                    ${item.productCount <= 1 ? 'disabled' : ''}>
                                                    <i data-lucide="minus" class="h-3 w-3"></i>
                                                </button>
                                                <span class="quantity-display w-12 text-center text-sm" data-product-id="${item.product.productId}">
                                                        ${item.productCount}
                                                </span>
                                                <button onclick="updateQuantity(${item.product.productId}, ${item.productCount + 1})"
                                                        class="w-8 h-8 rounded border border-beige-300 flex items-center justify-center hover:bg-beige-100 transition-colors"
                                                    ${item.productCount >= item.product.stockQuantity ? 'disabled' : ''}>
                                                    <i data-lucide="plus" class="h-3 w-3"></i>
                                                </button>
                                            </div>

                                            <div class="flex items-center justify-between">
                                                <div class="text-lg font-medium text-gray-900">
                                                    <span class="subtotal" data-product-id="${item.product.productId}">
                                                        <%-- item.totalPrice 사용 --%>
                                                        <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/>원
                                                    </span>
                                                </div>
                                                <button onclick="removeItem(${item.product.productId})"
                                                        class="text-gray-400 hover:text-red-600 transition-colors">
                                                    <i data-lucide="trash-2" class="h-5 w-5"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="lg:col-span-1">
                    <div class="bg-white rounded-lg border border-beige-200 p-6 sticky top-8">
                        <h3 class="text-lg font-medium text-gray-900 mb-6">주문 요약</h3>

                        <div class="space-y-4 mb-6">
                            <div class="flex justify-between">
                                <span class="text-gray-600">선택된 상품</span>
                                <span id="selectedCount" class="font-medium">0개</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">상품 금액</span>
                                <span id="selectedPrice" class="font-medium">0원</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">배송비</span>
                                <span id="shippingFee" class="font-medium">0원</span>
                            </div>
                            <hr class="border-beige-200">
                            <div class="flex justify-between text-lg font-medium">
                                <span>총 결제 금액</span>
                                <span id="totalAmount" class="text-beige-600">0원</span>
                            </div>
                        </div>

                        <div class="text-xs text-gray-500 mb-4">
                            <i data-lucide="truck" class="h-4 w-4 inline mr-1"></i>
                            2만원 이상 구매 시 무료배송
                        </div>

                        <button onclick="proceedToCheckout()"
                                class="w-full bg-beige-600 hover:bg-beige-700 text-gray-700 py-3 rounded-lg transition-colors mb-3 disabled:bg-gray-300 disabled:cursor-not-allowed"
                                id="checkoutBtn" disabled>
                            선택상품 주문하기
                        </button>

                        <a href="/" class="block w-full text-center py-3 border border-beige-300 rounded-lg text-gray-700 hover:bg-beige-100 transition-colors">
                            쇼핑 계속하기
                        </a>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center py-16">
                <i data-lucide="shopping-cart" class="h-24 w-24 text-gray-300 mx-auto mb-6"></i>
                <h2 class="text-2xl font-light text-gray-900 mb-4">장바구니가 비어있습니다</h2>
                <p class="text-gray-600 mb-8">원하는 상품을 장바구니에 담아보세요.</p>
                <a href="/" class="inline-block bg-beige-600 hover:bg-beige-700 text-white px-8 py-3 rounded-lg transition-colors">
                    쇼핑하러 가기
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // 체크박스 이벤트 리스너
        setupCheckboxEvents();

        // 초기 계산
        calculateTotal();
    });

    function setupCheckboxEvents() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const itemCheckboxes = document.querySelectorAll('.item-checkbox');

        // 전체 선택 체크박스 이벤트
        selectAllCheckbox.addEventListener('change', function() {
            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
            calculateTotal();
        });

        // 개별 체크박스 이벤트
        itemCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                const allChecked = Array.from(itemCheckboxes).every(cb => cb.checked);
                const noneChecked = Array.from(itemCheckboxes).every(cb => !cb.checked);

                selectAllCheckbox.checked = allChecked;
                selectAllCheckbox.indeterminate = !allChecked && !noneChecked; // 부분 선택 시 상태

                calculateTotal();
            });
        });
    }

    function calculateTotal() {
        const selectedCheckboxes = document.querySelectorAll('.item-checkbox:checked');
        let selectedCount = 0;
        let selectedPrice = 0;

        selectedCheckboxes.forEach(checkbox => {
            const price = parseInt(checkbox.dataset.price);
            const quantity = parseInt(checkbox.dataset.quantity);
            selectedCount += quantity;
            selectedPrice += price * quantity;
        });

        const shippingFee = selectedPrice >= 20000 ? 0 : 3000;
        const totalAmount = selectedPrice + shippingFee;

        document.getElementById('selectedCount').textContent = selectedCount + '개';
        document.getElementById('selectedPrice').textContent = new Intl.NumberFormat('ko-KR').format(selectedPrice) + '원';
        document.getElementById('shippingFee').textContent = new Intl.NumberFormat('ko-KR').format(shippingFee) + '원';
        document.getElementById('totalAmount').textContent = new Intl.NumberFormat('ko-KR').format(totalAmount) + '원';

        const checkoutBtn = document.getElementById('checkoutBtn');
        if (checkoutBtn) { // null 체크 추가
            checkoutBtn.disabled = selectedCheckboxes.length === 0;
        }
    }

    function updateQuantity(productId, newQuantity) {
        if (newQuantity <= 0) {
            alert('수량은 1개 이상이어야 합니다.');
            return;
        }

        console.log(`[updateQuantity] 호출됨. 상품 ID: ${productId}, 새 수량: ${newQuantity}`); // 디버깅

        // 클라이언트 측 재고 유효성 검사 (옵션)
        // 이 부분은 서버에서 다시 한 번 검사하므로 필수는 아님.
        // UI적인 즉각적인 피드백을 위해 남겨둘 수 있습니다.
        const productDiv = document.querySelector(`[data-product-id="${productId}"].cart-item`);
        if (productDiv) {
            const plusButton = productDiv.querySelector(`button[onclick*="updateQuantity(${productId}, ${newQuantity + 1})"]`);
            if (plusButton) {
                // 'onclick' 속성에서 `item.product.stockQuantity` 값을 추출
                const onclickAttr = plusButton.getAttribute('onclick');
                const match = onclickAttr.match(/item.product.stockQuantity \? 'disabled' : ''}\)>(\d+)/); // 이전값 대신 직접 재고량 추출 시도
                let stockQuantity = 99999; // 기본값 (매우 큰 수)

                // 새로운 JSTL 변수 주입 방식에 맞게 변경
                // HTML에 data-stock-quantity를 추가하는 것이 더 좋습니다.
                // 예: <button data-stock-quantity="${item.product.stockQuantity}" ...>

                // 현재 JSP 코드 구조에서는 동적으로 stockQuantity를 가져오기 어려움
                // 따라서 서버에서 재고 부족 메시지가 오는 것에 의존하거나,
                // HTML에 data-stock-quantity="재고수량" 속성을 추가해야 합니다.

                // 임시로, 가장 정확한 방법은 서버 응답에 stockQuantity를 포함시키거나
                // 초기 로딩 시 모든 상품의 재고를 Map 형태로 JS 변수에 저장하는 것입니다.
                // 여기서는 매우 기본적인 클라이언트 측 검사만 수행합니다.

                if (newQuantity > parseInt(productDiv.querySelector('.quantity-display').textContent) && newQuantity > stockQuantity) {
                    // 이 로직은 불완전합니다. 정확한 stockQuantity를 알 수 없습니다.
                    // 실제 재고는 서버에서 검사하게 두고, 여기서 클라이언트 측 재고 검사는 제거하거나 개선하는 것이 좋습니다.
                    // alert(`재고가 부족합니다. (현재 재고: ${stockQuantity})`);
                    // return;
                }
            }
        }


        fetch('/cart/update', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                productId: productId,
                quantity: newQuantity
            })
        })
            .then(response => {
                console.log(`[updateQuantity] 서버 응답 상태: ${response.status}`); // 디버깅
                if (!response.ok) { // HTTP 상태 코드가 2xx (성공) 범위가 아니면
                    return response.json().then(errorData => {
                        throw new Error(errorData.message || '알 수 없는 오류가 발생했습니다.');
                    });
                }
                return response.json();
            })
            .then(data => {
                console.log('[updateQuantity] 파싱된 데이터:', data); // 디버깅

                if (data.success) {
                    // 페이지 새로고침
                    location.reload();
                } else {
                    alert('수량 변경에 실패했습니다: ' + data.message);
                    console.error('[updateQuantity] 서버 응답 실패:', data.message); // 서버에서 넘어온 실패 메시지
                }
            })
            .catch(error => {
                console.error('[updateQuantity] 오류 발생:', error); // fetch 또는 JSON 파싱 오류
                alert('수량 변경 중 오류가 발생했습니다: ' + error.message);
                // 에러 발생 시에도 페이지 새로고침 (DB는 변경되었을 수 있으므로)
                location.reload();
            });
    }

    function removeItem(productId) {
        if (!confirm('이 상품을 장바구니에서 제거하시겠습니까?')) {
            return;
        }

        console.log(`[removeItem] 호출됨. 상품 ID: ${productId}`); // 디버깅

        fetch('/cart/remove', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                productId: productId
            })
        })
            .then(response => {
                console.log(`[removeItem] 서버 응답 상태: ${response.status}`); // 디버깅
                if (!response.ok) {
                    return response.json().then(errorData => {
                        throw new Error(errorData.message || '알 수 없는 오류가 발생했습니다.');
                    });
                }
                return response.json();
            })
            .then(data => {
                console.log('[removeItem] 파싱된 데이터:', data); // 디버깅

                if (data.success) {
                    // 삭제 성공 시 바로 페이지 새로고침
                    location.reload();
                } else {
                    alert('상품 삭제에 실패했습니다: ' + data.message);
                    console.error('[removeItem] 서버 응답 실패:', data.message);
                }
            })
            .catch(error => {
                console.error('[removeItem] 오류 발생:', error);
                alert('상품 삭제 중 오류가 발생했습니다: ' + error.message);
                // DB는 삭제되었으므로 화면 동기화를 위해 새로고침
                location.reload();
            });
    }

    function deleteSelected() {
        const selectedCheckboxes = document.querySelectorAll('.item-checkbox:checked');

        if (selectedCheckboxes.length === 0) {
            alert('삭제할 상품을 선택해주세요.');
            return;
        }

        if (!confirm('선택한 상품들을 장바구니에서 제거하시겠습니까?')) {
            return;
        }

        const productIds = Array.from(selectedCheckboxes).map(cb => parseInt(cb.dataset.productId));
        console.log('[deleteSelected] 선택된 상품 ID:', productIds); // 디버깅

        Promise.all(productIds.map(productId =>
            fetch('/cart/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ productId: productId })
            }).then(response => {
                if (!response.ok) {
                    return response.json().then(errorData => {
                        throw new Error(errorData.message || `상품 ${productId} 삭제 중 알 수 없는 오류 발생`);
                    });
                }
                return response.json();
            })
        ))
            .then(results => {
                console.log('[deleteSelected] 모든 삭제 요청 결과:', results); // 디버깅
                const allSuccess = results.every(result => result.success);

                if (allSuccess) {
                    location.reload(); // 모든 삭제 성공 시 페이지 새로고침
                } else {
                    const failedMessages = results.filter(result => !result.success).map(result => result.message);
                    alert('일부 상품 삭제에 실패했습니다: \n' + failedMessages.join('\n'));
                    location.reload();
                }
            })
            .catch(error => {
                console.error('[deleteSelected] 오류 발생:', error);
                alert('선택 상품 삭제 중 오류가 발생했습니다: ' + error.message);
                location.reload();
            });
    }

    function clearCart() {
        if (!confirm('장바구니를 모두 비우시겠습니까?')) {
            return;
        }

        console.log('[clearCart] 호출됨.'); // 디버깅

        fetch('/cart/clear', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => {
                console.log(`[clearCart] 서버 응답 상태: ${response.status}`); // 디버깅
                if (!response.ok) {
                    return response.json().then(errorData => {
                        throw new Error(errorData.message || '알 수 없는 오류가 발생했습니다.');
                    });
                }
                return response.json();
            })
            .then(data => {
                console.log('[clearCart] 파싱된 데이터:', data); // 디버깅

                if (data.success) {
                    location.reload(); // 장바구니가 비었으니 새로고침하여 빈 화면 표시
                } else {
                    alert('장바구니 비우기에 실패했습니다: ' + data.message);
                    console.error('[clearCart] 서버 응답 실패:', data.message);
                }
            })
            .catch(error => {
                console.error('[clearCart] 오류 발생:', error);
                alert('장바구니 비우기 중 오류가 발생했습니다: ' + error.message);
                location.reload();
            });
    }

    function proceedToCheckout() {
        const selectedCheckboxes = document.querySelectorAll('.item-checkbox:checked');

        if (selectedCheckboxes.length === 0) {
            alert('주문할 상품을 선택해주세요.');
            return;
        }

        const selectedItems = Array.from(selectedCheckboxes).map(checkbox => ({
            productId: parseInt(checkbox.dataset.productId),
            quantity: parseInt(checkbox.dataset.quantity)
        }));

        // 주문 페이지로 이동 (POST 방식)
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/order/checkout';

        selectedItems.forEach((item, index) => {
            const productIdInput = document.createElement('input');
            productIdInput.type = 'hidden';
            productIdInput.name = `items[${index}].productId`;
            productIdInput.value = item.productId;
            form.appendChild(productIdInput);

            const quantityInput = document.createElement('input');
            quantityInput.type = 'hidden';
            quantityInput.name = `items[${index}].quantity`;
            quantityInput.value = item.quantity;
            form.appendChild(quantityInput);
        });

        document.body.appendChild(form);
        form.submit();
    }
</script>
</body>
</html>