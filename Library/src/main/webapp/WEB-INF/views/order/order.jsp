<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-23
  Time: 오전 11:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="false" %>
<c:set var="totalPrice" value="0" />
<c:set var="totalQuantity" value="0" />
<c:set var="totalCount" value="0" />
<c:set var="test1234" value="3000" />
<c:set var="phone" value="${userInfo.userPhone}"/>
<c:choose>
    <c:when test="${phone != null && fn:length(phone) == 11}">
        <c:set var="formattedPhone"
               value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}"/>
    </c:when>
    <c:when test="${phone != null && fn:length(phone) == 10}">
        <c:set var="formattedPhone"
               value="${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 6)}-${fn:substring(phone, 6, 10)}"/>
    </c:when>
    <c:otherwise>
        <c:set var="formattedPhone" value="${phone}"/>
    </c:otherwise>
</c:choose>

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
    <link rel="stylesheet" href="/static/css/globals.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<main class="max-w-4xl mx-auto px-4 py-12">
    <h1 class="text-3xl font-light text-gray-900 mb-8">주문/결제</h1>

    <form action="/orderProcess" method="post" id="orderForm" >
        <div class="grid lg:grid-cols-2 gap-8">
            <!-- 주문 정보 입력 -->
            <div class="space-y-6">
                <!-- 주문자 정보 -->
                <div class="bg-white border border-beige-200 rounded-lg">
                    <div class="p-6 border-b border-beige-100">
                        <h2 class="text-xl font-medium text-gray-900">주문자 정보</h2>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <div class="space-y-2">
                                <label for="userName" class="block text-gray-900 font-medium">이름 *</label>
                                <input type="hidden" name="userName" id="userName" required value="${userInfo.userName}">
                                <h3 id="userName"
                                    class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">${userInfo.userName}</h3>
                            </div>
                            <div class="space-y-2">
                                <label for="userPhone" class="block text-gray-900 font-medium">전화번호 *</label>
                                <input type="hidden" name="userPhone" id="userPhone" required value="${formattedPhone}">
                                <h3 id="userPhone"
                                    class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                                    ${formattedPhone}
                                </h3>
                            </div>
                        </div>
                        <div class="space-y-2">
                            <label for="userEmail" class="block text-gray-900 font-medium">이메일 *</label>
                            <input type="hidden" name="userEmail" id="userEmail" required value="${userInfo.userEmail}">
                            <h3 class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">${userInfo.userEmail}</h3>
                        </div>
                    </div>
                </div>

                <!-- 배송 정보 -->
                <div class="bg-white border border-beige-200 rounded-lg">
                    <div class="p-6 border-b border-beige-100">
                        <div class="flex items-center justify-between">
                            <h2 class="text-xl font-medium text-gray-900">배송 정보</h2>
                            <label class="flex items-center gap-2">
                                <input type="checkbox" id="defaultAddress" onchange="defaultAddressInfo()">
                                <span class="text-sm text-beige-600">기본 배송지로</span>
                            </label>
                            <label class="flex items-center gap-2">
                                <input type="checkbox" id="sameAsOrderer" onchange="copyOrdererInfo()">
                                <span class="text-sm text-beige-600">주문자 정보와 동일</span>
                            </label>
                        </div>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <div class="space-y-2">
                                <label for="recipientName" class="block text-gray-900 font-medium">받는 분 *</label>
                                <input type="text" id="recipientName" name="recipientName" required
                                       class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                            </div>
                            <div class="space-y-2">
                                <label for="recipientPhone" class="block text-gray-900 font-medium">전화번호 *</label>
                                <input type="tel" id="recipientPhone" name="recipientPhone" placeholder="010-1234-5678"
                                       required
                                       class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label for="postalCode" class="block text-gray-900 font-medium">우편번호 *</label>
                            <div class="flex gap-2">
                                <input type="text" id="postalCode" name="postalCode" readonly required
                                       class="flex-1 px-3 py-2 border border-beige-200 rounded-lg bg-beige-50">
                                <button type="button" onclick="searchAddress()"
                                        class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg transition-colors">
                                    주소 검색
                                </button>
                            </div>
                        </div>

                        <div class="space-y-2">
                            <label for="address" class="block text-gray-900 font-medium">주소 *</label>
                            <input type="text" id="address" name="address" readonly required
                                   class="w-full px-3 py-2 border border-beige-200 rounded-lg bg-beige-50">
                        </div>

                        <div class="space-y-2">
                            <label for="addressDetail" class="block text-gray-900 font-medium">상세 주소 *</label>
                            <input type="text" id="addressDetail" name="addressDetail" placeholder="아파트, 동/호수" required
                                   class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                        </div>

                        <div class="space-y-2">
                            <label for="deliveryRequest" class="block text-gray-900 font-medium">배송 메모</label>
                            <select id="deliveryRequest" name="deliveryRequest"
                                    class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none">
                                <option value="">배송 메모를 선택하세요</option>
                                <option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
                                <option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
                                <option value="택배함에 넣어주세요">택배함에 넣어주세요</option>
                                <option value="부재 시 연락주세요">부재 시 연락주세요</option>
                                <option value="${customMemo}">직접 입력</option>
                            </select>
                            <textarea id="customMemo" name="customMemo" placeholder="직접 입력하세요" rows="2"
                                      class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none hidden"></textarea>
                        </div>
                    </div>
                </div>

                <!-- 결제 방법 -->
                <div class="bg-white border border-beige-200 rounded-lg">
                    <div class="p-6 border-b border-beige-100">
                        <h2 class="text-xl font-medium text-gray-900">결제 방법</h2>
                    </div>
                    <div class="p-6">
                        <div class="space-y-3">
                            <label class="flex items-center space-x-3 p-3 border border-beige-200 rounded-lg hover:bg-beige-50 cursor-pointer">
                                <input type="radio" name="paymentMethod" value="card" class="text-gray-900" required>
                                <div class="flex items-center gap-3">
                                    <i data-lucide="credit-card" class="h-5 w-5 text-gray-900"></i>
                                    <span class="text-gray-900">신용카드</span>
                                </div>
                            </label>
                            <label class="flex items-center space-x-3 p-3 border border-beige-200 rounded-lg hover:bg-beige-50 cursor-pointer">
                                <input type="radio" name="paymentMethod" value="bank" class="text-gray-900">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="building-2" class="h-5 w-5 text-gray-900"></i>
                                    <span class="text-gray-900">무통장입금</span>
                                </div>
                            </label>
                            <label class="flex items-center space-x-3 p-3 border border-beige-200 rounded-lg hover:bg-beige-50 cursor-pointer">
                                <input type="radio" name="paymentMethod" value="kakao" class="text-gray-900">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="smartphone" class="h-5 w-5 text-gray-900"></i>
                                    <span class="text-gray-900">카카오페이</span>
                                </div>
                            </label>
                            <label class="flex items-center space-x-3 p-3 border border-beige-200 rounded-lg hover:bg-beige-50 cursor-pointer">
                                <input type="radio" name="paymentMethod" value="naver" class="text-gray-900">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="smartphone" class="h-5 w-5 text-gray-900"></i>
                                    <span class="text-gray-900">네이버페이</span>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 주문 상품 및 결제 정보 -->
            <div class="space-y-6">
                <!-- 주문 상품 -->
                <div class="bg-white border border-beige-200 rounded-lg sticky top-24">
                    <div class="p-6 border-b border-beige-100">
                        <h2 class="text-xl font-medium text-gray-900">주문 상품</h2>
                    </div>
                    <div class="p-6 space-y-4">
                        <div class="space-y-3">
                            <c:forEach var="item" items="${productList}">
                                <div class="flex gap-4 p-4 border border-beige-200 rounded-lg">
                                    <img src="${item.filePath}"
                                         alt=">${item.productName}"
                                         class="w-16 h-20 object-cover rounded">
                                    <div class="flex-1">
                                        <h3 class="font-medium text-gray-900 mb-1">${item.productName}</h3>
                                        <p class="text-sm text-beige-600 mb-1">색상: ${item.color} / 사이즈: ${item.size}</p>
                                        <div class="flex justify-between items-center">
                                            <span class="text-sm text-beige-600">수량: ${item.quantity}개</span>
                                            <span class="font-medium text-gray-900">
                                            ₩<fmt:formatNumber value="${item.quantity * item.price}" type="number" groupingUsed="true"/>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Hidden inputs for order processing -->
                                <input type="hidden" name="productId" value="${item.productOptionId}">
                                <input type="hidden" name="quantity" value="${item.quantity}">
                                <input type="hidden" name="price" value="${item.price}">
                                <c:set var="totalPrice" value="${totalPrice + item.quantity * item.price}" />
                                <c:set var="totalQuantity" value="${totalQuantity + item.quantity}" />
                                <c:set var="totalCount" value="${totalCount +1}" />
                            </c:forEach>
                            <input type="hidden" name="totalPrice" value="${totalPrice}" />
                            <input type="hidden" name="totalQuantity" value="${totalQuantity}" />
                            <input type="hidden" name="totalCount" value="${totalCount}" />
                        </div>
                        <hr class="border-beige-200">

                        <!-- 결제 금액 계산 -->
                        <div class="space-y-2">
                            <div class="flex justify-between text-beige-600">
                                <span>상품 금액</span>
                                <span id="subtotal">
                                    ₩<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>
                                </span>
                            </div>
                            <div class="flex justify-between text-beige-600">
                                <span>배송비</span>
                                <span id="shippingFee">
                                    ₩<fmt:formatNumber value="${test1234}" type="number" groupingUsed="true"/>
                                </span>
                                <input type="hidden" name="shippingFee" value="${test1234}">
                            </div>
                            <div class="flex justify-between text-green-600">
                                <span>배송비 할인</span>
                                <span id="shippingDiscount">0</span>
                            </div>
                            <div class="flex justify-between text-beige-600">
                                <span>할인 금액</span>
                                <span id="discount" name="discount">
                                    ₩<fmt:formatNumber value="0" type="number" groupingUsed="true"/>
                                </span>
                                <input type="hidden" id="discountValue" name="discount" value="0">
                            </div>
                            <div class="flex justify-between text-beige-600">
                                <span>포인트 금액</span>
                                <span id="pointdis">
                                    ₩<fmt:formatNumber value="0" type="number" groupingUsed="true"/>
                                </span>
                                <input type="hidden" id="pointValue" value="0">
                            </div>
                            <hr class="border-beige-200">
                            <div class="flex justify-between text-lg font-medium text-gray-900">
                                <span>총 결제 금액</span>
                                <span id="totalAmountdis">
                                    ₩<fmt:formatNumber value="${totalPrice + test1234}" type="number" groupingUsed="true"/>
                                </span>
                                <input type="hidden" id="totalAmount" name="totalAmount" value="${totalPrice + test1234}">
                            </div>
                        </div>

                        <!-- 쿠폰 및 적립금 -->
                        <div class="space-y-3 pt-4 border-t border-beige-200">
                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">쿠폰 사용</label>
                                <div class="flex gap-2">
                                    <select class="flex-1 px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none text-sm">
                                        <option value="">사용 가능한 쿠폰이 없습니다</option>
                                    </select>
                                    <button type="button"
                                            class="border border-beige-300 text-beige-700 px-3 py-2 rounded-lg text-sm hover:bg-beige-100">
                                        적용
                                    </button>
                                </div>
                            </div>

                            <div>
                                <label class="block text-sm font-medium text-gray-900 mb-2">적립금 사용</label>
                                <div class="flex gap-2">
                                    <input type="number" placeholder="0" min="0" max="${userInfo.userPoint}" id="point" name="pointUse" value="0"
                                           class="flex-1 px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none text-sm">
                                    <button type="button" onclick="pointAll()"
                                            class="border border-beige-300 text-beige-700 px-3 py-2 rounded-lg text-sm hover:bg-beige-100">
                                        전액사용
                                    </button>
                                    <button type="button" onclick="pointUses()"
                                            class="border border-beige-300 text-beige-700 px-3 py-2 rounded-lg text-sm hover:bg-beige-100">
                                        포인트 사용
                                    </button>
                                </div>
                                <p class="text-xs text-beige-500 mt-1">사용 가능 적립금: ${userInfo.userPoint}원</p>
                            </div>

                            <!-- 주문 동의 및 결제 -->
                            <div class="bg-white border border-beige-200 rounded-lg">
                                <div class="p-6 space-y-4">
                                    <div class="space-y-3">
                                        <label class="flex items-start gap-3">
                                            <input type="checkbox" required class="mt-1">
                                            <span class="text-sm text-gray-900">
                                                <strong>[필수]</strong> 개인정보 수집·이용 동의
                                                <a href="#" class="text-beige-600 underline ml-1">자세히 보기</a>
                                             </span>
                                        </label>

                                        <label class="flex items-start gap-3">
                                            <input type="checkbox" required class="mt-1">
                                            <span class="text-sm text-gray-900">
                                                <strong>[필수]</strong> 구매조건 확인 및 결제진행 동의
                                                <a href="#" class="text-beige-600 underline ml-1">자세히 보기</a>
                                            </span>
                                        </label>

                                        <label class="flex items-start gap-3">
                                            <input type="checkbox" class="mt-1">
                                            <span class="text-sm text-gray-900">
                                                [선택] 마케팅 정보 수신 동의
                                                <a href="#" class="text-beige-600 underline ml-1">자세히 보기</a>
                                            </span>
                                        </label>
                                    </div>

                                    <button type="submit"
                                            class="w-full bg-gray-900 hover:bg-beige-800 text-white py-4 rounded-lg text-lg font-medium transition-colors">
                                        결제하기
                                    </button>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</main>
