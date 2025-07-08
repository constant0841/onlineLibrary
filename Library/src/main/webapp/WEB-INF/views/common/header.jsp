<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 5:38
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STANLEY - 당신에게 어울리는 색상을 찾아보세요</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'beige': {
                            50: '#FEFCF8',
                            100: '#F5F1E8',
                            200: '#E8E2D4',
                            300: '#D4C4A8',
                            400: '#C4B08A',
                            500: '#B09C6C',
                            600: '#9A8A5E',
                            700: '#7A6B47',
                            800: '#5A4F35',
                            900: '#3A3323',
                        }
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/lucide/0.263.1/lucide.min.css" rel="stylesheet">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body class="bg-beige-50">
<nav class="bg-beige-50 border-b border-beige-200 sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <!-- Logo -->
            <a href="/main" class="text-2xl font-bold text-gray-900">
                STANLEY
            </a>

            <!-- Desktop Navigation -->
            <div class="hidden md:flex items-center space-x-8">
                <a href="/main" class="text-gray-900 hover:text-beige-600 transition-colors">홈</a>

                <!-- 상품 드롭다운 메뉴 -->
                <div class="relative" onmouseenter="showDropdown()" onmouseleave="hideDropdown()">
                    <a href="/products" class="text-gray-900 hover:text-beige-600 transition-colors flex items-center gap-1">
                        상품
                        <i data-lucide="chevron-down" class="h-4 w-4 transition-transform duration-300" id="dropdown-arrow"></i>
                    </a>

                    <!-- 드롭다운 메뉴 -->
                    <div id="dropdown-menu"
                         class="absolute top-full left-0 mt-2 w-80 bg-white border border-beige-200 rounded-lg shadow-2xl transition-all duration-300 ease-out"
                         style="z-index: 9999; opacity: 0; visibility: hidden; transform: translateY(8px); pointer-events: none; display: none;"
                         onmouseenter="keepDropdownVisible()"
                         onmouseleave="hideDropdown()">
                        <div class="p-6">
                            <div class="grid grid-cols-2 gap-6">
                                <!-- 시리즈 -->
                                <div>
                                    <h3 class="font-medium text-gray-900 mb-3 pb-2 border-b border-beige-200">시리즈</h3>
                                    <ul class="space-y-2">
                                        <li><a href="/products?series=" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">CLASSIC SERIES</a></li>
                                        <li><a href="/products?series=" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">MASTER SERIES</a></li>
                                        <li><a href="/products?series=" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">GO SERIES</a></li>
                                        <li><a href="/products?series=" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">ADVENTURE SERIES</a></li>
                                    </ul>
                                </div>

                                <!-- 카테고리 -->
                                <div>
                                    <h3 class="font-medium text-gray-900 mb-3 pb-2 border-b border-beige-200">카테고리</h3>
                                    <ul class="space-y-2">
                                        <li><a href="/products?category=VACUUM BOTTLES" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">VACUUM BOTTLES</a></li>
                                        <li><a href="/products?category=MUGS + CUPS" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">MUGS + CUPS</a></li>
                                        <li><a href="/products?category=dress" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">GROWLERS + FLASKS</a></li>
                                        <li><a href="/products?category=GROWLERS + FLASKS" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">COOLERS &JUGS + FOOD CONTAINERS</a></li>
                                        <li><a href="/products?category=COOLERS &JUGS + FOOD CONTAINERS" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">TUMBLERS</a></li>
                                        <li><a href="/products?category=REPLACEMENT PARTS" class="block text-beige-600 hover:text-gray-900 hover:bg-beige-50 transition-colors text-sm py-2 px-2 rounded">REPLACEMENT PARTS</a></li>
                                    </ul>
                                </div>
                            </div>

                            <!-- 특별 메뉴 -->
                            <div class="mt-6 pt-4 border-t border-beige-200">
                                <div class="flex justify-between items-center gap-2">
                                    <a href="/products?new=" class="flex-1 text-center text-sm font-medium text-gray-900 hover:text-beige-600 transition-colors py-2 px-3 rounded-lg hover:bg-beige-50">강조하고</a>
                                    <a href="/products?sale=" class="flex-1 text-center text-sm font-medium text-red-600 hover:text-red-700 transition-colors py-2 px-3 rounded-lg hover:bg-red-50">싶은</a>
                                    <a href="/products?best=" class="flex-1 text-center text-sm font-medium text-blue-600 hover:text-blue-700 transition-colors py-2 px-3 rounded-lg hover:bg-blue-50">페이지 넣어도 돼용</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <a href="/board" class="text-gray-900 hover:text-beige-600 transition-colors">게시판</a>
            </div>

            <!-- Desktop Actions -->
            <div class="hidden md:flex items-center space-x-4">
                <a href="/cart" class="text-gray-900 hover:bg-beige-100 p-2 rounded">
                    <i data-lucide="shopping-bag" class="h-5 w-5"></i>
                </a>
                <a href="/gopage" class="text-gray-900 hover:bg-beige-100 p-2 rounded">
                    <i data-lucide="user" class="h-5 w-5"></i>
                </a>
            </div>

            <!-- Mobile menu button -->
            <div class="md:hidden">
                <button id="mobile-menu-button" class="text-gray-900 p-2">
                    <i data-lucide="menu" class="h-6 w-6"></i>
                </button>
            </div>
        </div>

        <!-- Mobile Navigation -->
        <div id="mobile-menu" class="md:hidden py-4 border-t border-beige-200 hidden">
            <div class="flex flex-col space-y-4">
                <a href="/main" class="text-gray-900 hover:text-beige-600 transition-colors">홈</a>
                <div class="space-y-2">
                    <a href="/products" class="text-gray-900 hover:text-beige-600 transition-colors font-medium">상품</a>
                    <div class="pl-4 space-y-2">
                        <a href="/products?category=clas" class="text-beige-600 hover:text-gray-900 transition-colors text-sm block">시리즈</a>
                        <a href="/products?series=adv" class="text-beige-600 hover:text-gray-900 transition-colors text-sm block">카테고리</a>
                    </div>
                </div>
                <a href="/board" class="text-gray-900 hover:text-beige-600 transition-colors">게시판</a>
                <a href="/cart" class="text-gray-900 hover:text-beige-600 transition-colors">장바구니</a>
                <a href="/gopage" class="text-gray-900 hover:text-beige-600 transition-colors">로그인</a>
            </div>
        </div>
    </div>
