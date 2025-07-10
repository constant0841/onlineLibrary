<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<html>
<head>
  <title>Sha_Jang_Tumbler</title>
</head>
<body>
<c:set var="total" value="0" />

<c:forEach var="items" items="${cartList}">
  <p>상품명 : ${items.productName} ${items.color}</p>
  <p>제품 가격 : ${items.finalPrice}</p>
  <p>총 가격 : ${items.finalPrice * items.productCount}</p>

  <!-- 수량 컨트롤 -->
  <form method="POST" action="/cartupdate" style="display: flex; align-items: center; gap: 10px;">
    <input type="hidden" name="userId" value="${items.userId}" />
    <input type="hidden" name="productOptionId" value="${items.productOptionId}" />
    <input type="hidden" id="count-${items.productOptionId}" name="productCount" value="${items.productCount}"/>

    <button type="button" onclick="updateCount(${items.productOptionId}, -1)">-</button>
    <span id="quantity-${items.productOptionId}">${items.productCount}</span>
    <button type="button" onclick="updateCount(${items.productOptionId}, +1)">+</button>
  </form>

    <!-- 삭제 버튼 -->
  <button onclick="deleteCart(${items.userId}, ${items.productOptionId})">삭제</button>
  <hr>

  <c:set var="total" value="${total + (items.finalPrice * items.productCount)}" />


</c:forEach>

<div class="flex justify-between text-lg font-medium text-gray-900">
  <span>총 결제 금액</span>
  <span id="total">${total}</span>
</div>
</body>


<script>

  function updateCount(productOptionId, differential){
    const quantitySpan = document.getElementById('quantity-' + productOptionId);
    const countInput = document.getElementById('count-' + productOptionId);
    const form = countInput.closest('form');

    let count = parseInt(quantitySpan.textContent);
    count = Math.max(1, count + differential);
    quantitySpan.textContent = count;
    countInput.value = count;

    form.submit();
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
</script>
</html>