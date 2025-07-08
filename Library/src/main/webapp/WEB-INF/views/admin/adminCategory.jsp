<%--
  관리자 카테고리 관리 화면
  URL: /admin/category
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookHub 관리자 - 카테고리 관리</title>
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
<!-- Admin Header -->
<header class="bg-white shadow-sm border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <!-- Admin Logo -->
            <div class="flex items-center">
                <a href="/admin" class="text-2xl font-light text-gray-900 hover:text-beige-600 transition-colors">
                    <span class="text-beige-600">Book</span>Hub <span class="text-sm text-gray-500">관리자</span>
                </a>
            </div>

            <!-- Admin Navigation -->
            <nav class="flex items-center space-x-6">
                <a href="/admin/product" class="text-gray-700 hover:text-beige-600 transition-colors">상품 관리</a>
                <a href="/admin/category" class="text-beige-600 font-medium">카테고리 관리</a>
                <a href="/admin/order" class="text-gray-700 hover:text-beige-600 transition-colors">주문 관리</a>
                <a href="/admin/member" class="text-gray-700 hover:text-beige-600 transition-colors">회원 관리</a>
                <a href="/admin/stock" class="text-gray-700 hover:text-beige-600 transition-colors">재고 관리</a>
            </nav>

            <!-- User Menu -->
            <div class="flex items-center space-x-3">
                <a href="/" class="text-gray-700 hover:text-beige-600 transition-colors">
                    <i data-lucide="external-link" class="h-5 w-5 mr-1 inline"></i>
                    사용자 화면
                </a>
                <a href="/logout" class="text-gray-700 hover:text-beige-600 transition-colors">
                    <i data-lucide="log-out" class="h-5 w-5 mr-1 inline"></i>
                    로그아웃
                </a>
            </div>
        </div>
    </div>
</header>

<!-- Breadcrumb -->
<div class="bg-white border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4 py-3">
        <nav class="flex" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="/admin" class="text-beige-600 hover:text-beige-700">관리자</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">카테고리 관리</li>
            </ol>
        </nav>
    </div>
</div>