<%--우편주소API--%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    const baseTotalPrice = Number(${totalPrice});
    const totalDisplayEl = document.getElementById('totalAmountdis');// 예: 100000
    const totalHiddenEl = document.getElementById('totalAmount');
    // 주문자 정보와 배송 정보 동일하게 설정
    function copyOrdererInfo() {
        const checkbox = document.getElementById('sameAsOrderer');
        if (checkbox.checked) {
            document.getElementById('recipientName').value = '${userInfo.userName}';
            document.getElementById('recipientPhone').value = '${formattedPhone}';
        } else {
            document.getElementById('recipientName').value = '';
            document.getElementById('recipientPhone').value = '';
        }
    }

    function defaultAddressInfo() {
        const checkbox = document.getElementById('defaultAddress');
        if (checkbox.checked) {
            document.getElementById('recipientName').value = '${address.recipientName}';
            document.getElementById('recipientPhone').value = '${address.recipientPhone}';
            document.getElementById('postalCode').value = '${address.postalCode}';
            document.getElementById('address').value = '${address.address}';
            document.getElementById('addressDetail').value = '${address.addressDetail}';
        } else {
            document.getElementById('recipientName').value = '';
            document.getElementById('recipientPhone').value = '';
            document.getElementById('postalCode').value = '';
            document.getElementById('address').value = '';
            document.getElementById('addressDetail').value = '';
        }
    }

    function pointAll(){
        if(${userInfo.userPoint -(totalPrice + test1234)}>=0)
        {
            document.getElementById('point').value = '${totalPrice + test1234}';
        }
        else{
            document.getElementById('point').value = '${userInfo.userPoint}';
        }
    }
    function pointUses(){
        const raw = document.getElementById('point').value;
        // 빈 문자열이거나 숫자가 아닐 경우 0으로 처리하거나 예외 처리 가능
        const num = Number(raw);
        if (isNaN(num)) {
            // 필요시 사용자에게 경고하거나 0으로 초기화
            alert('입력값이 올바른 숫자가 아닙니다');
            return;
        }
        else if (num> ${userInfo.userPoint}) {
            alert('보유 적립금(${userInfo.userPoint}원)보다 많은 금액은 사용할 수 없습니다.');
            return;
        }
        // toLocaleString으로 천 단위 콤마 적용. 'ko-KR' 로케일 사용.
        const formatted = '₩' + num.toLocaleString('ko-KR');
        // 필요하면 뒤에 '원'을 붙일 수도 있음: '₩' + ... + '원'
        document.getElementById('pointValue').value = num;
        document.getElementById('pointdis').textContent = formatted;
        // 3) 총액 재계산: baseTotalPrice - num
        let newTotal = baseTotalPrice - num + ${test1234};
        if (newTotal < 0) {
            newTotal = 0;
        }
        // 4) 화면에 표시: span#totalAmountDisplay
        totalDisplayEl.textContent = '₩' + newTotal.toLocaleString('ko-KR');
        // 5) 숨겨진 input#totalAmount 갱신
        totalHiddenEl.value = newTotal;
    }
    // 주소 검색 (실제로는 다음 우편번호 API 등을 사용)
    function searchAddress() {
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
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("address").value = extraAddr;

                } else {
                    document.getElementById("address").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postalCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addressDetail").focus();
            }
        }).open();


    }

    // 배송 메모 직접 입력
    document.getElementById('deliveryRequest').addEventListener('change', function () {
        const customMemo = document.getElementById('customMemo');
        if (this.value === '직접입력') {
            customMemo.classList.remove('hidden');
            customMemo.focus();
        } else {
            customMemo.classList.add('hidden');
        }
    });

    // 폼 제출 처리
    document.getElementById('orderForm').addEventListener('submit', function (e) {
        e.preventDefault();

        // 필수 항목 체크
        const requiredFields = ['userName', 'userPhone', 'userEmail', 'recipientName', 'recipientPhone', 'postalCode', 'address', 'addressDetail'];
        let isValid = true;

        requiredFields.forEach(fieldId => {
            const field = document.getElementById(fieldId);
            console.log(field);
            console.log(field.value);
            if (!field.value.trim()) {
                field.classList.add('border-red-500');
                isValid = false;
            } else {
                field.classList.remove('border-red-500');
            }
        });

        // 결제 방법 선택 체크
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
        if (!paymentMethod) {
            alert('결제 방법을 선택해주세요.');
            isValid = false;
        }

        if (isValid) {
            // 주문 번호 생성 (임시)
            // const orderNumber = 'ORD' + new Date().getTime();

            // 주문 처리 페이지로 이동
            alert('주문이 완료되었습니다.');
            this.submit();
            // window.location.href = 'order-detail.jsp?orderNumber=' + orderNumber;
        } else {
            alert('필수 항목을 모두 입력해주세요.');
        }

        // window.location.href = `/orderProcess`;
    });

    // Initialize Lucide icons
    lucide.createIcons();
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>