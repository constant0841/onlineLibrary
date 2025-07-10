<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${not empty keyword}">
                "${keyword}" 검색결과 - BookHub
            </c:when>
            <c:otherwise>
                BookHub - 온라인 서점
            </c:otherwise>
        </c:choose>
    </title>
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

        .book-card {
            transition: all 0.3s ease;
        }
        .book-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body class="bg-white">

<!-- Header Navigation -->
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
                    <input type="text" name="keyword" value="${keyword}"
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
                                <a href="/admin" class="text-beige-600 hover:text-beige-700 transition-colors text-sm border-l border-gray-300 pl-3">관리자</a>
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

<!-- Navigation -->
<nav class="bg-white border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center space-x-8 h-12">
            <a href="/" class="text-gray-700 hover:text-beige-600 transition-colors">홈</a>
            <a href="/?category=programming" class="text-gray-700 hover:text-beige-600 transition-colors">프로그래밍</a>
            <a href="/?category=business" class="text-gray-700 hover:text-beige-600 transition-colors">경제/경영</a>
            <a href="/?category=literature" class="text-gray-700 hover:text-beige-600 transition-colors">문학</a>
            <a href="/?category=science" class="text-gray-700 hover:text-beige-600 transition-colors">과학/기술</a>
            <a href="/?category=arts" class="text-gray-700 hover:text-beige-600 transition-colors">예술/취미</a>
            <a href="/?show=all" class="text-gray-700 hover:text-beige-600 transition-colors">전체보기</a>
        </div>
    </div>
</nav>

