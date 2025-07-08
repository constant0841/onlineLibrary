<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

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
  <div class="flex justify-between items-center mb-8">
    <h1 class="text-3xl font-light text-gray-900">게시판</h1>
    <a href="/board/write" class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg flex items-center gap-2">
      <i data-lucide="edit" class="h-4 w-4"></i>
      글쓰기
    </a>
  </div>

  <!-- Search and Filter -->
  <div class="bg-white border border-beige-200 rounded-lg mb-6">
    <div class="p-6">
      <div class="flex flex-col md:flex-row gap-4">
        <div class="flex gap-2 flex-wrap">
          <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm bg-beige-100">전체</button>
          <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">공지사항</button>
          <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">FAQ</button>
          <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">문의</button>
          <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded text-sm">이벤트</button>
        </div>
        <div class="flex gap-2 md:ml-auto">
          <div class="relative">
            <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-beige-400"></i>
            <input type="text" placeholder="검색어를 입력하세요" class="pl-10 pr-4 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
          </div>
          <button class="border border-beige-300 px-4 py-2 rounded-lg hover:bg-beige-100">검색</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Posts List -->
  <div class="bg-white border border-beige-200 rounded-lg">
    <div class="p-6 border-b border-beige-100">
      <h2 class="text-xl font-medium text-gray-900">게시글 목록</h2>
    </div>
    <div class="divide-y divide-beige-200">
      <!-- Post 1 -->
      <div class="p-6 hover:bg-beige-50 transition-colors">
        <div class="flex items-start justify-between">
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-2">
              <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">공지사항</span>
            </div>
            <a href="boardDetl?id=1" class="block">
              <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                2024 F/W 신상품 출시 안내
              </h3>
            </a>
            <div class="flex items-center gap-4 text-sm text-beige-600">
              <span>관리자</span>
              <span>2024-01-15</span>
              <span>조회 245</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Post 2 -->
      <div class="p-6 hover:bg-beige-50 transition-colors">
        <div class="flex items-start justify-between">
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-2">
              <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">공지사항</span>
            </div>
            <a href="boardDetl?id=2" class="block">
              <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                배송 지연 안내드립니다
              </h3>
            </a>
            <div class="flex items-center gap-4 text-sm text-beige-600">
              <span>관리자</span>
              <span>2024-01-14</span>
              <span>조회 189</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Post 3 -->
      <div class="p-6 hover:bg-beige-50 transition-colors">
        <div class="flex items-start justify-between">
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-2">
              <span class="bg-green-100 text-green-700 px-2 py-1 text-xs rounded">문의</span>
            </div>
            <a href="/boardDetl?id=3" class="block">
              <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                코트 사이즈 문의드립니다
              </h3>
            </a>
            <div class="flex items-center gap-4 text-sm text-beige-600">
              <span>김고객</span>
              <span>2024-01-13</span>
              <span>조회 67</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Post 4 -->
      <div class="p-6 hover:bg-beige-50 transition-colors">
        <div class="flex items-start justify-between">
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-2">
              <span class="bg-blue-100 text-blue-700 px-2 py-1 text-xs rounded">FAQ</span>
            </div>
            <a href="/boardDetl?id=4" class="block">
              <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                교환/반품 정책 안내
              </h3>
            </a>
            <div class="flex items-center gap-4 text-sm text-beige-600">
              <span>관리자</span>
              <span>2024-01-12</span>
              <span>조회 156</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Post 5 -->
      <div class="p-6 hover:bg-beige-50 transition-colors">
        <div class="flex items-start justify-between">
          <div class="flex-1">
            <div class="flex items-center gap-2 mb-2">
              <span class="bg-purple-100 text-purple-700 px-2 py-1 text-xs rounded">이벤트</span>
            </div>
            <a href="/boardDetl?id=5" class="block">
              <h3 class="text-lg font-medium text-gray-900 hover:text-beige-600 transition-colors mb-2">
                회원 등급별 혜택 안내
              </h3>
            </a>
            <div class="flex items-center gap-4 text-sm text-beige-600">
              <span>관리자</span>
              <span>2024-01-11</span>
              <span>조회 203</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Pagination -->
  <div class="flex justify-center mt-8">
    <div class="flex gap-2">
      <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">이전</button>
      <button class="bg-gray-900 text-white px-3 py-2 rounded">1</button>
      <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">2</button>
      <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">3</button>
      <button class="border border-beige-300 px-3 py-2 rounded hover:bg-beige-100">다음</button>
    </div>
  </div>
</main>

<script>
  // Initialize Lucide icons
  lucide.createIcons();
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>