</nav>
<script>
    let dropdownTimeout;

    function showDropdown() {
        clearTimeout(dropdownTimeout);
        const menu = document.getElementById('dropdown-menu');
        const arrow = document.getElementById('dropdown-arrow');

        if (menu && arrow) {
            // 강제로 스타일 적용
            menu.style.opacity = '1';
            menu.style.visibility = 'visible';
            menu.style.transform = 'translateY(0)';
            menu.style.pointerEvents = 'auto';
            menu.style.display = 'block';
            arrow.style.transform = 'rotate(180deg)';
        }
    }

    function hideDropdown() {
        dropdownTimeout = setTimeout(() => {
            const menu = document.getElementById('dropdown-menu');
            const arrow = document.getElementById('dropdown-arrow');

            if (menu && arrow) {
                // 강제로 스타일 적용
                menu.style.opacity = '0';
                menu.style.visibility = 'hidden';
                menu.style.transform = 'translateY(8px)';
                menu.style.pointerEvents = 'none';
                arrow.style.transform = 'rotate(0deg)';

                // 완전히 숨기기 위해 약간의 지연 후 display none
                setTimeout(() => {
                    if (menu.style.opacity === '0') {
                        menu.style.display = 'none';
                    }
                }, 300);
            }
        }, 150);
    }

    // 드롭다운 메뉴 자체에 마우스가 올라갔을 때도 보이도록 유지
    function keepDropdownVisible() {
        clearTimeout(dropdownTimeout);
    }

    // Mobile menu toggle
    document.addEventListener('DOMContentLoaded', function() {
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const mobileMenu = document.getElementById('mobile-menu');

        if (mobileMenuButton && mobileMenu) {
            mobileMenuButton.addEventListener('click', function() {
                mobileMenu.classList.toggle('hidden');
            });
        }

        // 드롭다운 메뉴에 이벤트 리스너 추가
        const dropdownMenu = document.getElementById('dropdown-menu');
        if (dropdownMenu) {
            dropdownMenu.addEventListener('mouseenter', keepDropdownVisible);
            dropdownMenu.addEventListener('mouseleave', hideDropdown);
        }

        // Initialize Lucide icons
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });

    // 페이지 로드 후 아이콘 초기화
    window.addEventListener('load', function() {
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }
    });
</script>
</body>
</html>
