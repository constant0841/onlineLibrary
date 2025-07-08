<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-23
  Time: 오후 12:17
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="/static/css/globals.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
<c:set var="scaledAmount" value="${order.totalAmount * 0.01}" />
<c:set var="totalPrice" value="0" />
<jsp:include page="../common/header.jsp"/>
<%
    String orderNumber = request.getParameter("orderNumber");
    if (orderNumber == null) orderNumber = "1234567786216";

    // 주문 상태 설정 (실제로는 데이터베이스에서 가져와야 함)
    String orderStatus = "결제완료";
    String orderDate = "2024-01-15 14:30:25";
    String deliveryStatus = "상품준비중";
    String trackingNumber = "";

    // 주문 상품 정보 (임시 데이터)

%>


<main class="max-w-4xl mx-auto px-4 py-12">
    <!-- 주문 완료 헤더 -->
    <div class="text-center mb-8">
        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i data-lucide="check" class="h-8 w-8 text-green-600"></i>
        </div>
        <h1 class="text-2xl font-light text-gray-900 mb-2">주문이 완료되었습니다</h1>
        <p class="text-beige-600">주문해 주셔서 감사합니다. 빠른 시일 내에 배송해드리겠습니다.</p>
    </div>

    <!-- 주문 정보 요약 -->
    <div class="bg-beige-50 border border-beige-200 rounded-lg p-6 mb-8">
        <div class="grid md:grid-cols-3 gap-6 text-center">
            <div>
                <p class="text-sm text-beige-600 mb-1">주문번호</p>
                <p class="font-medium text-gray-900">${order.orderId}</p>
            </div>
            <div>
                <p class="text-sm text-beige-600 mb-1">주문일시</p>
                <p class="font-medium text-gray-900"><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd" /></p>
            </div>
            <div>
                <p class="text-sm text-beige-600 mb-1">결제금액</p>
                <p class="font-medium text-gray-900 text-lg">
                    ₩<fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>
                </p>
            </div>
        </div>
    </div>

    <div class="grid lg:grid-cols-3 gap-8">
        <!-- 주문 상세 정보 -->
        <div class="lg:col-span-2 space-y-6">
            <!-- 주문 상품 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">주문 상품</h2>
                </div>
                <div class="p-6">
                    <div class="space-y-4">
                        <c:forEach var="item" items="${orderDetailList}">
                            <div class="flex gap-4 p-4 border border-beige-200 rounded-lg">
                                <img src="${item.filePath}"
                                     alt="스탠리 아이스플로우 에어로라이트 플립스트로 2.0 텀블러 473ml"
                                     class="w-16 h-20 object-cover rounded">
                                <div class="flex-1">
                                    <h3 class="font-medium text-gray-900 mb-2">${item.productName}</h3>
                                    <div class="text-sm text-beige-600 space-y-1">
                                        <p>색상: ${item.color} / 사이즈: ${item.sizes}</p>
                                        <p>수량: ${item.quantities}개</p>
                                    </div>
                                    <div class="flex justify-between items-center mt-3">
                                        <div class="flex gap-2">
                                            <button class="text-sm border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded transition-colors">
                                                리뷰 작성
                                            </button>
                                            <a href="/productDetl?productId=${item.productId}" class="text-sm border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded transition-colors">
                                                재주문
                                            </a>
