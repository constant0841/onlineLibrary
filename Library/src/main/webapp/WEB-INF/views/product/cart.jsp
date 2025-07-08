<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%--
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
  <link rel="stylesheet" href="/static/css/globals.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<jsp:include page="../common/header.jsp" />
<main class="max-w-4xl mx-auto px-4 py-12">
  <h1 class="text-3xl font-light text-gray-900 mb-8">장바구니</h1>

    <c:forEach var="items" items="${cartList}">
        <p>상품명 : ${items.productName} ${items.color} ${items.size}</p>
        <p>제품 가격 :
                <fmt:formatNumber value="${items.finalPrice}" type="number" groupingUsed="true"/>원</p>

        <!-- 체크박스 -->
        <div class="cart-item">
            <input type="checkbox"
                   data-option-id="${items.productOptionId}"
                   onclick="toggleItem(this, ${items.userId},
                       ${items.productOptionId},
                       ${items.productCount},
                       ${items.finalPrice})" ${items.cartCheckbox == 1 ? 'checked' : ''}>
        </div>

        <!-- 수량 컨트롤 -->
        <form method="POST" action="/cartupdate" style="display: flex; align-items: center; gap: 10px;">
            <input type="hidden" name="userId" value="${items.userId}" />
            <input type="hidden" name="productOptionId" value="${items.productOptionId}" />
            <input type="hidden" id="count-${items.productOptionId}" name="productCount" value="${items.productCount}"/>
            <input type="hidden" id="price-${items.productOptionId}" value="${items.finalPrice}">

            <button type="button" onclick="updateCount(${items.productOptionId}, -1)">-</button>
            <span id="quantity-${items.productOptionId}">${items.productCount}</span>
            <button type="button" onclick="updateCount(${items.productOptionId}, +1)">+</button>
            <br>
            <span id="item-total-${items.productOptionId}">
                <fmt:formatNumber value="${items.finalPrice * items.productCount}" type="number" groupingUsed="true" />원
            </span>
        </form>
        <!-- 삭제 버튼 -->
        <button onclick="deleteCart(${items.userId}, ${items.productOptionId})">삭제</button>
        <hr>
    </c:forEach>

        <div class="bg-white border border-beige-200 rounded-lg sticky top-24">
            <div class="p-6">
                <h2 class="text-xl font-medium text-gray-900 mb-4">주문 요약</h2>

                <div class="space-y-2 mb-4">
                    <div class="flex justify-between text-lg font-medium text-gray-900">
                        <span>상품 금액</span>
                        <span id="total">0</span>
                    </div>
                    <div class="flex justify-between text-beige-600">
                        <span>배송비</span>
                        <span>무료</span>
                    </div>
                    <hr class="border-beige-200">
                    <div class="flex justify-between text-lg font-medium text-gray-900">
                        <span>총 결제 금액</span>
                        <span id="total-price">0</span>
                    </div>
                </div>

                <form id="orderForm" method="get" action="/order">
                    <button type="submit" class="block w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-3 rounded-lg transition-colors">
                        주문하기
                    </button>
                </form>
            </div>
        </div>
</main>

<script>
    // 모든 자바스크립트 코드 생략 가능 (필요 시 주석 처리 가능)
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
--%>
