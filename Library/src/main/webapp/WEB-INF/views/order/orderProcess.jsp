<%--
  Created by IntelliJ IDEA.
  User: sharon
  Date: 2025-06-23
  Time: 오후 12:00
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // 주문 처리 결과
    boolean orderSuccess = true;
    int orderNumber = 123455;
    int orderDate = 20250623;
%>

<%@ include file="../common/header.jsp" %>

<main class="max-w-4xl mx-auto px-4 py-12">
    <% if (orderSuccess) { %>
    <!-- 주문 처리 성공 -->
    <div class="text-center mb-8">
        <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <i data-lucide="check-circle" class="h-10 w-10 text-green-600"></i>
        </div>
        <h1 class="text-3xl font-light text-gray-900 mb-4">주문이 완료되었습니다!</h1>
        <p class="text-lg text-beige-600 mb-2">주문해 주셔서 감사합니다.</p>
        <p class="text-beige-600">주문 확인 및 배송 안내는 이메일과 SMS로 발송됩니다.</p>
    </div>

    <!-- 주문 정보 카드 -->
    <div class="bg-gradient-to-r from-beige-100 to-beige-200 rounded-lg p-8 mb-8">
        <div class="grid md:grid-cols-3 gap-6 text-center">
            <div>
                <p class="text-sm text-beige-700 mb-2">주문번호</p>
                <p class="text-xl font-medium text-gray-900">${orderDto.orderId}</p>
            </div>
            <div>
                <p class="text-sm text-beige-700 mb-2">주문일시</p>
                <p class="text-lg text-gray-900"><%= orderDate %>
                </p>
            </div>
            <div>
                <p class="text-sm text-beige-700 mb-2">결제금액</p>
                <p class="text-2xl font-medium text-gray-900">
                    ₩<fmt:formatNumber value="${orderDto.totalAmount}" type="number" groupingUsed="true"/>
                </p>
            </div>
        </div>
    </div>

    <div class="grid lg:grid-cols-2 gap-8">
        <!-- 주문 상품 정보 -->
        <div class="bg-white border border-beige-200 rounded-lg">
            <div class="p-6 border-b border-beige-100">
                <h2 class="text-xl font-medium text-gray-900">주문 상품</h2>
            </div>
            <div class="p-6">
                <div class="space-y-4">

                    <c:forEach var="item" items="${orderDetailDtoList}">
                        <div class="flex gap-4 p-4 border border-beige-200 rounded-lg">
                            <img src="https://shop-phinf.pstatic.net/20250317_15/1742171755178UDtlA_JPEG/6974354318766909_716864716.jpg?type=m510"
                                 alt="스탠리 아이스플로우 에어로라이트 플립스트로 2.0 텀블러 473ml"
                                 class="w-16 h-20 object-cover rounded">
                            <div class="flex-1">
                                <h3 class="font-medium text-gray-900 mb-1">${item.productName}</h3>
                                <p class="text-sm text-beige-600 mb-1">색상: ${item.color} / 사이즈: ${item.sizes}</p>
                                <div class="flex justify-between items-center">
                                    <span class="text-sm text-beige-600">수량: ${item.quantities}개</span>
                                    <span class="font-medium text-gray-900">
                                            ₩<fmt:formatNumber value="${item.prices}" type="number"
                                                               groupingUsed="true"/>
                                            </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </div>

        <!-- 주문자 및 배송 정보 -->
        <div class="space-y-6">
            <!-- 주문자 정보 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">주문자 정보</h2>
                </div>
                <div class="p-6 space-y-3">
                    <div class="flex justify-between">
                        <span class="text-beige-600">이름</span>
                        <span class="text-gray-900">${userInfo.userName}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">전화번호</span>
                        <span class="text-gray-900">${userInfo.userPhone}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">이메일</span>
                        <span class="text-gray-900">${userInfo.userEmail}</span>
                    </div>
                </div>
            </div>

            <!-- 배송 정보 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">배송 정보</h2>
                </div>
                <div class="p-6 space-y-3">
                    <div class="flex justify-between">
                        <span class="text-beige-600">받는 분</span>
                        <span class="text-gray-900">${orderDeliveryDto.recipientName}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">전화번호</span>
                        <span class="text-gray-900">${orderDeliveryDto.recipientPhone}</span>
                    </div>
                    <div>
                        <p class="text-beige-600 mb-1">배송 주소</p>
                        <div class="text-gray-900 text-sm">
                            <p>${orderDeliveryDto.postalCode}</p>
                            <p>${orderDeliveryDto.address}</p>
                            <p>${orderDeliveryDto.addressDetail}</p>
                        </div>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">배송 메모</span>
                        <span class="text-gray-900">${deliveryRequest}</span>
                    </div>
                </div>
            </div>

            <!-- 결제 정보 -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">결제 정보</h2>
                </div>
                <div class="p-6 space-y-3">
                    <div class="flex justify-between">
                        <span class="text-beige-600">결제 방법</span>
                        <span class="text-gray-900" id ="paymentMethod">${paymentMethod}</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">상품 금액</span>
                        <span class="text-gray-900">
                            ₩<fmt:formatNumber value="${orderDto.totalPrice}" type="number" groupingUsed="true"/>
                        </span>
                    </div>

                    <div class="flex justify-between">
                        <span class="text-beige-600">배송비</span>
                        <span class="text-gray-900">
                            ₩<fmt:formatNumber value="${orderDto.shippingFee}" type="number" groupingUsed="true"/>
                        </span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">할인 금액</span>
                        <span class="text-gray-900">
                            ₩<fmt:formatNumber value="${discount}" type="number" groupingUsed="true"/>
                        </span>
                    </div>
                    <hr class="border-beige-200">
                    <div class="flex justify-between text-lg font-medium">
                        <span class="text-gray-900">총 결제 금액</span>
                        <span class="text-gray-900">
                        ₩<fmt:formatNumber value="${orderDto.totalAmount}" type="number" groupingUsed="true"/>
                         </span>
                    </div>
                    <div class="pt-3 border-t border-beige-200">
                        <div class="flex items-center gap-2 text-green-600">
                            <i data-lucide="check-circle" class="h-4 w-4"></i>
                            <span class="text-sm">결제가 완료되었습니다</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 다음 단계 안내 -->
    <div class="bg-blue-50 border border-blue-200 rounded-lg p-6 mt-8">
        <h3 class="text-lg font-medium text-blue-900 mb-4">다음 단계</h3>
        <div class="grid md:grid-cols-3 gap-4 text-sm">
            <div class="flex items-start gap-3">
                <div class="w-6 h-6 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-xs font-medium">
                    1
                </div>
                <div>
                    <p class="font-medium text-blue-900">주문 확인</p>
                    <p class="text-blue-700">주문 내역을 확인하고 상품을 준비합니다</p>
                </div>
            </div>
            <div class="flex items-start gap-3">
                <div class="w-6 h-6 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-xs font-medium">
                    2
                </div>
                <div>
                    <p class="font-medium text-blue-900">배송 시작</p>
                    <p class="text-blue-700">1-2일 내에 배송을 시작합니다</p>
                </div>
            </div>
            <div class="flex items-start gap-3">
                <div class="w-6 h-6 bg-blue-100 text-blue-600 rounded-full flex items-center justify-center text-xs font-medium">
                    3
                </div>
                <div>
                    <p class="font-medium text-blue-900">배송 완료</p>
                    <p class="text-blue-700">2-3일 내에 상품을 받아보실 수 있습니다</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 액션 버튼 -->
    <div class="flex flex-col sm:flex-row gap-4 mt-8">
        <a href="/orderDetl?orderNumber=${orderDto.orderId}"
           class="flex-1 bg-gray-900 hover:bg-beige-800 text-white text-center py-3 px-6 rounded-lg transition-colors">
            주문 상세 보기
        </a>
        <a href="/main"
           class="flex-1 border border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white text-center py-3 px-6 rounded-lg transition-colors">
            쇼핑 계속하기
        </a>
        <button onclick="printOrder()"
                class="border border-beige-300 text-beige-700 hover:bg-beige-100 py-3 px-6 rounded-lg transition-colors">
            주문서 인쇄
        </button>
    </div>

    <% } else { %>
    <!-- 주문 처리 실패 -->
    <div class="text-center mb-8">
        <div class="w-20 h-20 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <i data-lucide="x-circle" class="h-10 w-10 text-red-600"></i>
        </div>
        <h1 class="text-3xl font-light text-gray-900 mb-4">주문 처리 중 오류가 발생했습니다</h1>
        <p class="text-lg text-red-600 mb-6">에러메시지 사용해주세요</p>
    </div>

    <div class="bg-red-50 border border-red-200 rounded-lg p-6 mb-8">
        <h3 class="text-lg font-medium text-red-900 mb-4">오류 해결 방법</h3>
        <ul class="space-y-2 text-sm text-red-800">
            <li>• 모든 필수 정보가 올바르게 입력되었는지 확인해주세요</li>
            <li>• 결제 정보가 정확한지 확인해주세요</li>
            <li>• 네트워크 연결 상태를 확인해주세요</li>
            <li>• 문제가 지속되면 고객센터로 문의해주세요</li>
        </ul>
    </div>

    <div class="flex gap-4">
        <button onclick="history.back()"
                class="flex-1 bg-gray-900 hover:bg-beige-800 text-white py-3 px-6 rounded-lg transition-colors">
            이전 페이지로 돌아가기
        </button>
        <a href="/main"
           class="flex-1 border border-gray-900 text-gray-900 hover:bg-gray-900 hover:text-white text-center py-3 px-6 rounded-lg transition-colors">
            홈으로 가기
        </a>
    </div>
    <% } %>