<%--                                            <button  class="text-sm border border-beige-300 text-beige-700 hover:bg-beige-100 px-3 py-1 rounded transition-colors">--%>
<%--                                                재주문--%>
<%--                                            </button>--%>
                                        </div>
                                        <span class="font-medium text-gray-900">
                                            ₩<fmt:formatNumber value="${item.prices}" type="number"
                                                               groupingUsed="true"/>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <c:set var="totalPrice" value="${totalPrice + item.prices}" />
                        </c:forEach>
                    </div>
                </div>
            </div>

            <!-- 배송 정보 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">배송 정보</h2>
                </div>
                <div class="p-6">
                    <div class="grid md:grid-cols-2 gap-6">
                        <div>
                            <h3 class="font-medium text-gray-900 mb-3">받는 분</h3>
                            <div class="space-y-2 text-sm">
                                <p class="text-gray-900">${orderAdress.recipientName}</p>
                                <p class="text-beige-600">${orderAdress.recipientPhone}</p>
                            </div>
                        </div>
                        <div>
                            <h3 class="font-medium text-gray-900 mb-3">배송 주소</h3>
                            <div class="space-y-1 text-sm">
                                <p class="text-beige-600">${orderAdress.postalCode}</p>
                                <p class="text-gray-900">${orderAdress.address}</p>
                                <p class="text-gray-900">${orderAdress.addressDetail}</p>
                            </div>
                        </div>
                    </div>
                    <div class="mt-6 pt-4 border-t border-beige-200">
                        <h3 class="font-medium text-gray-900 mb-2">배송 메모</h3>
                        <p class="text-sm text-beige-600">${orderAdress.deliveryRequest}</p>
                    </div>
                </div>
            </div>

            <!-- 결제 정보 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">결제 정보</h2>
                </div>
                <div class="p-6">
                    <div class="space-y-3">
                        <div class="flex justify-between">
                            <span class="text-beige-600">상품 금액</span>
                            <span class="text-gray-900">
                                ₩<fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>
                            </span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-beige-600">배송비</span>
                            <span class="text-gray-900">₩${order.shippingFee}</span>
                        </div>