<main>
    <!-- 검색 결과 또는 상품 목록이 있을 때 -->
    <c:if test="${not empty keyword or not empty products}">
        <!-- Breadcrumb -->
        <div class="bg-white border-b border-beige-200">
            <div class="max-w-7xl mx-auto px-4 py-3">
                <nav class="flex" aria-label="Breadcrumb">
                    <ol class="flex items-center space-x-2">
                        <li><a href="/" class="text-beige-600 hover:text-beige-700">홈</a></li>
                        <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                        <li class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    "${keyword}" 검색결과
                                </c:when>
                                <c:otherwise>
                                    전체 도서
                                </c:otherwise>
                            </c:choose>
                        </li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Search Results Section -->
        <section class="py-8 px-4">
            <div class="max-w-7xl mx-auto">
                <!-- Search Results Header -->
                <div class="mb-8">
                    <c:choose>
                        <c:when test="${not empty keyword}">
                            <h1 class="text-2xl font-light text-gray-900 mb-2">
                                "${keyword}" 검색결과
                            </h1>
                            <p class="text-gray-600">
                                총 <span class="font-medium text-beige-600">${totalResults}</span>개의 도서를 찾았습니다.
                            </p>
                        </c:when>
                        <c:otherwise>
                            <h1 class="text-2xl font-light text-gray-900 mb-2">전체 도서</h1>
                            <p class="text-gray-600">
                                총 <span class="font-medium text-beige-600">${totalResults}</span>개의 도서가 있습니다.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Sort and Filter Options -->
                <div class="bg-white rounded-lg border border-beige-200 p-4 mb-6">
                    <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-4">
                            <span class="text-sm text-gray-600">정렬:</span>
                            <select id="sortSelect" onchange="changeSort()" class="border border-beige-300 rounded px-3 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-beige-600">
                                <option value="name">이름순</option>
                                <option value="price_low">가격 낮은순</option>
                                <option value="price_high">가격 높은순</option>
                                <option value="rating">평점순</option>
                                <option value="date">최신순</option>
                            </select>
                        </div>
                        <div class="text-sm text-gray-600">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    ${(currentPage-1)*pageSize + 1}-${(currentPage-1)*pageSize + products.size()}개 표시 중
                                </c:when>
                                <c:otherwise>
                                    검색 결과 없음
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Product Grid -->
                <c:choose>
                    <c:when test="${not empty products}">
                        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mb-8">
                            <c:forEach items="${products}" var="book">
                                <div class="book-card bg-white rounded-lg border border-beige-200 overflow-hidden hover:shadow-lg transition-shadow">
                                    <a href="/product/${book.productId}" class="block">
                                        <!-- Book Image -->
                                        <div class="aspect-[3/4] bg-beige-100 flex items-center justify-center overflow-hidden relative">
                                            <c:choose>
                                                <c:when test="${not empty book.imageUrl and book.imageUrl != '/images/no-image.png'}">
                                                    <img src="${book.imageUrl}" alt="${book.productName}"
                                                         class="w-full h-full object-cover hover:scale-105 transition-transform duration-300">
                                                </c:when>
                                                <c:otherwise>
                                                    <i data-lucide="book" class="h-16 w-16 text-beige-600"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${book.productRating > 0}">
                                                <div class="absolute top-4 right-4">
                                                    <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                                        <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                                        <span class="text-xs font-medium">${book.productRating}</span>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>

                                        <!-- Book Info -->
                                        <div class="p-4">
                                            <h3 class="font-medium text-gray-900 mb-2 hover:text-beige-600 transition-colors line-clamp-2">
                                                    ${book.productName}
                                            </h3>
                                            <p class="text-sm text-beige-600 mb-2">${book.author}</p>
                                            <p class="text-xs text-gray-500 mb-3">${book.publisher}</p>

                                            <!-- Price and Status -->
                                            <div class="flex items-center justify-between mb-2">
                                                <span class="text-lg font-medium text-gray-900">
                                                    <fmt:formatNumber value="${book.productPrice}" pattern="#,###"/>원
                                                </span>
                                                <c:if test="${book.productRating > 0}">
                                                    <div class="flex items-center text-xs text-gray-500">
                                                        <i data-lucide="star" class="h-3 w-3 text-yellow-400 mr-1"></i>
                                                        <span>${book.productRating}</span>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <!-- Status Badge -->
                                            <div class="flex items-center justify-between">
                                                <span class="text-xs px-2 py-1 rounded
                                                    <c:choose>
                                                        <c:when test='${book.salesStatus == "판매중"}'>bg-green-100 text-green-800</c:when>
                                                        <c:when test='${book.salesStatus == "일시품절"}'>bg-yellow-100 text-yellow-800</c:when>
                                                        <c:when test='${book.salesStatus == "절판"}'>bg-red-100 text-red-800</c:when>
                                                        <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                                    </c:choose>
                                                ">
                                                        ${book.salesStatus}
                                                </span>
                                                <c:if test="${book.salesIndex > 0}">
                                                    <span class="text-xs text-blue-600">지수 ${book.salesIndex}</span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="flex justify-center items-center space-x-2">
                                <!-- Previous Page -->
                                <c:if test="${hasPrevious}">
                                    <a href="/?keyword=${keyword}&page=${currentPage-1}"
                                       class="flex items-center px-3 py-2 border border-beige-300 rounded-lg text-beige-600 hover:bg-beige-100 transition-colors">
                                        <i data-lucide="chevron-left" class="h-4 w-4 mr-1"></i>
                                        이전
                                    </a>
                                </c:if>

                                <!-- Page Numbers -->
                                <c:forEach begin="1" end="${totalPages}" var="page">
                                    <c:choose>
                                        <c:when test="${page == currentPage}">
                                            <span class="px-3 py-2 bg-beige-600 text-white rounded-lg">${page}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="/?keyword=${keyword}&page=${page}"
                                               class="px-3 py-2 border border-beige-300 rounded-lg text-beige-600 hover:bg-beige-100 transition-colors">
                                                    ${page}
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>

                                <!-- Next Page -->
                                <c:if test="${hasNext}">
                                    <a href="/?keyword=${keyword}&page=${currentPage+1}"
                                       class="flex items-center px-3 py-2 border border-beige-300 rounded-lg text-beige-600 hover:bg-beige-100 transition-colors">
                                        다음
                                        <i data-lucide="chevron-right" class="h-4 w-4 ml-1"></i>
                                    </a>
                                </c:if>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <!-- No Results -->
                        <div class="text-center py-16">
                            <i data-lucide="search-x" class="h-16 w-16 text-gray-400 mx-auto mb-4"></i>
                            <h2 class="text-xl font-light text-gray-900 mb-2">검색 결과가 없습니다</h2>
                            <p class="text-gray-600 mb-6">
                                "${keyword}"에 대한 검색 결과를 찾을 수 없습니다.
                            </p>
                            <div class="space-y-2">
                                <p class="text-sm text-gray-500">다른 검색어를 시도해보세요:</p>
                                <ul class="text-sm text-gray-500">
                                    <li>• 단어의 철자가 정확한지 확인해보세요</li>
                                    <li>• 더 간단한 검색어를 사용해보세요</li>
                                    <li>• 다른 키워드를 시도해보세요</li>
                                </ul>
                            </div>
                            <a href="/" class="inline-block mt-6 bg-beige-600 hover:bg-beige-700 text-white px-6 py-2 rounded-lg transition-colors">
                                홈으로 돌아가기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </c:if>

    <!-- 메인 페이지 (검색 결과가 없을 때) -->
    <c:if test="${empty keyword and empty products}">
        <!-- Hero Section -->
        <section class="relative h-96 flex items-center justify-center bg-gradient-to-r beige-100" style="background: linear-gradient(to right, #f7f5f3, #ede8e3);">
            <div class="text-center max-w-4xl mx-auto px-4">
                <h1 class="text-4xl md:text-5xl font-light text-gray-900 mb-4">
                    BookHub<br>
                    <span class="text-beige-600">온라인 서점</span>
                </h1>
                <p class="text-lg text-beige-700 mb-6 max-w-2xl mx-auto">
                    <c:choose>
                        <c:when test="${totalProducts > 0}">
                            현재 ${totalProducts}권의 도서를 만나보세요
                        </c:when>
                        <c:otherwise>
                            새로운 지식과의 만남부터 감동적인 이야기까지
                        </c:otherwise>
                    </c:choose>
                </p>
                <div class="flex gap-4 justify-center">
                    <a href="/?show=all" class="bg-gray-900 hover:bg-beige-800 text-white px-6 py-2 rounded-lg flex items-center gap-2 transition-colors">
                        도서 둘러보기
                        <i data-lucide="arrow-right" class="h-4 w-4"></i>
                    </a>
                </div>
            </div>
        </section>

        <!-- 베스트셀러 섹션 -->
        <c:if test="${not empty bestSellers}">
            <section class="py-12 px-4">
                <div class="max-w-7xl mx-auto">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-2xl font-light text-gray-900 flex items-center">
                            <i data-lucide="trending-up" class="h-6 w-6 text-beige-600 mr-2"></i>
                            베스트셀러
                        </h2>
                        <a href="/?sort=sales" class="text-beige-600 hover:text-beige-700 text-sm flex items-center">
                            더보기 <i data-lucide="chevron-right" class="h-4 w-4 ml-1"></i>
                        </a>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <c:forEach items="${bestSellers}" var="book">
                            <div class="group book-card bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                                <a href="/product/${book.productId}" class="block">
                                    <div class="relative overflow-hidden">
                                        <div class="aspect-[3/4] bg-beige-100 flex items-center justify-center">
                                            <c:choose>
                                                <c:when test="${not empty book.imageUrl and book.imageUrl != '/images/no-image.png'}">
                                                    <img src="${book.imageUrl}" alt="${book.productName}"
                                                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                </c:when>
                                                <c:otherwise>
                                                    <i data-lucide="book" class="h-16 w-16 text-beige-600"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="absolute top-4 left-4">
                                            <span class="bg-red-500 text-white px-2 py-1 text-xs rounded">베스트</span>
                                        </div>
                                        <c:if test="${book.productRating > 0}">
                                            <div class="absolute top-4 right-4">
                                                <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                                    <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                                    <span class="text-xs font-medium">${book.productRating}</span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors line-clamp-2">
                                                ${book.productName}
                                        </h3>
                                        <p class="text-sm text-beige-600 mb-2">${book.author}</p>
                                        <p class="text-xs text-gray-500 mb-3">${book.publisher}</p>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-medium text-gray-900">
                                                <fmt:formatNumber value="${book.productPrice}" pattern="#,###"/>원
                                            </span>
                                            <c:if test="${book.salesIndex > 0}">
                                                <span class="text-xs text-blue-600 bg-blue-100 px-2 py-1 rounded">지수 ${book.salesIndex}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>

        <!-- 신간 도서 섹션 -->
        <c:if test="${not empty newBooks}">
            <section class="py-12 px-4 bg-gray-50">
                <div class="max-w-7xl mx-auto">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-2xl font-light text-gray-900 flex items-center">
                            <i data-lucide="clock" class="h-6 w-6 text-beige-600 mr-2"></i>
                            신간 도서
                        </h2>
                        <a href="/?sort=date" class="text-beige-600 hover:text-beige-700 text-sm flex items-center">
                            더보기 <i data-lucide="chevron-right" class="h-4 w-4 ml-1"></i>
                        </a>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <c:forEach items="${newBooks}" var="book">
                            <div class="group book-card bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                                <a href="/product/${book.productId}" class="block">
                                    <div class="relative overflow-hidden">
                                        <div class="aspect-[3/4] bg-beige-100 flex items-center justify-center">
                                            <c:choose>
                                                <c:when test="${not empty book.imageUrl and book.imageUrl != '/images/no-image.png'}">
                                                    <img src="${book.imageUrl}" alt="${book.productName}"
                                                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                </c:when>
                                                <c:otherwise>
                                                    <i data-lucide="book" class="h-16 w-16 text-beige-600"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="absolute top-4 left-4">
                                            <span class="bg-green-500 text-white px-2 py-1 text-xs rounded">신간</span>
                                        </div>
                                        <c:if test="${book.productRating > 0}">
                                            <div class="absolute top-4 right-4">
                                                <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                                    <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                                    <span class="text-xs font-medium">${book.productRating}</span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors line-clamp-2">
                                                ${book.productName}
                                        </h3>
                                        <p class="text-sm text-beige-600 mb-2">${book.author}</p>
                                        <p class="text-xs text-gray-500 mb-3">${book.publisher}</p>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-medium text-gray-900">
                                                <fmt:formatNumber value="${book.productPrice}" pattern="#,###"/>원
                                            </span>
                                            <span class="text-xs text-gray-500">${book.createdDate}</span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>

        <!-- 추천 도서 섹션 -->
        <c:if test="${not empty recommendedBooks}">
            <section class="py-12 px-4">
                <div class="max-w-7xl mx-auto">
                    <div class="flex items-center justify-between mb-8">
                        <h2 class="text-2xl font-light text-gray-900 flex items-center">
                            <i data-lucide="heart" class="h-6 w-6 text-beige-600 mr-2"></i>
                            오늘의 추천
                        </h2>
                        <a href="/?show=all" class="text-beige-600 hover:text-beige-700 text-sm flex items-center">
                            더보기 <i data-lucide="chevron-right" class="h-4 w-4 ml-1"></i>
                        </a>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <c:forEach items="${recommendedBooks}" var="book">
                            <div class="group book-card bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                                <a href="/product/${book.productId}" class="block">
                                    <div class="relative overflow-hidden">
                                        <div class="aspect-[3/4] bg-beige-100 flex items-center justify-center">
                                            <c:choose>
                                                <c:when test="${not empty book.imageUrl and book.imageUrl != '/images/no-image.png'}">
                                                    <img src="${book.imageUrl}" alt="${book.productName}"
                                                         class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                </c:when>
                                                <c:otherwise>
                                                    <i data-lucide="book" class="h-16 w-16 text-beige-600"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <c:if test="${book.productRating > 0}">
                                            <div class="absolute top-4 right-4">
                                                <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                                    <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                                    <span class="text-xs font-medium">${book.productRating}</span>
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="p-4">
                                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors line-clamp-2">
                                                ${book.productName}
                                        </h3>
                                        <p class="text-sm text-beige-600 mb-2">${book.author}</p>
                                        <p class="text-xs text-gray-500 mb-3">${book.publisher}</p>
                                        <div class="flex items-center justify-between">
                                            <span class="text-lg font-medium text-gray-900">
                                                <fmt:formatNumber value="${book.productPrice}" pattern="#,###"/>원
                                            </span>
                                            <span class="text-xs text-orange-600 bg-orange-100 px-2 py-1 rounded">추천</span>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </c:if>

        <!-- 상품이 없을 때 메시지 -->
        <c:if test="${empty bestSellers and empty newBooks and empty recommendedBooks}">
            <section class="py-16 px-4">
                <div class="max-w-4xl mx-auto text-center">
                    <i data-lucide="book-x" class="h-16 w-16 text-gray-400 mx-auto mb-4"></i>
                    <h2 class="text-2xl font-light text-gray-900 mb-4">등록된 상품이 없습니다</h2>
                    <p class="text-gray-600 mb-8">관리자가 상품을 등록하면 여기에 표시됩니다.</p>
                    <c:if test="${sessionScope.isAdmin}">
                        <a href="/admin/product" class="bg-beige-600 hover:bg-beige-700 text-white px-6 py-3 rounded-lg transition-colors">
                            상품 등록하러 가기
                        </a>
                    </c:if>
                </div>
            </section>
        </c:if>

        <!-- Features -->
        <section class="py-16 bg-white">
            <div class="max-w-7xl mx-auto px-4">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="text-center">
                        <div class="w-16 h-16 beige-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i data-lucide="truck" class="h-8 w-8 text-gray-900"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">무료 배송</h3>
                        <p class="text-beige-600">2만원 이상 구매 시 전국 무료배송</p>
                    </div>
                    <div class="text-center">
                        <div class="w-16 h-16 beige-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i data-lucide="book-open" class="h-8 w-8 text-gray-900"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">미리보기</h3>
                        <p class="text-beige-600">구매 전 책의 일부를 미리 읽어보세요</p>
                    </div>
                    <div class="text-center">
                        <div class="w-16 h-16 beige-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i data-lucide="star" class="h-8 w-8 text-gray-900"></i>
                        </div>
                        <h3 class="text-lg font-medium text-gray-900 mb-2">리뷰 시스템</h3>
                        <p class="text-beige-600">독자들의 생생한 리뷰와 평점</p>
                    </div>
                </div>
            </div>
        </section>
    </c:if>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });

    function changeSort() {
        const sortValue = document.getElementById('sortSelect').value;
        const currentUrl = new URL(window.location);
        currentUrl.searchParams.set('sort', sortValue);
        currentUrl.searchParams.set('page', '1'); // Reset to first page
        window.location.href = currentUrl.toString();
    }
</script>
</body>
</html>