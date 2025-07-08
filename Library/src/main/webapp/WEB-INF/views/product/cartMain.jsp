<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: sharo--%>
<%--  Date: 2025-06-22--%>
<%--  Time: 오후 3:54--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%--<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<%@ page session="false" %>--%>
<%--<html>--%>
<%--<head>--%>
<%--  <title>Sha_Jang_Tumbler</title>--%>
<%--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">--%>
<%--  <!-- Bootstrap CSS -->--%>
<%--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"--%>
<%--        rel="stylesheet"--%>
<%--        integrity="sha384-VTmh+5lDQgxBgaA8cD3X2iKQk4YI3sYeEjwA0kaOK1Z3XM3+o2D4w9abEzoS4V6L"--%>
<%--        crossorigin="anonymous"/>--%>

<%--  <!-- Bootstrap Icons -->--%>
<%--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"/>--%>
<%--  <link rel="stylesheet" href="/static/css/globals.css" />--%>
<%--  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">--%>
<%--</head>--%>
<%--&lt;%&ndash;<form>&ndash;%&gt;--%>
<%--<jsp:include page="../common/header.jsp" />--%>
<%--<main class="max-w-4xl mx-auto px-4 py-12">--%>
<%--  <h1 class="text-3xl font-light text-gray-900 mb-8">장바구니</h1>--%>

<%--  <div class="grid lg:grid-cols-3 gap-8">--%>
<%--    <div class="lg:col-span-2 space-y-4">--%>
<%--      <!-- Cart Item 1 -->--%>
<%--      <div class="bg-white border border-beige-200 rounded-lg">--%>
<%--        <div class="p-6">--%>
<%--          <div class="flex gap-4">--%>
<%--            <img src="https://cncmall.kr/web/product/big/202502/2703456d68c31b25b956ed2b83c8d238.jpg"--%>
<%--                 alt="스탠리 텀블러 887ml 퀜처 H2.0 플로우스테이트 대용량 손잡이 빨대 텀블러"--%>
<%--                 class="w-24 h-32 object-cover rounded">--%>
<%--            <div class="flex-1">--%>
<%--              <h3 class="font-medium text-gray-900 mb-1">스탠리 텀블러 887ml 퀜처 H2.0 플로우스테이트 대용량 손잡이 빨대 텀블러</h3>--%>
<%--              <p class="text-sm text-beige-600 mb-2">색상: 베이지</p>--%>
<%--              <p class="text-lg font-light text-gray-900 mb-4">₩189,000</p>--%>

<%--              <div class="flex items-center justify-between">--%>
<%--                <div class="flex items-center gap-2">--%>

<%--                  <!-- +, - 버튼 -->--%>
<%--                  <button class="border border-beige-300 hover:bg-beige-100 w-8 h-8 rounded flex items-center justify-center" onclick="decreaseQuantity(1)">--%>
<%--                    <i data-lucide="minus" class="h-4 w-4"></i>--%>
<%--                  </button>--%>
<%--                  <span id="quantity-1" class="w-8 text-center">1</span>--%>
<%--                  <button class="border border-beige-300 hover:bg-beige-100 w-8 h-8 rounded flex items-center justify-center" onclick="increaseQuantity(1)">--%>
<%--                    <i data-lucide="plus" class="h-4 w-4"></i>--%>
<%--                  </button>--%>
<%--                </div>--%>

<%--                <!-- 휴지통 버튼 -->--%>
<%--                <button onclick="deleteCart()" class="trash-btn text-red-500 hover:text-red-700 p-2">--%>
<%--                  <i data-lucide="trash-2" class="h-4 w-4"></i>--%>
<%--                </button>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </div>--%>

<%--      <!-- Cart Item 2 -->--%>
<%--      <div class="bg-white border border-beige-200 rounded-lg">--%>
<%--        <div class="p-6">--%>
<%--          <div class="flex gap-4">--%>
<%--            <img src="https://shop-phinf.pstatic.net/20211231_110/1640877930540k134U_JPEG/42013829253204192_839401201.jpg?type=m510"--%>
<%--                 alt="스탠리 머그 컵 잔 텀블러 보온 진공 캠핑 머그컵 클래식"--%>
<%--                 class="w-24 h-32 object-cover rounded">--%>
<%--            <div class="flex-1">--%>
<%--              <h3 class="font-medium text-gray-900 mb-1">스탠리 머그 컵 잔 텀블러 보온 진공 캠핑 머그컵 클래식</h3>--%>
<%--              <p class="text-sm text-beige-600 mb-2">색상: 블랙</p>--%>
<%--              <p class="text-lg font-light text-gray-900 mb-4">₩89,000</p>--%>

<%--              <div class="flex items-center justify-between">--%>
<%--                <div class="flex items-center gap-2">--%>