<%--                        <div class="flex justify-between text-green-600">--%>
<%--                            <span>배송비 할인</span>--%>
<%--                            <span>-₩3,000</span>--%>
<%--                        </div>--%>
                        <div class="flex justify-between">
                            <span class="text-beige-600">쿠폰 할인</span>
                            <span class="text-gray-900">-₩${order.couponDiscount}</span>
                        </div>
                        <div class="flex justify-between">
                            <span class="text-beige-600">적립금 사용</span>
                            <span class="text-gray-900">
                                -₩<fmt:formatNumber value="${order.pointUse}" type="number" groupingUsed="true"/>
                            </span>
                        </div>
                        <hr class="border-beige-200">
                        <div class="flex justify-between text-lg font-medium">
                            <span class="text-gray-900">총 결제 금액</span>
                            <span class="text-gray-900">
                                 ₩<fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/>
                            </span>
                        </div>
                    </div>

                    <div class="mt-6 pt-4 border-t border-beige-200">
                        <div class="flex justify-between items-center">
                            <div>
                                <p class="font-medium text-gray-900">신용카드</p>
                                <p class="text-sm text-beige-600">KB국민카드 (**** **** **** 1234)</p>
                            </div>
                            <span class="font-medium text-gray-900">₩<fmt:formatNumber value="${order.totalAmount}" type="number" groupingUsed="true"/></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 주문 상태 및 액션 -->
        <div class="space-y-6">
            <!-- 주문 상태 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-lg font-medium text-gray-900">주문 상태</h2>
                </div>
                <div class="p-6">
                    <div class="space-y-4">
                        <!-- 주문 진행 상태 -->
                        <div class="space-y-3">
                            <div class="flex items-center gap-3">
                                <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                                <div>
                                    <p class="font-medium text-gray-900" id="orderStatus">${order.orderStatus}</p>
                                </div>
                            </div>
                            <%--                            <div class="flex items-center gap-3">--%>
                            <%--                                <div class="w-3 h-3 bg-green-500 rounded-full"></div>--%>
                            <%--                                <div>--%>
                            <%--                                    <p class="font-medium text-gray-900">주문 접수</p>--%>
                            <%--                                    <p class="text-xs text-beige-600">2024-01-15 14:30</p>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <%--                            <div class="flex items-center gap-3">--%>
                            <%--                                <div class="w-3 h-3 bg-green-500 rounded-full"></div>--%>
                            <%--                                <div>--%>
                            <%--                                    <p class="font-medium text-gray-900">결제 완료</p>--%>
                            <%--                                    <p class="text-xs text-beige-600">2024-01-15 14:31</p>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <%--                            <div class="flex items-center gap-3">--%>
                            <%--                                <div class="w-3 h-3 bg-blue-500 rounded-full animate-pulse"></div>--%>
                            <%--                                <div>--%>
                            <%--                                    <p class="font-medium text-gray-900">상품 준비중</p>--%>
                            <%--                                    <p class="text-xs text-beige-600">현재 단계</p>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <%--                            <div class="flex items-center gap-3">--%>
                            <%--                                <div class="w-3 h-3 bg-beige-300 rounded-full"></div>--%>
                            <%--                                <div>--%>
                            <%--                                    <p class="text-beige-600">배송 시작</p>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>

                            <%--                            <div class="flex items-center gap-3">--%>
                            <%--                                <div class="w-3 h-3 bg-beige-300 rounded-full"></div>--%>
                            <%--                                <div>--%>
                            <%--                                    <p class="text-beige-600">배송 완료</p>--%>
                            <%--                                </div>--%>
                            <%--                            </div>--%>
                        </div>

                        <% if (!trackingNumber.isEmpty()) { %>
                        <div class="pt-4 border-t border-beige-200">
                            <p class="text-sm font-medium text-gray-900 mb-2">운송장 번호</p>
                            <div class="flex items-center gap-2">
                                <span class="text-sm text-gray-900"><%= trackingNumber %></span>
                                <button class="text-xs text-blue-600 hover:underline">배송조회</button>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <!-- 주문 관련 액션 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-lg font-medium text-gray-900">주문 관리</h2>
                </div>
                <div class="p-6 space-y-3">
                    <button class="w-full border border-beige-300 text-beige-700 hover:bg-beige-100 py-2 rounded-lg transition-colors">
                        주문 취소 신청
                    </button>
                    <button class="w-full border border-beige-300 text-beige-700 hover:bg-beige-100 py-2 rounded-lg transition-colors">
                        교환/반품 신청
                    </button>
                    <button class="w-full border border-beige-300 text-beige-700 hover:bg-beige-100 py-2 rounded-lg transition-colors">
                        배송지 변경
                    </button>
                </div>
            </div>

            <!-- 고객센터 -->
            <div class="bg-beige-100 border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-200">
                    <h2 class="text-lg font-medium text-gray-900">고객센터</h2>
                </div>
                <div class="p-6 space-y-3">
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

            <!-- 적립금 안내 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-lg font-medium text-gray-900">적립 혜택</h2>
                </div>
                <div class="p-6">
                    <div class="text-center">
                        <div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-3">
                            <i data-lucide="coins" class="h-6 w-6 text-yellow-600"></i>
                        </div>
                        <p class="font-medium text-gray-900 mb-1">적립금 지급 예정</p>
                        <p class="text-2xl font-light text-gray-900 mb-2">
                        <p>₩ <fmt:formatNumber value="${scaledAmount}" type="number" groupingUsed="true" maxFractionDigits="0"/></p>

                        </p>
                        <p class="text-xs text-beige-600">배송완료 후 7일 뒤 지급</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 하단 액션 버튼 -->
    <div class="flex gap-4 mt-8">
        <a href="/main"
           class="flex-1 bg-gray-900 hover:bg-beige-800 text-white text-center py-3 rounded-lg transition-colors">
            쇼핑 계속하기
        </a>
        <a href="orderList"
           class="flex-1 border border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white text-center py-3 rounded-lg transition-colors">
            주문 목록 보기
        </a>
    </div>
</main>

<script>
    // 주문 상태 업데이트 (실시간)
    function updateOrderStatus() {
        <%--document.getElementById('orderStatus').textContent = ${order.orderStatus}--%>
        // 실제로는 AJAX로 서버에서 주문 상태를 가져와야 함
        console.log('주문 상태 업데이트 확인');
    }

    // 페이지 로드 시 주문 상태 확인
    setInterval(updateOrderStatus, 30000); // 30초마다 확인

    // Initialize Lucide icons
    lucide.createIcons();
</script>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>



