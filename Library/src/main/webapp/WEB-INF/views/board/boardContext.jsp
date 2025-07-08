<%--
  Created by IntelliJ IDEA.
  User: monae
  Date: 25. 6. 24.
  Time: 오후 6:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Sha_Jang_Tumbler</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-VTmh+5lDQgxBgaA8cD3X2iKQk4YI3sYeEjwA0kaOK1Z3XM3+o2D4w9abEzoS4V6L"
          crossorigin="anonymous"/>

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="/static/css/globals.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="../common/header.jsp" />

<main class="max-w-6xl mx-auto px-4 py-12">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/board" class="flex items-center gap-2 text-beige-600 hover:text-gray-900 transition-colors">
            <i data-lucide="arrow-left" class="h-4 w-4"></i>
            게시판으로 돌아가기
        </a>
    </div>
    <c:forEach var="post" items="${showContext}">

    <div class="grid lg:grid-cols-3 gap-8">
        <!-- Main Content -->
        <div class="lg:col-span-2">
            <div class="bg-white border border-beige-200 shadow-lg rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <div class="flex items-start justify-between">
                        <div class="flex-1">
                            <h1 class="text-2xl font-light text-gray-900 mb-4">${post.postTitle}</h1>
                            <div class="flex items-center gap-6 text-sm text-beige-600">
                                <span class="font-medium">${post.postWriter}</span>
                                <span>${post.postAt}</span>
                                <div class="flex items-center gap-1">
                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                    <span>${post.viewCount}</span>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <button class="text-beige-400 hover:text-gray-900 p-2">
                                <i data-lucide="edit" class="h-4 w-4"></i>
                            </button>
                            <button class="text-beige-400 hover:text-red-500 p-2">
                                <i data-lucide="trash-2" class="h-4 w-4"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="p-8">
                    <!-- Post Content -->
                    <div class="text-gray-900 leading-relaxed mb-8">
                            ${post.postContext}
                    </div>

                    <!-- Attachments -->
                    <div class="pt-6 border-t border-beige-100">
                        <h4 class="font-medium text-gray-900 mb-4">첨부파일</h4>
                        <div class="space-y-2">
                            <div class="flex items-center justify-between p-3 bg-beige-50 rounded border border-beige-200">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="download" class="h-4 w-4 text-beige-500"></i>
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">2024_FW_컬렉션_카탈로그.pdf</p>
                                        <p class="text-xs text-beige-500">2.3MB</p>
                                    </div>
                                </div>
                                <button class="text-beige-600 hover:text-gray-900 text-sm">다운로드</button>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-beige-50 rounded border border-beige-200">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="download" class="h-4 w-4 text-beige-500"></i>
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">사이즈_가이드.jpg</p>
                                        <p class="text-xs text-beige-500">856KB</p>
                                    </div>
                                </div>
                                <button class="text-beige-600 hover:text-gray-900 text-sm">다운로드</button>
                            </div>
                        </div>
                    </div>

                    <!-- Post Actions -->
                    <div class="flex items-center justify-between pt-6 border-t border-beige-100">
                        <div class="flex items-center gap-4">
                            <button id="like-btn" class="flex items-center gap-2 text-beige-500 hover:text-red-500 transition-colors">
                                <i data-lucide="thumbs-up" class="h-5 w-5"></i>
                                좋아요 <span id="like-count">18</span>
                            </button>
                        </div>
                        <button class="flex items-center gap-2 text-beige-500 hover:text-gray-900 transition-colors">
                            <i data-lucide="share-2" class="h-5 w-5"></i>
                            공유
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </c:forEach>

    <!-- Sidebar -->
    <div class="space-y-6">
        <!-- Post Navigation -->
        <div class="bg-white border border-beige-200 rounded-lg">
            <div class="p-4 border-b border-beige-100">
                <h3 class="text-lg font-medium text-gray-900">게시글 이동</h3>
            </div>
            <div class="p-4 space-y-3">
                <div>
                    <p class="text-sm text-beige-600 mb-1">이전 글</p>
                    <a href="/boardDetl?id=2" class="text-gray-900 hover:text-beige-600 text-sm transition-colors">
                        배송 지연 안내드립니다
                    </a>
                </div>
                <div>
                    <p class="text-sm text-beige-600 mb-1">다음 글</p>
                    <a href="/boardDetl?id=4" class="text-gray-900 hover:text-beige-600 text-sm transition-colors">
                        교환/반품 정책 안내
                    </a>
                </div>
            </div>
        </div>

        <!-- Related Posts -->
        <div class="bg-white border border-beige-200 rounded-lg">
            <div class="p-4 border-b border-beige-100">
                <h3 class="text-lg font-medium text-gray-900">관련 게시글</h3>
            </div>
            <div class="p-4 space-y-3">
                <a href="/boardDetl?id=2" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                    <div class="flex items-center gap-2 mb-1">
                        <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">공지사항</span>
                    </div>
                    <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">배송 지연 안내드립니다</h4>
                    <div class="flex items-center gap-2 text-xs text-beige-500">
                        <span>2024-01-14</span>
                        <span>•</span>
                        <span>조회 189</span>
                    </div>
                </a>

                <a href="/boardDetl?id=4" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                    <div class="flex items-center gap-2 mb-1">
                        <span class="bg-blue-100 text-blue-700 px-2 py-1 text-xs rounded">FAQ</span>
                    </div>
                    <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">교환/반품 정책 안내</h4>
                    <div class="flex items-center gap-2 text-xs text-beige-500">
                        <span>2024-01-12</span>
                        <span>•</span>
                        <span>조회 156</span>
                    </div>
                </a>

                <a href="/boardDetl?id=5" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                    <div class="flex items-center gap-2 mb-1">
                        <span class="bg-purple-100 text-purple-700 px-2 py-1 text-xs rounded">이벤트</span>
                    </div>
                    <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">회원 등급별 혜택 안내</h4>
                    <div class="flex items-center gap-2 text-xs text-beige-500">
                        <span>2024-01-11</span>
                        <span>•</span>
                        <span>조회 203</span>
                    </div>
                </a>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="bg-white border border-beige-200 rounded-lg">
            <div class="p-4 border-b border-beige-100">
                <h3 class="text-lg font-medium text-gray-900">빠른 메뉴</h3>
            </div>
            <div class="p-4 space-y-2">
                <a href="/board" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                    전체 게시글 보기
                </a>
                <a href="/board/write/.jsp" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                    새 글 작성하기
                </a>
                <a href="/board?category=공지사항" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                    공지사항만 보기
                </a>
                <a href="/board?category=FAQ" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                    FAQ 보기
                </a>
            </div>
        </div>

        <!-- Customer Service -->
        <div class="bg-beige-100 border border-beige-200 rounded-lg">
            <div class="p-4 border-b border-beige-200">
                <h3 class="text-lg font-medium text-gray-900">고객센터</h3>
            </div>
            <div class="p-4 space-y-3">
                <div>
                    <p class="text-sm font-medium text-gray-900">전화 문의</p>
                    <p class="text-sm text-beige-600">02-1234-5678</p>
                    <p class="text-xs text-beige-500">평일 09:00 - 18:00</p>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-900">이메일 문의</p>
                    <p class="text-sm text-beige-600">support@chicstore.com</p>
                </div>
                <button class="w-full bg-gray-900 hover:bg-beige-800 text-white py-2 rounded-lg mt-3 transition-colors">
                    1:1 문의하기
                </button>
            </div>
        </div>
    </div>
<%--    </div>--%>
</main>
</html>