<%--                  <!-- +, - 버튼 -->--%>
<%--                  <button class="border border-beige-300 hover:bg-beige-100 w-8 h-8 rounded flex items-center justify-center" onclick="decreaseQuantity(2)">--%>
<%--                    <i data-lucide="minus" class="h-4 w-4"></i>--%>
<%--                  </button>--%>
<%--                  <span id="quantity-2" class="w-8 text-center">2</span> <!-- 장바구니에 담은 제품 개수 -->--%>
<%--                  <button class="border border-beige-300 hover:bg-beige-100 w-8 h-8 rounded flex items-center justify-center" onclick="increaseQuantity(2)">--%>
<%--                    <i data-lucide="plus" class="h-4 w-4"></i>--%>
<%--                  </button>--%>
<%--                </div>--%>

<%--                <!-- 휴지통 value로 클릭이 되면 컨트롤러에서 제어-->--%>
<%--                <button onclick="deleteCart()" class="trash-btn text-red-500 hover:text-red-700 p-2">--%>
<%--                  <i data-lucide="trash-2" class="h-4 w-4"></i>--%>
<%--                </button>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </div>--%>

<%--    <div>--%>
<%--      <div class="bg-white border border-beige-200 rounded-lg sticky top-24">--%>
<%--        <div class="p-6">--%>
<%--          <h2 class="text-xl font-medium text-gray-900 mb-4">주문 요약</h2>--%>

<%--          <div class="space-y-2 mb-4">--%>
<%--            <div class="flex justify-between text-beige-600">--%>
<%--              <span>상품 금액</span>--%>
<%--              <span id="subtotal">₩367,000</span>--%>
<%--            </div>--%>
<%--            <div class="flex justify-between text-beige-600">--%>
<%--              <span>배송비</span>--%>
<%--              <span>무료</span>--%>
<%--            </div>--%>
<%--            <hr class="border-beige-200">--%>
<%--            <div class="flex justify-between text-lg font-medium text-gray-900">--%>
<%--              <span>총 결제 금액</span>--%>
<%--              <span id="total">₩367,000</span>--%>
<%--            </div>--%>
<%--          </div>--%>

<%--          <a href="/order" class="block w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-3 rounded-lg transition-colors">--%>
<%--            주문하기--%>
<%--          </a>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>
<%--</main>--%>

<%--<script>--%>

<%--  function deleteCart(){--%>
<%--    const trashButtons = document.querySelectorAll(('.trash-btn'))--%>

<%--    trashButtons.forEach((btn) => {--%>
<%--      btn.addEventListener('click', (e) => {--%>
<%--        e.preventDefault();--%>

<%--        const userId = "${userId}";--%>
<%--        const productOptionId = "${productOptionId}";--%>
<%--        sendDeleteCart(userId, productOptionId);--%>

<%--        alert('해당 제품이 삭제 되었습니다.');--%>
<%--      })--%>

<%--    })--%>


<%--  }--%>

<%--  function sendDeleteCart(userId, productOptionId){--%>
<%--    const form = document.createElement('form');--%>
<%--    form.method = 'POST';--%>
<%--    form.action = '/cart';--%>

<%--    const inputUserId = document.createElement('input');--%>
<%--    inputUserId.type = 'hidden';--%>
<%--    inputUserId.name = 'userId';--%>
<%--    inputUserId.value = userId;--%>

<%--    const inputProductOptionId = document.createElement('input');--%>
<%--    inputProductOptionId.type = 'hidden';--%>
<%--    inputProductOptionId.name = 'productOptionId';--%>
<%--    inputProductOptionId.value = productOptionId;--%>

<%--    form.appendChild(inputUserId);--%>
<%--    form.appendChild(inputProductOptionId);--%>

<%--    document.body.appendChild(form);--%>
<%--    form.submit();--%>
<%--  }--%>

<%--  function increaseQuantity(itemId) {--%>
<%--    const quantityElement = document.getElementById('quantity-' + itemId);--%>
<%--    let quantity = parseInt(quantityElement.textContent);--%>
<%--    quantity++;--%>
<%--    quantityElement.textContent = quantity;--%>
<%--    updateTotal();--%>
<%--  }--%>

<%--  function decreaseQuantity(itemId) {--%>
<%--    const quantityElement = document.getElementById('quantity-' + itemId);--%>
<%--    let quantity = parseInt(quantityElement.textContent);--%>
<%--    if (quantity > 1) {--%>
<%--      quantity--;--%>
<%--      quantityElement.textContent = quantity;--%>
<%--      updateTotal();--%>
<%--    }--%>
<%--  }--%>

<%--  function updateTotal() {--%>
<%--    const quantity1 = parseInt(document.getElementById('quantity-1').textContent);--%>
<%--    const quantity2 = parseInt(document.getElementById('quantity-2').textContent);--%>

<%--    const price1 = 189000;--%>
<%--    const price2 = 89000;--%>

<%--    const total = (price1 * quantity1) + (price2 * quantity2);--%>

<%--    document.getElementById('subtotal').textContent = '₩' + total.toLocaleString();--%>
<%--    document.getElementById('total').textContent = '₩' + total.toLocaleString();--%>
<%--  }--%>

<%--  // Initialize Lucide icons--%>
<%--  lucide.createIcons();--%>
<%--</script>--%>
<%--<jsp:include page="../common/footer.jsp" />--%>
<%--&lt;%&ndash;</form>&ndash;%&gt;--%>
<%--</body>--%>
<%--</html>--%>