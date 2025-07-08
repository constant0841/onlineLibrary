<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-07-07
  Time: 오후 6:30
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
    <title>비밀번호 찾기 - Sha_Jang_Tumbler</title>
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
<main class="max-w-md mx-auto px-4 py-16">
    <div class="bg-white border border-beige-200 shadow-lg rounded-lg">
        <div class="text-center p-6 border-b border-beige-100">
            <h1 class="text-2xl font-light text-gray-900 mb-2">비밀번호 찾기</h1>
            <p class="text-beige-600">본인 확인을 위해 정보를 입력해주세요</p>
        </div>
        <div class="p-6 space-y-4">

            <!-- 에러 메시지 -->
            <c:if test="${not empty errorMsg}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded" role="alert">
                    <span class="block sm:inline">${errorMsg}</span>
                </div>
            </c:if>

            <form action="/forgotPassword" method="post" id="forgotPasswordForm">

                <!-- 이름 입력 -->
                <div class="space-y-2 mb-4">
                    <label for="userName" class="block text-gray-900 font-medium">
                        이름 <span class="text-red-500">*</span>
                    </label>
                    <input type="text" id="userName" name="userName" placeholder="홍길동"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                </div>

                <!-- 이메일 입력 -->
                <div class="space-y-2 mb-4">
                    <label for="userEmail" class="block text-gray-900 font-medium">
                        이메일 <span class="text-red-500">*</span>
                    </label>
                    <input type="email" id="userEmail" name="userEmail" placeholder="your@email.com"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                </div>

                <!-- 전화번호 입력 -->
                <div class="space-y-2 mb-6">
                    <label for="userPhone" class="block text-gray-900 font-medium">
                        전화번호 <span class="text-red-500">*</span>
                    </label>
                    <input type="tel" id="userPhone" name="userPhone" placeholder="010-1234-5678"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                </div>

                <!-- 안내 메시지 -->
                <div class="bg-blue-50 border border-blue-200 text-blue-700 px-4 py-3 rounded mb-6">
                    <div class="flex">
                        <div class="py-1">
                            <svg class="fill-current h-6 w-6 text-blue-500 mr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm">
                                입력하신 정보가 일치하면 해당 이메일로 인증번호를 전송합니다.<br>
                                인증번호 확인 후 새로운 비밀번호를 설정할 수 있습니다.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 버튼 그룹 -->
                <div class="flex gap-3">
                    <button type="submit" class="flex-1 bg-gray-900 hover:bg-gray-800 text-white py-3 rounded-lg transition-colors">
                        인증번호 받기
                    </button>
                    <a href="/login" class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg transition-colors text-center leading-normal">
                        로그인으로 돌아가기
                    </a>
                </div>
            </form>
        </div>
    </div>
</main>

<script>
    // 폼 제출 시 유효성 검사
    document.getElementById("forgotPasswordForm").addEventListener("submit", function (e) {
        const userName = document.getElementById("userName").value;
        const userEmail = document.getElementById("userEmail").value;
        const userPhone = document.getElementById("userPhone").value;

        // 필수 입력 체크
        if (!userName.trim()) {
            e.preventDefault();
            alert("이름을 입력해주세요.");
            return;
        }

        if (!userEmail.trim()) {
            e.preventDefault();
            alert("이메일을 입력해주세요.");
            return;
        }

        if (!userPhone.trim()) {
            e.preventDefault();
            alert("전화번호를 입력해주세요.");
            return;
        }

        // 이메일 형식 검증
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailRegex.test(userEmail)) {
            e.preventDefault();
            alert("올바른 이메일 주소를 입력해주세요.");
            return;
        }

        // 전화번호 형식 검증 (간단)
        const phoneRegex = /^010-\d{4}-\d{4}$/;
        if (!phoneRegex.test(userPhone)) {
            e.preventDefault();
            alert("전화번호는 010-1234-5678 형식으로 입력해주세요.");
            return;
        }
    });
</script>
</body>
</html>