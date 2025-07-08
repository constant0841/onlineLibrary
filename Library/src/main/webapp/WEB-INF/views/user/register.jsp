<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 7:29
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
<main class="max-w-md mx-auto px-4 py-16">
  <div class="bg-white border border-beige-200 shadow-lg rounded-lg">
    <div class="text-center p-6 border-b border-beige-100">
      <h1 class="text-2xl font-light text-gray-900 mb-2">회원가입</h1>
      <p class="text-beige-600">새 계정을 만들어 쇼핑을 시작하세요</p>
    </div>
    <div class="p-6 space-y-4">

        <c:if test="${not empty errorMsg}">
            <p style="color:red">${errorMsg}</p>
        </c:if>

      <form action="/register" method="post" id="register">
        <div class="space-y-2 mb-4">
          <label for="name" class="block text-gray-900 font-medium">이름<span class="text-red-500">*</span></label>
          <input type="text" id="name" name="userName" placeholder="홍길동"
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none" >
        </div>
<%--        <div class="space-y-2 mb-4">--%>
<%--          <label for="email" class="block text-gray-900 font-medium">이메일<span class="text-red-500">*</span></label>--%>
<%--          <input type="email" id="email" name="email" placeholder="your@email.com"--%>
<%--                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none" required>--%>
<%--        </div>--%>
        <div class="space-y-2 mb-4">
          <label for="email" class="block text-gray-900 font-medium">
            이메일 <span class="text-red-500">*</span>
          </label>
          <div class="flex gap-2">
            <input type="email" id="userEmail" name="userEmail" placeholder="your@email.com"
                   class="flex-1 px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
            <button type="button" onclick="sendVerificationEmail()"
                    class="px-4 py-2 bg-gray-900 text-white rounded-lg hover:bg-gray-800">
              인증전송
            </button>
          </div>
        </div>
        <div class="space-y-2 mb-4">
          <label for="emailVerify" class="block text-gray-900 font-medium">인증번호<span class="text-red-500">*</span></label>
          <input type="text" id="emailVerify" name="emailVerifyCode"
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none" >
        </div>
        <div class="space-y-2 mb-4">
          <label for="password" class="block text-gray-900 font-medium">비밀번호<span class="text-red-500">*</span></label>
          <input type="password" id="userpassword" name="userPassword"
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none" >
        </div>
        <div class="space-y-2 mb-6">
          <label for="confirmPassword" class="block text-gray-900 font-medium">비밀번호 확인<span class="text-red-500">*</span></label>
          <input type="password" id="confirmPwd" name="confirmPassword"
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
        </div>

        <div class="space-y-2 mb-4 max-w-md">
          <label for="sample6_postcode" class="block text-gray-900 font-medium">
            우편번호 <span class="text-red-500">*</span>
          </label>
          <div class="flex gap-2">
            <!-- 우편번호 input: 고정 너비로 축소 -->
            <input type="text" id="sample6_postcode" name="userPostalCode" placeholder="우편번호" readonly
                   class="w-[200px] px-3 py-2 border border-beige-200 rounded-lg focus:outline-none focus:border-gray-900">

            <!-- 버튼: 남는 공간 활용 (자동 확장) -->
            <button type="button" onclick="sample6_execDaumPostcode()"
                    class="flex-1 px-3 py-2 bg-gray-900 text-white rounded-lg hover:bg-gray-800 text-sm whitespace-nowrap">
              우편번호 찾기
            </button>
          </div>
        </div>

        <div class="space-y-2 mb-4">
          <label for="sample6_address" class="block text-gray-900 font-medium">
            주소 <span class="text-red-500">*</span>
          </label>
          <input type="text" id="sample6_address" name="userAddress" placeholder="주소" readonly
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:outline-none focus:border-gray-900">
        </div>

