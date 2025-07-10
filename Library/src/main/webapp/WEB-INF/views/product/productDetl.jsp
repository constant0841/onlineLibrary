<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.productName} - BookHub</title>
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

        .book-image {
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

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

<!-- Header -->
<header class="bg-white shadow-sm border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <!-- Logo -->
            <div class="flex items-center">
                <a href="/" class="text-2xl font-light text-gray-900 hover:text-beige-600 transition-colors">
                    <span class="text-beige-600">Book</span>Hub
                </a>
            </div>

            <!-- Search Bar -->
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

            <!-- User Menu -->
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

<!-- Breadcrumb -->
<div class="bg-white border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4 py-3">
        <nav class="flex" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="/" class="text-beige-600 hover:text-beige-700">홈</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li><a href="/?show=all" class="text-beige-600 hover:text-beige-700">전체 도서</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">${product.productName}</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-12">
        <!-- 상품 이미지 -->
        <div class="space-y-4">
            <div class="aspect-[3/4] bg-beige-100 rounded-lg flex items-center justify-center book-image overflow-hidden">
                <c:choose>
                    <c:when test="${not empty product.imageUrl and product.imageUrl != '/images/no-image.png'}">
                        <img src="${product.imageUrl}" alt="${product.productName}"
                             class="w-full h-full object-cover">
                    </c:when>
                    <c:otherwise>
                        <i data-lucide="book" class="h-32 w-32 text-beige-600"></i>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- PDF 미리보기 버튼 -->
            <c:if test="${not empty product.pdfPreviewUrl}">
                <button onclick="openPdfPreview('${product.pdfPreviewUrl}')"
                        class="w-full flex items-center justify-center px-4 py-3 border border-beige-300 rounded-lg text-beige-600 hover:bg-beige-100 transition-colors">
                    <i data-lucide="file-text" class="h-5 w-5 mr-2"></i>
                    미리보기
                </button>
            </c:if>
        </div>

        <!-- 상품 정보 -->
        <div class="space-y-6">
            <!-- 제목 및 기본 정보 -->
            <div>
                <h1 class="text-3xl font-light text-gray-900 mb-4">${product.productName}</h1>

                <div class="space-y-2 text-gray-600 mb-6">
                    <div class="flex items-center">
                        <span class="w-16 text-sm">저자</span>
                        <span class="font-medium">${product.author}</span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-16 text-sm">출판사</span>
                        <span>${product.publisher}</span>
                    </div>
                    <c:if test="${not empty product.isbn}">
                        <div class="flex items-center">
                            <span class="w-16 text-sm">ISBN</span>
                            <span>${product.isbn}</span>
                        </div>
                    </c:if>
                    <c:if test="${not empty product.productSize}">
                        <div class="flex items-center">
                            <span class="w-16 text-sm">크기</span>
                            <span>${product.productSize}</span>
                        </div>
                    </c:if>
                </div>

                <!-- 평점 및 판매지수 -->
                <div class="flex items-center space-x-6 mb-6">
                    <c:if test="${product.productRating > 0}">
                        <div class="flex items-center">
                            <div class="flex items-center mr-2">
                                <c:forEach begin="1" end="5" var="i">
                                    <i data-lucide="star" class="h-4 w-4 ${i <= product.productRating ? 'text-yellow-400 fill-yellow-400' : 'text-gray-300'}"></i>
                                </c:forEach>
                            </div>
                            <span class="text-sm text-gray-600">${product.productRating}/5</span>
                        </div>
                    </c:if>
                    <c:if test="${product.salesIndex > 0}">
                        <div class="flex items-center text-sm text-blue-600">
                            <i data-lucide="trending-up" class="h-4 w-4 mr-1"></i>
                            판매지수 ${product.salesIndex}
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- 가격 및 재고 -->
            <div class="bg-beige-100 rounded-lg p-6">
                <div class="flex items-center justify-between mb-4">
                    <span class="text-3xl font-light text-gray-900">
                        <fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원
                    </span>
                    <span class="px-3 py-1 rounded-full text-sm
                        <c:choose>
                            <c:when test='${product.salesStatus == "판매중"}'>bg-green-100 text-green-800</c:when>
                            <c:when test='${product.salesStatus == "일시품절"}'>bg-yellow-100 text-yellow-800</c:when>
                            <c:when test='${product.salesStatus == "절판"}'>bg-red-100 text-red-800</c:when>
                            <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                        </c:choose>
                    ">
                        ${product.salesStatus}
                    </span>
                </div>

                <c:if test="${product.stockQuantity > 0}">
                    <p class="text-sm text-gray-600 mb-4">재고: ${product.stockQuantity}권</p>
                </c:if>

                <!-- 수량 선택 -->
                <c:if test='${product.salesStatus == "판매중"}'>
                    <div class="mb-4">
                        <label class="block text-sm font-medium text-gray-700 mb-2">수량</label>
                        <div class="flex items-center space-x-3">
                            <button onclick="decreaseQuantity()"
                                    class="w-10 h-10 rounded-lg border border-beige-300 flex items-center justify-center hover:bg-beige-100 transition-colors">
                                <i data-lucide="minus" class="h-4 w-4"></i>
                            </button>
                            <input type="number" id="quantity" value="1" min="1" max="${product.stockQuantity}"
                                   class="quantity-input w-20 text-center border border-beige-300 rounded-lg py-2 focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent">
                            <button onclick="increaseQuantity()"
                                    class="w-10 h-10 rounded-lg border border-beige-300 flex items-center justify-center hover:bg-beige-100 transition-colors">
                                <i data-lucide="plus" class="h-4 w-4"></i>
                            </button>
                        </div>
                    </div>

                    <!-- 총 가격 -->
                    <div class="mb-4 p-3 bg-white rounded-lg">
                        <div class="flex justify-between items-center">
                            <span class="text-gray-700">총 가격:</span>
                            <span id="totalPrice" class="text-xl font-medium text-gray-900">
                                <fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>원
                            </span>
                        </div>
                    </div>
                </c:if>

                <!-- 구매 버튼들 -->
                <div class="space-y-3">
                    <c:choose>
                        <c:when test='${product.salesStatus == "판매중"}'>
                            <button onclick="addToCart(${product.productId})"
                                    class="w-full bg-beige-600 hover:bg-beige-700 text-black py-3 px-6 rounded-lg transition-colors flex items-center justify-center">
                                <i data-lucide="shopping-cart" class="h-5 w-5 mr-2"></i>
                                장바구니 담기
                            </button>
                            <button onclick="buyNow(${product.productId})"
                                    class="w-full bg-gray-900 hover:bg-beige-800 text-white py-3 px-6 rounded-lg transition-colors flex items-center justify-center">
                                <i data-lucide="credit-card" class="h-5 w-5 mr-2"></i>
                                바로 구매
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button disabled
                                    class="w-full bg-gray-300 text-gray-500 py-3 px-6 rounded-lg cursor-not-allowed">
                                현재 구매할 수 없습니다
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- 상품 설명 -->
            <div>
                <h3 class="text-lg font-medium text-gray-900 mb-4">상품 소개</h3>
                <div class="prose max-w-none text-gray-600">
                    <c:choose>
                        <c:when test="${not empty product.productDescription}">
                            <p class="whitespace-pre-line">${product.productDescription}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-500 italic">상품 설명이 없습니다.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- 관련 상품 -->
    <c:if test="${not empty relatedProducts}">
        <section class="mt-16">
            <h2 class="text-2xl font-light text-gray-900 mb-8 flex items-center">
                <i data-lucide="book-open" class="h-6 w-6 text-beige-600 mr-2"></i>
                    ${product.author}의 다른 도서
            </h2>

            <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                <c:forEach items="${relatedProducts}" var="book">
                    <div class="bg-white rounded-lg border border-beige-200 overflow-hidden hover:shadow-lg transition-shadow">
                        <a href="/product/${book.productId}" class="block">
                            <div class="aspect-[3/4] bg-beige-100 flex items-center justify-center">
                                <c:choose>
                                    <c:when test="${not empty book.imageUrl and book.imageUrl != '/images/no-image.png'}">
                                        <img src="${book.imageUrl}" alt="${book.productName}"
                                             class="w-full h-full object-cover">
                                    </c:when>
                                    <c:otherwise>
                                        <i data-lucide="book" class="h-12 w-12 text-beige-600"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="p-4">
                                <h3 class="font-medium text-gray-900 text-sm mb-2 line-clamp-2">${book.productName}</h3>
                                <p class="text-gray-600 text-xs mb-2">${book.publisher}</p>
                                <p class="text-beige-600 font-medium">
                                    <fmt:formatNumber value="${book.productPrice}" pattern="#,###"/>원
                                </p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </section>
    </c:if>
</main>

<!-- PDF 미리보기 모달 -->
<div id="pdfModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg w-full max-w-4xl h-5/6 flex flex-col">
        <div class="flex items-center justify-between p-4 border-b">
            <h3 class="text-lg font-medium">미리보기</h3>
            <button onclick="closePdfPreview()" class="text-gray-400 hover:text-gray-600">
                <i data-lucide="x" class="h-6 w-6"></i>
            </button>
        </div>
        <div class="flex-1 p-4">
            <iframe id="pdfFrame" src="" class="w-full h-full border rounded"></iframe>
        </div>
    </div>
</div>

<!-- 장바구니 추가 완료 모달 -->
<div id="cartModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg max-w-md w-full p-6">
        <div class="text-center">
            <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100 mb-4">
                <i data-lucide="check" class="h-6 w-6 text-green-600"></i>
            </div>
            <h3 class="text-lg font-medium text-gray-900 mb-2">장바구니에 추가되었습니다</h3>
            <p class="text-gray-600 mb-6">상품이 장바구니에 추가되었습니다.</p>
            <div class="flex space-x-3">
                <button onclick="closeCartModal()"
                        class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-800 py-2 px-4 rounded-lg transition-colors">
                    계속 쇼핑
                </button>
                <a href="/cart"
                   class="flex-1 bg-beige-600 hover:bg-beige-700 text-black py-2 px-4 rounded-lg transition-colors text-center">
                    장바구니 보기
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });

    const productPrice = ${product.productPrice};
    const maxQuantity = ${product.stockQuantity};

    function updateTotalPrice() {
        const quantity = parseInt(document.getElementById('quantity').value);
        const totalPrice = productPrice * quantity;
        document.getElementById('totalPrice').textContent =
            new Intl.NumberFormat('ko-KR').format(totalPrice) + '원';
    }

    function increaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        if (currentValue < maxQuantity) {
            quantityInput.value = currentValue + 1;
            updateTotalPrice();
        }
    }

    function decreaseQuantity() {
        const quantityInput = document.getElementById('quantity');
        const currentValue = parseInt(quantityInput.value);
        if (currentValue > 1) {
            quantityInput.value = currentValue - 1;
            updateTotalPrice();
        }
    }

    // 수량 입력 변경 시 총 가격 업데이트
    document.getElementById('quantity').addEventListener('input', function() {
        const value = parseInt(this.value);
        if (value < 1) this.value = 1;
        if (value > maxQuantity) this.value = maxQuantity;
        updateTotalPrice();
    });

    function addToCart(productId) {
        <c:choose>
        <c:when test="${not empty sessionScope.userEmail}">
        const quantity = parseInt(document.getElementById('quantity').value);

        // 장바구니 추가 API 호출
        fetch('/cart/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                productId: productId,
                quantity: quantity
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showCartModal();
                } else {
                    alert('장바구니 추가에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('장바구니 추가 중 오류가 발생했습니다.');
            });
        </c:when>
        <c:otherwise>
        if (confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
            window.location.href = '/login?redirect=' + encodeURIComponent(window.location.pathname);
        }
        </c:otherwise>
        </c:choose>
    }

    function buyNow(productId) {
        <c:choose>
        <c:when test="${not empty sessionScope.userEmail}">
        const quantity = parseInt(document.getElementById('quantity').value);
        // 바로 구매 - 주문 페이지로 이동
        window.location.href = '/order/direct?productId=' + productId + '&quantity=' + quantity;
        </c:when>
        <c:otherwise>
        if (confirm('로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?')) {
            window.location.href = '/login?redirect=' + encodeURIComponent(window.location.pathname);
        }
        </c:otherwise>
        </c:choose>
    }

    function showCartModal() {
        document.getElementById('cartModal').classList.remove('hidden');
    }

    function closeCartModal() {
        document.getElementById('cartModal').classList.add('hidden');
    }

    function openPdfPreview(pdfUrl) {
        document.getElementById('pdfFrame').src = pdfUrl;
        document.getElementById('pdfModal').classList.remove('hidden');
    }

    function closePdfPreview() {
        document.getElementById('pdfModal').classList.add('hidden');
        document.getElementById('pdfFrame').src = '';
    }

    // 모달 외부 클릭 시 닫기
    document.getElementById('pdfModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closePdfPreview();
        }
    });

    document.getElementById('cartModal').addEventListener('click', function(e) {
        if (e.target === this) {
            closeCartModal();
        }
    });
</script>
</body>
</html>