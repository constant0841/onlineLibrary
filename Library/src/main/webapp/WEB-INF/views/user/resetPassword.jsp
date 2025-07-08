<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-07-07
  Time: 오후 6:45
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
    <title>비밀번호 재설정 - Sha_Jang_Tumbler</title>
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
            <h1 class="text-2xl font-light text-gray-900 mb-2">비밀번호 재설정</h1>
            <p class="text-beige-600">이메일로 전송된 인증번호를 입력하고 새 비밀번호를 설정하세요</p>
        </div>
        <div class="p-6 space-y-4">

            <!-- 성공 메시지 -->
            <c:if test="${not empty successMsg}">
                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded" role="alert">
                    <span class="block sm:inline">${successMsg}</span>
                </div>
            </c:if>

            <!-- 에러 메시지 -->
            <c:if test="${not empty errorMsg}">
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded" role="alert">
                    <span class="block sm:inline">${errorMsg}</span>
                </div>
            </c:if>

            <form action="/resetPassword" method="post" id="resetPasswordForm">

                <!-- 인증번호 입력 -->
                <div class="space-y-2 mb-4">
                    <label for="resetCode" class="block text-gray-900 font-medium">
                        인증번호 <span class="text-red-500">*</span>
                    </label>
                    <input type="text" id="resetCode" name="resetCode" placeholder="6자리 인증번호"
                           maxlength="6" pattern="[0-9]{6}"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none text-center text-lg font-mono">
                    <div class="text-xs text-gray-500 mt-1">
                        * 이메일로 전송된 6자리 숫자를 입력하세요
                    </div>
                </div>

                <!-- 새 비밀번호 -->
                <div class="space-y-2 mb-4">
                    <label for="newPassword" class="block text-gray-900 font-medium">
                        새 비밀번호 <span class="text-red-500">*</span>
                    </label>
                    <input type="password" id="newPassword" name="newPassword"
                           placeholder="새 비밀번호를 입력하세요 (8자 이상)"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                    <div class="text-xs text-gray-500 mt-1">
                        * 영문, 숫자, 특수문자를 포함하여 8자 이상 입력하세요
                    </div>
                </div>

                <!-- 새 비밀번호 확인 -->
                <div class="space-y-2 mb-6">
                    <label for="confirmNewPassword" class="block text-gray-900 font-medium">
                        새 비밀번호 확인 <span class="text-red-500">*</span>
                    </label>
                    <input type="password" id="confirmNewPassword" name="confirmNewPassword"
                           placeholder="새 비밀번호를 다시 입력하세요"
                           class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                    <div id="passwordMatchMsg" class="text-xs mt-1"></div>
                </div>

                <!-- 시간 안내 -->
                <div class="bg-yellow-50 border border-yellow-200 text-yellow-700 px-4 py-3 rounded mb-6">
                    <div class="flex">
                        <div class="py-1">
                            <svg class="fill-current h-5 w-5 text-yellow-500 mr-3" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                <path d="M10 18a8 8 0 100-16 8 8 0 000 16zm.75-13a.75.75 0 00-1.5 0v5c0 .414.336.75.75.75h4a.75.75 0 000-1.5h-3.25V5z"/>
                            </svg>
                        </div>
                        <div>
                            <p class="text-sm">
                                <strong>인증번호는 5분간 유효합니다.</strong><br>
                                시간이 초과되면 다시 비밀번호 찾기를 진행해주세요.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- 버튼 그룹 -->
                <div class="flex gap-3">
                    <button type="submit" class="flex-1 bg-gray-900 hover:bg-gray-800 text-white py-3 rounded-lg transition-colors">
                        비밀번호 변경
                    </button>
                    <a href="/forgotPassword" class="flex-1 bg-gray-200 hover:bg-gray-300 text-gray-700 py-3 rounded-lg transition-colors text-center leading-normal">
                        다시 인증받기
                    </a>
                </div>
            </form>

            <!-- 로그인 링크 -->
            <div class="text-center pt-4">
                <p class="text-sm text-beige-600">
                    비밀번호가 기억나셨나요?
                    <a href="/login" class="text-gray-900 hover:underline">로그인하기</a>
                </p>
            </div>
        </div>
    </div>
</main>

<script>
    // 인증번호 입력 시 숫자만 허용
    document.getElementById('resetCode').addEventListener('input', function(e) {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // 비밀번호 확인 실시간 체크
    document.getElementById('confirmNewPassword').addEventListener('input', function() {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = this.value;
        const messageDiv = document.getElementById('passwordMatchMsg');

        if (confirmPassword.length > 0) {
            if (newPassword === confirmPassword) {
                messageDiv.textContent = '✓ 비밀번호가 일치합니다';
                messageDiv.className = 'text-xs mt-1 text-green-600';
            } else {
                messageDiv.textContent = '✗ 비밀번호가 일치하지 않습니다';
                messageDiv.className = 'text-xs mt-1 text-red-600';
            }
        } else {
            messageDiv.textContent = '';
        }
    });

    // 폼 제출 시 유효성 검사
    document.getElementById("resetPasswordForm").addEventListener("submit", function (e) {
        const resetCode = document.getElementById("resetCode").value;
        const newPassword = document.getElementById("newPassword").value;
        const confirmNewPassword = document.getElementById("confirmNewPassword").value;

        // 필수 입력 체크
        if (!resetCode.trim()) {
            e.preventDefault();
            alert("인증번호를 입력해주세요.");
            return;
        }

        // 인증번호 길이 체크
        if (resetCode.length !== 6) {
            e.preventDefault();
            alert("인증번호는 6자리 숫자입니다.");
            return;
        }

        if (!newPassword.trim()) {
            e.preventDefault();
            alert("새 비밀번호를 입력해주세요.");
            return;
        }

        if (!confirmNewPassword.trim()) {
            e.preventDefault();
            alert("새 비밀번호 확인을 입력해주세요.");
            return;
        }

        // 비밀번호 길이 체크
        if (newPassword.length < 8) {
            e.preventDefault();
            alert("새 비밀번호는 8자 이상이어야 합니다.");
            return;
        }

        // 새 비밀번호 일치 체크
        if (newPassword !== confirmNewPassword) {
            e.preventDefault();
            alert("새 비밀번호가 일치하지 않습니다.");
            return;
        }

        // 비밀번호 강도 체크 (영문, 숫자, 특수문자 포함)
        const passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])/;
        if (!passwordRegex.test(newPassword)) {
            e.preventDefault();
            alert("새 비밀번호는 영문, 숫자, 특수문자를 포함해야 합니다.");
            return;
        }
    });

    // 자동 포커스 (페이지 로드 시 인증번호 입력란에 포커스)
    window.onload = function() {
        document.getElementById('resetCode').focus();
    };
</script>
</body>
</html>