<%--        <div class="space-y-2 mb-4">--%>
<%--          <label for="sample6_extraAddress" class="block text-gray-900 font-medium">--%>
<%--            참고항목--%>
<%--          </label>--%>
<%--          <input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly--%>
<%--                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:outline-none focus:border-gray-900">--%>
<%--        </div>--%>

          <div class="space-y-2 mb-4">
              <label for="sample6_detailAddress" class="block text-gray-900 font-medium">
                  상세주소<span class="text-red-500">*</span>
              </label>
              <input type="text" id="sample6_detailAddress" name="userAddressDetail" placeholder="상세주소"
                     class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:outline-none focus:border-gray-900">
          </div>


        <div class="space-y-2 mb-4">
          <label for="phone" class="block text-gray-900 font-medium">연락처<span class="text-red-500">*</span></label>
          <input type="tel" id="phone" name="userPhone" placeholder="010-1234-5678"
                 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
        </div>

        <div class="space-y-2 mb-4">
        <label for="birth_date" class="block text-gray-900 font-medium">
          생년월일<span class="text-red-500">*</span>
        </label>
        <input type="date" id="birth_date" name="userBirthDate" required
               class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-gray-900">
        </div>



        <div class="space-y-2 mb-4">
          <label class="block text-gray-900 font-medium">성별<span class="text-red-500">*</span></label>
          <div class="flex gap-4">
            <label class="flex items-center">
              <input type="radio" name="userGenderId" value="M"
                     class="text-gray-900 focus:ring-gray-900" required />
              <span class="ml-2">남성</span>
            </label>
            <label class="flex items-center">
              <input type="radio" name="userGenderId" value="F"
                     class="text-gray-900 focus:ring-gray-900" />
              <span class="ml-2">여성</span>
            </label>
          </div>
        </div>

        <div class="space-y-2 mb-4">
        <label class="block text-gray-900 font-medium" >직업<span class="text-red-500">*</span></label>
        <div class="flex gap-4">
          <label class="flex items-center">
            <input type="radio" name="userJob" value="1"
                   class="text-gray-900 focus:ring-gray-900" required />
            <span class="ml-2">직원</span>
          </label>
          <label class="flex items-center">
            <input type="radio" name="userJob" value="2"
                   class="text-gray-900 focus:ring-gray-900" />
            <span class="ml-2">학생</span>
          </label>
          <label class="flex items-center">
            <input type="radio" name="userJob" value="3"
                   class="text-gray-900 focus:ring-gray-900" />
            <span class="ml-2">대학생</span>
          </label>
          <label class="flex items-center">
            <input type="radio" name="userJob" value="4"
                   class="text-gray-900 focus:ring-gray-900" />
            <span class="ml-2">직장인</span>
          </label>
        </div>
        <br><br><br><br><br>
            <div class="space-y-2 mb-4">
                <label class="flex items-center">
                    <input type="checkbox" id="adAgree" name="userIsAdReceive"
                           class="text-gray-900 focus:ring-gray-900 rounded">
                    <span class="ml-2 text-sm text-gray-700">(선택)광고 및 이벤트 수신에 동의합니다.</span>
                </label>
            </div>
    </div>
        <button type="submit" class="w-full bg-gray-900 hover:bg-beige-800 text-white py-3 rounded-lg transition-colors">
          회원가입
        </button>
      </form>

      <div class="text-center">
        <p class="text-sm text-beige-600">
          이미 계정이 있으신가요?
          <a href="/login" class="text-gray-900 hover:underline">로그인</a>
        </p>
      </div>
    </div>
  </div>

</main>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    document.getElementById("register").addEventListener("submit", function (e) {
        const pwd = document.getElementById("userPassword").value;
        const pwdconfirm = document.getElementById("confirmPwd").value;
        const emailverify = document.getElementById("emailVerify").value;
        const phone = document.getElementById("phone").value;
        const name = document.getElementById("name").value;
        const detailAddress = document.getElementById("sample6_detailAddress").value;

        if(!name.trim()){
            e.preventDefault();
            alert("이름을 입력해주세요"); return;
        }


        if(!pwd.trim()){
            e.preventDefault();
            alert("비밀번호를 입력해주세요"); return;
        }

        if(!emailverify.trim()){
            e.preventDefault();
            alert("인증번호를 입력해주세요"); return;
        }

        if(!detailAddress.trim()){
            e.preventDefault();
            alert("상세주소를 입력해주세요"); return;
        }


        if(!phone.trim()){
            e.preventDefault();
            alert("연락처를 입력해주세요"); return;
        }


        if(pwd != pwdconfirm){
            e.preventDefault(); // 서버로 폼 전송 막기
            alert("비밀번호가 일치하지 않습니다."); return;
        }

        if (pwd.length < 8) {
            e.preventDefault();
            alert("비밀번호는 8자 이상이어야 합니다."); return;
        }
    });

    function sendVerificationEmail() {
        const email = document.getElementById('userEmail').value;
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!email) {
            alert("이메일을 입력해주세요.");
            return;
        } else if(!emailRegex.test(email)){
            alert("유효한 이메일을 입력해주세요")
            return;

        }

        fetch('/sendEmail', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'

            },
            body: "userEmail=" + encodeURIComponent(email)
        })
            .then(res => res.text())
            .then(data => alert(data))
            .catch(err => alert("메일 전송 실패: " + err));
    }


    function sample6_execDaumPostcode() {
    new daum.Postcode({
      oncomplete: function(data) {
        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
          addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
          addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if(data.userSelectedType === 'R'){
          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
            extraAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          // if(extraAddr !== ''){
          //   extraAddr = ' (' + extraAddr + ')';
          // }
          // // 조합된 참고항목을 해당 필드에 넣는다.
          // document.getElementById("sample6_extraAddress").value = extraAddr;

        } else {
          document.getElementById("sample6_extraAddress").value = '';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('sample6_postcode').value = data.zonecode;
        document.getElementById("sample6_address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("sample6_detailAddress").focus();
      }
    }).open();
  }


</script>
</body>
</html>