<!-- Main Content -->
<main class="max-w-6xl mx-auto px-4 py-8">
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">

        <!-- Left: Category Registration -->
        <div class="bg-white shadow-sm rounded-lg border border-beige-200">
            <div class="px-6 py-4 border-b border-beige-200">
                <h2 class="text-xl font-light text-gray-900 flex items-center">
                    <i data-lucide="plus-circle" class="h-5 w-5 mr-2 text-beige-600"></i>
                    카테고리 등록
                </h2>
            </div>

            <form id="categoryForm" class="p-6">
                <!-- 카테고리 ID -->
                <div class="mb-4">
                    <label for="category_id" class="block text-sm font-medium text-gray-700 mb-2">카테고리 ID *</label>
                    <input type="text" id="category_id" name="category_id" required
                           class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                           placeholder="예: literature, business"
                           pattern="[a-z_]+"
                           title="영문 소문자와 언더스코어만 사용 가능">
                    <p class="text-xs text-gray-500 mt-1">영문 소문자와 언더스코어(_)만 사용 가능</p>
                </div>

                <!-- 카테고리 명 -->
                <div class="mb-4">
                    <label for="category_name" class="block text-sm font-medium text-gray-700 mb-2">카테고리 명 *</label>
                    <input type="text" id="category_name" name="category_name" required
                           class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                           placeholder="예: 문학, 경제/경영">
                </div>

                <!-- 버튼 -->
                <div class="flex space-x-3">
                    <button type="submit"
                            class="flex-1 bg-gray-900 hover:bg-beige-800 text-white py-2 px-4 rounded-lg transition-colors">
                        <i data-lucide="plus" class="h-4 w-4 mr-1 inline"></i>
                        등록
                    </button>
                    <button type="button" onclick="clearForm()"
                            class="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors">
                        <i data-lucide="refresh-ccw" class="h-4 w-4 mr-1 inline"></i>
                        초기화
                    </button>
                </div>
            </form>
        </div>

        <!-- Right: Category List -->
        <div class="bg-white shadow-sm rounded-lg border border-beige-200">
            <div class="px-6 py-4 border-b border-beige-200">
                <h2 class="text-xl font-light text-gray-900 flex items-center">
                    <i data-lucide="list" class="h-5 w-5 mr-2 text-beige-600"></i>
                    카테고리 목록
                </h2>
            </div>

            <div class="p-6">
                <!-- 카테고리가 없을 때 -->
                <div id="empty-state" class="text-center py-8">
                    <i data-lucide="folder-x" class="h-12 w-12 text-gray-400 mx-auto mb-3"></i>
                    <p class="text-gray-500">등록된 카테고리가 없습니다.</p>
                    <p class="text-sm text-gray-400">좌측에서 카테고리를 등록해주세요.</p>
                </div>

                <!-- 카테고리 목록 -->
                <div id="category-list" class="space-y-2 hidden">
                    <!-- 동적으로 생성될 카테고리 목록 -->
                </div>
            </div>
        </div>
    </div>

    <!-- 기본 카테고리 등록 도우미 -->
    <div class="mt-8 bg-white shadow-sm rounded-lg border border-beige-200">
        <div class="px-6 py-4 border-b border-beige-200">
            <h3 class="text-lg font-medium text-gray-900 flex items-center">
                <i data-lucide="zap" class="h-5 w-5 mr-2 text-beige-600"></i>
                빠른 카테고리 등록
            </h3>
            <p class="text-sm text-beige-600 mt-1">일반적인 도서 카테고리를 한 번에 등록할 수 있습니다.</p>
        </div>

        <div class="p-6">
            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-3">
                <button onclick="addQuickCategory('literature', '문학')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    문학
                </button>
                <button onclick="addQuickCategory('humanities', '인문')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    인문
                </button>
                <button onclick="addQuickCategory('self_help', '자기계발')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    자기계발
                </button>
                <button onclick="addQuickCategory('business', '경제/경영')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    경제/경영
                </button>
                <button onclick="addQuickCategory('science', '과학/기술')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    과학/기술
                </button>
                <button onclick="addQuickCategory('arts', '예술/취미')"
                        class="p-3 text-sm border border-beige-300 rounded-lg hover:bg-beige-100 transition-colors">
                    예술/취미
                </button>
            </div>

            <div class="mt-4 text-center">
                <button onclick="addAllQuickCategories()"
                        class="bg-beige-600 hover:bg-beige-700 text-white px-6 py-2 rounded-lg transition-colors">
                    <i data-lucide="download" class="h-4 w-4 mr-1 inline"></i>
                    모든 기본 카테고리 등록
                </button>
            </div>
        </div>
    </div>
</main>