</main>

<!-- 주문 완료 알림 모달 -->
<% if (orderSuccess) { %>
<div id="successModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg p-8 max-w-md mx-4">
        <div class="text-center">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i data-lucide="check" class="h-8 w-8 text-green-600"></i>
            </div>
            <h3 class="text-xl font-medium text-gray-900 mb-2">결제가 완료되었습니다!</h3>
            <p class="text-beige-600 mb-6">주문번호: ${orderDto.orderId}
            </p>
            <button onclick="closeModal()"
                    class="w-full bg-gray-900 hover:bg-beige-800 text-white py-3 rounded-lg transition-colors">
                확인
            </button>
        </div>
    </div>
</div>
<% } %>

<script>
    // 모달 닫기
    function closeModal() {
        document.getElementById('successModal').style.display = 'none';
    }

    // 주문서 인쇄
    function printOrder() {
        window.print();
    }

    // 페이지 로드 시 모달 표시 (3초 후 자동 닫기)
    <% if (orderSuccess) { %>
    setTimeout(function () {
        closeModal();
    }, 3000);
    <% } %>

    // 뒤로가기 방지 (주문 완료 후)
    <% if (orderSuccess) { %>
    history.pushState(null, null, location.href);
    window.onpopstate = function () {
        history.go(1);
    };
    <% } %>

    // Initialize Lucide icons
    lucide.createIcons();
</script>

<%@ include file="../common/footer.jsp" %>
