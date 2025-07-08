<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
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
<main class="max-w-4xl mx-auto px-4 py-12">

    <!-- Back Button -->
    <div class="mb-6">
        <a href="/board" class="flex items-center gap-2 text-beige-600 hover:text-gray-900 transition-colors">
            <i data-lucide="arrow-left" class="h-4 w-4"></i>
            게시판으로 돌아가기
        </a>
    </div>
<c:forEach var="post" items="${showContext}">
    <div class="bg-white border border-beige-200 shadow-lg rounded-lg">
        <div class="p-6 border-b border-beige-100">
            <h1 class="text-2xl font-light text-gray-900">게시글 작성</h1>
        </div>
        <div class="p-6 space-y-6">
            <form action="board-write-process.jsp" method="post" enctype="multipart/form-data">
                <!-- Category Selection -->
                <div class="space-y-2">
                    <label class="block text-gray-900 font-medium">카테고리</label>
                    <select name="boardCode" class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                        <option value="">카테고리를 선택하세요</option>
                        <option value="NTC">공지사항</option>
                        <option value="FAQ">FAQ</option>
                        <option value="QNA">문의</option>
                        <option value="EVN">이벤트</option>
                        <option value="REV">후기</option>
                    </select>
                </div>

                <!-- Title -->
                <div class="space-y-2">
                    <label for="title" class="block text-gray-900 font-medium">제목</label>
                    <input type="text" id="title" name="title" placeholder="제목을 입력하세요"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                </div>

                <!-- Content -->
                <div class="space-y-2">
                    <label for="content" class="block text-gray-900 font-medium">내용</label>
                    <textarea id="content" name="content" placeholder="내용을 입력하세요" rows="15"
                              class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none resize-none"></textarea>
                </div>

                <!-- File Attachments -->
                <div class="space-y-2">
                    <label class="block text-gray-900 font-medium">첨부파일</label>
                    <div class="space-y-3">
                        <button type="button" id="add-file-btn" class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded-lg flex items-center gap-2">
                            <i data-lucide="upload" class="h-4 w-4"></i>
                            파일 첨부
                        </button>
                        <input type="file" id="file-input" name="attachments" multiple class="hidden">

                        <div id="file-list" class="space-y-2"></div>
                    </div>
                </div>

                <!-- Writing Guidelines -->
                <div class="bg-beige-50 border border-beige-200 rounded-lg p-4">
                    <h4 class="font-medium text-gray-900 mb-2">게시글 작성 안내</h4>
                    <ul class="text-sm text-beige-600 space-y-1">
                        <li>• 욕설, 비방, 광고성 글은 삭제될 수 있습니다.</li>
                        <li>• 개인정보(전화번호, 주소 등)는 게시하지 마세요.</li>
                        <li>• 상품 문의는 해당 상품 페이지에서 문의해주세요.</li>
                        <li>• 첨부파일은 최대 5MB, 10개까지 업로드 가능합니다.</li>
                    </ul>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-4 pt-4">
                    <button type="submit" class="bg-gray-900 hover:bg-beige-800 text-white px-6 py-3 rounded-lg flex-1 transition-colors">
                        게시글 등록
                    </button>
                    <button type="button" class="border border-beige-300 text-beige-700 px-6 py-3 rounded-lg hover:bg-beige-100 transition-colors">
                        임시저장
                    </button>
                    <a href="/board" class="text-beige-600 px-6 py-3 hover:text-gray-900 transition-colors">
                        취소
                    </a>
                </div>
            </form>
        </div>
    </div>
</c:forEach>
</main>

<script>
    let fileCount = 0;
    const maxFiles = 10;

    document.getElementById('add-file-btn').addEventListener('click', function() {
        document.getElementById('file-input').click();
    });

    document.getElementById('file-input').addEventListener('change', function(e) {
        const files = e.target.files;
        const fileList = document.getElementById('file-list');

        for (let i = 0; i < files.length && fileCount < maxFiles; i++) {
            const file = files[i];
            fileCount++;

            const fileDiv = document.createElement('div');
            fileDiv.className = 'flex items-center justify-between p-2 bg-beige-50 rounded border border-beige-200';
            fileDiv.innerHTML = `
                <span class="text-sm text-gray-900">${file.name}</span>
                <button type="button" class="text-red-500 hover:text-red-700 p-1" onclick="removeFile(this)">
                    <i data-lucide="x" class="h-4 w-4"></i>
                </button>
            `;

            fileList.appendChild(fileDiv);
        }

        // Re-initialize Lucide icons for new elements
        lucide.createIcons();

        // Reset file input
        e.target.value = '';
    });

    function removeFile(button) {
        button.parentElement.remove();
        fileCount--;
    }

    // Initialize Lucide icons
    lucide.createIcons();
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
