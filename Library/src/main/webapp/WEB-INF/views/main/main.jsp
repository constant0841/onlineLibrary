<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 5:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookHub - 온라인 서점</title>
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

        /* 드롭다운 메뉴 스타일 */
        .dropdown:hover .dropdown-menu {
            display: block;
        }
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            z-index: 50;
            min-width: 200px;
            background: white;
            border: 1px solid #ede8e3;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            padding: 0.5rem 0;
        }
        .dropdown-item {
            display: block;
            padding: 0.5rem 1rem;
            color: #374151;
            text-decoration: none;
            transition: background-color 0.2s;
        }
        .dropdown-item:hover {
            background-color: #f7f5f3;
            color: #8b7355;
        }
        .dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu:hover .dropdown-submenu-content {
            display: block;
        }
        .dropdown-submenu-content {
            display: none;
            position: absolute;
            top: 0;
            left: 100%;
            min-width: 180px;
            background: white;
            border: 1px solid #ede8e3;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            padding: 0.5rem 0;
        }
    </style>
</head>
<body class="bg-white">
<!-- Header Navigation -->
<header class="bg-white shadow-sm border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <!-- Logo (홈으로 이동) -->
            <div class="flex items-center">
                <a href="/" class="text-2xl font-light text-gray-900 hover:text-beige-600 transition-colors">
                    <span class="text-beige-600">Book</span>Hub
                </a>
            </div>

            <!-- Navigation Menu -->
            <nav class="flex items-center space-x-8">
                <a href="/bestseller" class="text-gray-700 hover:text-beige-600 transition-colors">베스트셀러</a>
                <a href="/new" class="text-gray-700 hover:text-beige-600 transition-colors">신간</a>

                <!-- 카테고리 드롭다운 -->
                <div class="relative dropdown">
                    <button class="text-gray-700 hover:text-beige-600 transition-colors flex items-center">
                        카테고리
                        <i data-lucide="chevron-down" class="h-4 w-4 ml-1"></i>
                    </button>
                    <div class="dropdown-menu">
                        <!-- 문학 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/literature" class="dropdown-item flex items-center justify-between">
                                문학
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/literature/korean" class="dropdown-item">한국문학</a>
                                <a href="/category/literature/foreign" class="dropdown-item">외국문학</a>
                                <a href="/category/literature/poetry" class="dropdown-item">시/에세이</a>
                            </div>
                        </div>

                        <!-- 인문 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/humanities" class="dropdown-item flex items-center justify-between">
                                인문
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/humanities/philosophy" class="dropdown-item">철학</a>
                                <a href="/category/humanities/history" class="dropdown-item">역사</a>
                                <a href="/category/humanities/religion" class="dropdown-item">종교</a>
                            </div>
                        </div>

                        <!-- 자기계발 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/self-help" class="dropdown-item flex items-center justify-between">
                                자기계발
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/self-help/success" class="dropdown-item">성공학</a>
                                <a href="/category/self-help/psychology" class="dropdown-item">심리학</a>
                                <a href="/category/self-help/communication" class="dropdown-item">소통/관계</a>
                            </div>
                        </div>

                        <!-- 경제/경영 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/business" class="dropdown-item flex items-center justify-between">
                                경제/경영
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/business/economics" class="dropdown-item">경제학</a>
                                <a href="/category/business/management" class="dropdown-item">경영학</a>
                                <a href="/category/business/investment" class="dropdown-item">투자/재테크</a>
                            </div>
                        </div>

                        <!-- 과학/기술 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/science" class="dropdown-item flex items-center justify-between">
                                과학/기술
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/science/general" class="dropdown-item">과학일반</a>
                                <a href="/category/science/it" class="dropdown-item">컴퓨터/IT</a>
                                <a href="/category/science/medicine" class="dropdown-item">의학</a>
                            </div>
                        </div>

                        <!-- 예술/취미 카테고리 -->
                        <div class="dropdown-submenu">
                            <a href="/category/arts" class="dropdown-item flex items-center justify-between">
                                예술/취미
                                <i data-lucide="chevron-right" class="h-4 w-4"></i>
                            </a>
                            <div class="dropdown-submenu-content">
                                <a href="/category/arts/art" class="dropdown-item">예술일반</a>
                                <a href="/category/arts/music" class="dropdown-item">음악</a>
                                <a href="/category/arts/hobby" class="dropdown-item">취미/실용</a>
                            </div>
                        </div>
                    </div>
                </div>

                <a href="/events" class="text-gray-700 hover:text-beige-600 transition-colors">이벤트</a>
            </nav>

            <!-- User Menu -->
            <div class="flex items-center space-x-4">
                <c:choose>
                    <c:when test="${not empty sessionScope.userEmail}">
                        <!-- 로그인된 사용자 메뉴 -->
                        <div class="flex items-center space-x-3">
                            <a href="/cart" class="flex items-center text-gray-700 hover:text-beige-600 transition-colors">
                                <i data-lucide="shopping-cart" class="h-5 w-5 mr-1"></i>
                                장바구니
                            </a>
                            <a href="/mypage" class="flex items-center text-gray-700 hover:text-beige-600 transition-colors">
                                <i data-lucide="user" class="h-5 w-5 mr-1"></i>
                                마이페이지
                            </a>
                            <a href="/logout" class="flex items-center text-gray-700 hover:text-beige-600 transition-colors">
                                <i data-lucide="log-out" class="h-5 w-5 mr-1"></i>
                                로그아웃
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 비로그인 사용자 메뉴 -->
                        <div class="flex items-center space-x-3">
                            <a href="/login" class="flex items-center text-gray-700 hover:text-beige-600 transition-colors">
                                <i data-lucide="log-in" class="h-5 w-5 mr-1"></i>
                                로그인
                            </a>
                            <a href="/register" class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg transition-colors">
                                회원가입
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<main>
    <!-- Hero Section -->
    <section class="relative h-screen flex items-center justify-center bg-gradient-to-r beige-100" style="background: linear-gradient(to right, #f7f5f3, #ede8e3);">
        <div class="text-center max-w-4xl mx-auto px-4">
            <h1 class="text-5xl md:text-7xl font-light text-gray-900 mb-6">
                BookHub<br>
                <span class="text-beige-600">온라인 서점</span>
            </h1>
            <p class="text-xl text-beige-700 mb-8 max-w-2xl mx-auto">
                새로운 지식과의 만남부터 감동적인 이야기까지, 당신의 모든 독서 여행을 함께합니다
            </p>
            <div class="flex gap-4 justify-center">
                <a href="/bestseller" class="bg-gray-900 hover:bg-beige-800 text-white px-8 py-3 rounded-lg flex items-center gap-2 transition-colors">
                    베스트셀러 보기
                    <i data-lucide="arrow-right" class="h-5 w-5"></i>
                </a>
                <a href="/new" class="border border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white px-8 py-3 rounded-lg transition-colors">
                    신간 도서
                </a>
            </div>
        </div>
    </section>

    <!-- Featured Books -->
    <section class="py-16 px-4">
        <div class="max-w-7xl mx-auto">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-light text-gray-900 mb-4">이달의 추천 도서</h2>
                <p class="text-beige-600 max-w-2xl mx-auto">편집부가 엄선한 베스트셀러와 화제의 신간을 만나보세요</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                <!-- Book 1 -->
                <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                    <div class="relative overflow-hidden">
                        <img src="https://image.yes24.com/goods/124831026/M"
                             alt="트렌드 코리아 2025"
                             class="w-full h-80 object-cover group-hover:scale-105 transition-transform duration-500">
                        <div class="absolute top-4 left-4">
                            <span class="bg-red-500 text-white px-2 py-1 text-xs rounded">베스트</span>
                        </div>
                        <div class="absolute top-4 right-4">
                            <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                <span class="text-xs font-medium">4.8</span>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors">
                            트렌드 코리아 2025
                        </h3>
                        <p class="text-sm text-beige-600 mb-2">김난도 외 9명</p>
                        <div class="flex items-center gap-2 mb-3">
                            <span class="text-xl font-light text-gray-900">₩16,200</span>
                            <span class="text-sm text-gray-500 line-through">₩18,000</span>
                            <span class="text-sm text-red-500">10%</span>
                        </div>
                        <button class="w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-2 rounded opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                            상세보기
                        </button>
                    </div>
                </div>

                <!-- Book 2 -->
                <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                    <div class="relative overflow-hidden">
                        <img src="https://image.yes24.com/goods/123552628/M"
                             alt="불편한 편의점"
                             class="w-full h-80 object-cover group-hover:scale-105 transition-transform duration-500">
                        <div class="absolute top-4 left-4">
                            <span class="bg-gray-900 text-white px-2 py-1 text-xs rounded">신간</span>
                        </div>
                        <div class="absolute top-4 right-4">
                            <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                <span class="text-xs font-medium">4.9</span>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors">
                            불편한 편의점
                        </h3>
                        <p class="text-sm text-beige-600 mb-2">김호연</p>
                        <div class="flex items-center gap-2 mb-3">
                            <span class="text-xl font-light text-gray-900">₩13,500</span>
                            <span class="text-sm text-gray-500 line-through">₩15,000</span>
                            <span class="text-sm text-red-500">10%</span>
                        </div>
                        <button class="w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-2 rounded opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                            상세보기
                        </button>
                    </div>
                </div>

                <!-- Book 3 -->
                <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                    <div class="relative overflow-hidden">
                        <img src="https://image.yes24.com/goods/119470174/M"
                             alt="세이노의 가르침"
                             class="w-full h-80 object-cover group-hover:scale-105 transition-transform duration-500">
                        <div class="absolute top-4 left-4">
                            <span class="bg-yellow-500 text-white px-2 py-1 text-xs rounded">화제</span>
                        </div>
                        <div class="absolute top-4 right-4">
                            <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                <span class="text-xs font-medium">4.7</span>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors">
                            세이노의 가르침
                        </h3>
                        <p class="text-sm text-beige-600 mb-2">세이노</p>
                        <div class="flex items-center gap-2 mb-3">
                            <span class="text-xl font-light text-gray-900">₩6,480</span>
                            <span class="text-sm text-gray-500 line-through">₩7,200</span>
                            <span class="text-sm text-red-500">10%</span>
                        </div>
                        <button class="w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-2 rounded opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                            상세보기
                        </button>
                    </div>
                </div>

                <!-- Book 4 -->
                <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                    <div class="relative overflow-hidden">
                        <img src="https://image.yes24.com/goods/124540899/M"
                             alt="아버지의 해방일지"
                             class="w-full h-80 object-cover group-hover:scale-105 transition-transform duration-500">
                        <div class="absolute top-4 right-4">
                            <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                                <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                <span class="text-xs font-medium">4.6</span>
                            </div>
                        </div>
                    </div>
                    <div class="p-6">
                        <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors">
                            아버지의 해방일지
                        </h3>
                        <p class="text-sm text-beige-600 mb-2">정지아</p>
                        <div class="flex items-center gap-2 mb-3">
                            <span class="text-xl font-light text-gray-900">₩13,500</span>
                            <span class="text-sm text-gray-500 line-through">₩15,000</span>
                            <span class="text-sm text-red-500">10%</span>
                        </div>
                        <button class="w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-2 rounded opacity-0 group-hover:opacity-100 transition-opacity duration-300">
                            상세보기
                        </button>
                    </div>
                </div>
            </div>

            <div class="text-center mt-12">
                <a href="/books" class="border border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white px-8 py-3 rounded-lg flex items-center gap-2 mx-auto transition-colors">
                    전체 도서 보기
                    <i data-lucide="arrow-right" class="h-5 w-5"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- Special Offer -->
    <section class="py-16" style="background: linear-gradient(to right, #ede8e3, #e3ddd6);">
        <div class="max-w-4xl mx-auto text-center px-4">
            <h2 class="text-4xl font-light text-gray-900 mb-4">2025 북 어워드 특별전</h2>
            <p class="text-xl text-beige-700 mb-8">올해의 책들을 만나보세요</p>
            <div class="flex justify-center gap-4">
                <a href="/events/book-award" class="bg-gray-900 hover:bg-beige-800 text-white px-8 py-3 rounded-lg transition-colors">
                    특별전 보기
                </a>
            </div>
        </div>
    </section>

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
</main>

<script>
    // Lucide 아이콘 초기화를 페이지 로드 후 실행
    document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });
</script>
</body>
</html>