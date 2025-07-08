<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:54
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
  <link rel="stylesheet" href="/static/css/globals.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<%--<form>--%>
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
                       ${items.finalPrice})" ${items.cartCheckbox ? 'checked' : ''}>
<%--            <p>${items.productName} - ${items.finalPrice}원</p>--%>
<%--            <input type="hidden" name="userId" value="${items.userId}" />--%>
<%--            <input type="hidden" name="productOptionId" value="${items.productOptionId}" />--%>
<%--            <input type="hidden" id="count-${items.productOptionId}" name="productCount" value="${items.productCount}"/>--%>
<%--            <input type="hidden" id="price-${items.productOptionId}" value="${items.finalPrice}">--%>
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


<%--    <form id="orderForm" method="POST" action="/order">--%>
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
<%--    </form>--%>
</main>

<script>

    function toggleItem(checkbox, userId, productOptionId, productCount, finalPrice) {
        updateTotal();

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/cartCheckboxUpdate';

        const inputUserId = document.createElement('input');
        inputUserId.type = 'hidden';
        inputUserId.name = 'userId';
        inputUserId.value = userId;

        const inputProductOptionId = document.createElement('input');
        inputProductOptionId.type = 'hidden';
        inputProductOptionId.name = 'productOptionId';
        inputProductOptionId.value = productOptionId;

        const inputCheck = document.createElement('input');
        inputCheck.type = 'hidden';
        inputCheck.name = 'cartCheckbox';
        inputCheck.value = checkbox.checked;

        form.appendChild(inputUserId);
        form.appendChild(inputProductOptionId);
        form.appendChild(inputCheck);

        document.body.appendChild(form);
        form.submit();
    }

    window.onload = function() {
        updateTotal();
    }

    function updateCount(productOptionId, differential){
        const quantitySpan = document.getElementById('quantity-' + productOptionId);
        const countInput = document.getElementById('count-' + productOptionId);
        const priceInput = document.getElementById('price-' + productOptionId);
        const totalSpan = document.getElementById('total-' + productOptionId);
        const itemTotalSpan = document.getElementById('total-price-' + productOptionId);
        const form = countInput.closest('form');

        let count = parseInt(quantitySpan.textContent);
        const price = parseInt(priceInput.value);
        count = Math.max(1, count + differential);

        quantitySpan.textContent = count;
        countInput.value = count;

        updateTotal();
        //제품별 총합 가격
        if(totalSpan){
            totalSpan.textContent = (count * price).toLocaleString() + '원';
        }

        if(itemTotalSpan) {
            itemTotalSpan.textContent = (count * price).toLocaleString() + '원';
        }

        form.submit();
    }

    function updateTotal() {
        let total = 0;

        const checkboxes = document.querySelectorAll('.cart-item input[type="checkbox"]');

        checkboxes.forEach((checkbox) => {
            if(checkbox.checked){
                const productOptionId = checkbox.getAttribute('data-option-id');
                const countInput = document.getElementById('count-' + productOptionId);
                const priceInput = document.getElementById('price-' + productOptionId);

                const count = parseInt(countInput.value);
                const price = parseInt(priceInput.value);

                total += count * price;
            }
        });
        const totalElement = document.getElementById('total');
        const totalPriceElement = document.getElementById('total-price');

        if(totalElement) {
            totalElement.textContent = total.toLocaleString() + '원';
        }

        if(totalPriceElement) {
            totalPriceElement.textContent = total.toLocaleString() + '원';
        }
        // for(let i = 0 ; i < forms.length ; i++){
        //     const form = forms[i];
        //     const productOptionInput = form.querySelector('input[name="productOptionId"]');
        //     const productOptionId = productOptionInput.value;
        //
        //     const countInput = document.getElementById('count-' + productOptionId);
        //     const priceInput = document.getElementById('price-' + productOptionId);
        //
        //     const count = parseInt(countInput.value);
        //     const price = parseInt(priceInput.value);
        //
        //     total += count * price;

        // }

    }
    // function increaseQuantity(productOptionId) {
    //   const countStock = document.getElementById('quantity-' + productOptionId);
    //   let count = parseInt(countStock.textContent);
    //   count++;
    //   countStock.textContent = count;
    //
    //   updateTotal(productOptionId, count);
    // }
    //
    // function decreaseQuantity(productOptionId) {
    //   const countStock = document.getElementById('quantity-' + productOptionId)
    //   let count = parseInt(countStock.textContent);
    //   if(count > 1) {
    //     count--;
    //     countStock.textContent = count;
    //     updateTotal(productOptionId, count);
    //   }
    // }
    //
    // function updateTotal(productOptionId, count){
    //   const form = document.createElement('form');
    //   form.method = 'POST';
    //   form.action = '/cartupdate';
    //
    //   const inputUserId = document.createElement('input');
    //   inputUserId.type = 'hidden';
    //   inputUserId.name = 'userId';
    //   inputUserId.value = userId;
    //
    //   const inputProductOptionId = document.createElement('input');
    //   inputProductOptionId.type = 'hidden';
    //   inputProductOptionId.name = 'productOptionId';
    //   inputProductOptionId.value = productOptionId;
    //
    //   const inputCount = document.createElement('input');
    //   inputCount.type = 'hidden';
    //   inputCount.name = 'productCount';
    //   inputCount.value = productCount;
    //
    //   form.appendChild(inputUserId);
    //   form.appendChild(inputProductOptionId);
    //   form.appendChild(inputCount);
    //
    //   form.submit();
    // }

    function deleteCart(userId, productOptionId) {
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = '/cartdelete'

        const inputUserId = document.createElement('input');
        inputUserId.type = 'hidden';
        inputUserId.name = 'userId';
        inputUserId.value = userId;

        const inputProductOptionId = document.createElement('input');
        inputProductOptionId.type = 'hidden';
        inputProductOptionId.name = 'productOptionId';
        inputProductOptionId.value = productOptionId;

        form.appendChild(inputUserId);
        form.appendChild(inputProductOptionId);

        document.body.appendChild(form);
        form.submit();
    }

    document.getElementById("orderForm").addEventListener("submit", function(e) {
        const checkboxes = document.querySelectorAll('.cart-item input[type="checkbox"]');
        let hasChecked = false;

        checkboxes.forEach((cb) => {
            if (cb.checked) hasChecked = true;
        });

        if (!hasChecked) {
            e.preventDefault(); // 제출 막기
            alert("주문할 상품이 없습니다.");
        }
    });
</script><jsp:include page="../common/footer.jsp" />
<%--</form>--%>
</body>
</html>