<script>
    // 페이지 로드 이벤트
    document.addEventListener('DOMContentLoaded', function() {
        console.log("페이지 로드 완료");

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
            console.log("Lucide 아이콘 초기화 완료");
        }

        // 페이지 로드 후 카테고리 목록 로드
        loadCategories();
    });

    // 카테고리 목록 로드 함수
    // 간단하고 확실한 최종 해결책
    function loadCategories() {
        console.log("=== 카테고리 목록 로드 시작 ===");

        fetch('/admin/category/list')
            .then(response => response.text())
            .then(textData => {
                console.log("원본 텍스트:", textData);

                const emptyState = document.getElementById('empty-state');
                const categoryList = document.getElementById('category-list');

                if (!textData || textData.trim() === '[]') {
                    emptyState.classList.remove('hidden');
                    categoryList.classList.add('hidden');
                    return;
                }

                emptyState.classList.add('hidden');
                categoryList.classList.remove('hidden');

                let html = '';

                // 직접 하드코딩 - 각각 개별 체크
                if (textData.includes('arts')) {
                    console.log("arts 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">예술/취미</span>
                            <span class="text-sm text-gray-500 ml-2">(arts)</span>
                        </div>
                        <button onclick="deleteCategory('arts')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                if (textData.includes('business')) {
                    console.log("business 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">경제/경영</span>
                            <span class="text-sm text-gray-500 ml-2">(business)</span>
                        </div>
                        <button onclick="deleteCategory('business')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                if (textData.includes('humanities')) {
                    console.log("humanities 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">인문</span>
                            <span class="text-sm text-gray-500 ml-2">(humanities)</span>
                        </div>
                        <button onclick="deleteCategory('humanities')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                if (textData.includes('literature')) {
                    console.log("literature 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">문학</span>
                            <span class="text-sm text-gray-500 ml-2">(literature)</span>
                        </div>
                        <button onclick="deleteCategory('literature')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                if (textData.includes('science')) {
                    console.log("science 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">과학/기술</span>
                            <span class="text-sm text-gray-500 ml-2">(science)</span>
                        </div>
                        <button onclick="deleteCategory('science')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                if (textData.includes('self_help')) {
                    console.log("self_help 발견");
                    html += `
                    <div class="flex items-center justify-between p-3 border border-beige-200 rounded-lg hover:bg-beige-50">
                        <div>
                            <span class="font-medium text-gray-900">자기계발</span>
                            <span class="text-sm text-gray-500 ml-2">(self_help)</span>
                        </div>
                        <button onclick="deleteCategory('self_help')" class="text-red-500 hover:text-red-700 p-1">
                            <i data-lucide="trash-2" class="h-4 w-4"></i>
                        </button>
                    </div>
                `;
                }

                categoryList.innerHTML = html;

                if (typeof lucide !== 'undefined') {
                    lucide.createIcons();
                }

                console.log("하드코딩 방식 렌더링 완료");
            })
            .catch(error => {
                console.error('에러:', error);

                const emptyState = document.getElementById('empty-state');
                const categoryList = document.getElementById('category-list');
                emptyState.classList.remove('hidden');
                categoryList.classList.add('hidden');
            });
    }

    // 카테고리 등록 폼 처리
    document.addEventListener('DOMContentLoaded', function() {
        const categoryForm = document.getElementById('categoryForm');
        if (categoryForm) {
            categoryForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const categoryId = document.getElementById('category_id').value.trim();
                const categoryName = document.getElementById('category_name').value.trim();

                if (!categoryId || !categoryName) {
                    alert('모든 필드를 입력해주세요.');
                    return;
                }

                // 영문 소문자, 언더스코어 검증
                if (!/^[a-z_]+$/.test(categoryId)) {
                    alert('카테고리 ID는 영문 소문자와 언더스코어(_)만 사용 가능합니다.');
                    return;
                }

                // 서버에 카테고리 등록 요청
                const formData = new FormData();
                formData.append('categoryId', categoryId);
                formData.append('categoryName', categoryName);

                fetch('/admin/category/register', {
                    method: 'POST',
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert(data.message);
                            clearForm();
                            loadCategories(); // 목록 새로고침
                        } else {
                            alert(data.message);
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('카테고리 등록 중 오류가 발생했습니다.');
                    });
            });
        }
    });

    // 카테고리 추가 (개별)
    function addCategory(id, name) {
        const formData = new FormData();
        formData.append('categoryId', id);
        formData.append('categoryName', name);

        fetch('/admin/category/register', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    loadCategories(); // 목록 새로고침
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('카테고리 등록 중 오류가 발생했습니다.');
            });
    }

    // 카테고리 삭제
    function deleteCategory(categoryId) {
        if (!confirm('정말 삭제하시겠습니까?')) return;

        console.log("삭제 요청:", categoryId);

        const formData = new FormData();
        formData.append('categoryId', categoryId);

        fetch('/admin/category/delete', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    loadCategories(); // 목록 새로고침
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('카테고리 삭제 중 오류가 발생했습니다.');
            });
    }

    // 폼 초기화
    function clearForm() {
        const categoryIdInput = document.getElementById('category_id');
        const categoryNameInput = document.getElementById('category_name');

        if (categoryIdInput) categoryIdInput.value = '';
        if (categoryNameInput) categoryNameInput.value = '';
    }

    // 빠른 카테고리 등록
    function addQuickCategory(id, name) {
        addCategory(id, name);
    }

    // 모든 기본 카테고리 등록
    function addAllQuickCategories() {
        if (!confirm('모든 기본 카테고리를 등록하시겠습니까?')) return;

        fetch('/admin/category/register-defaults', {
            method: 'POST'
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    loadCategories(); // 목록 새로고침
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('기본 카테고리 등록 중 오류가 발생했습니다.');
            });
    }
</script>
</body>
</html>