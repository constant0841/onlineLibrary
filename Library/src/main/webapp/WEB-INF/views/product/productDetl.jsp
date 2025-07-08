<%--
&lt;%&ndash;&lt;%&ndash;
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 8:19
  To change this template use File | Settings | File Templates.
&ndash;%&gt;&ndash;%&gt;--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%


    String id = request.getParameter("id");
    if (id == null) id = "1";

    // 상품 정보 (실제로는 데이터베이스에서 가져와야 함)
    String productImage = "";
    String[] productImages = new String[3];
    String[] details = new String[4];
    String rating = "";

    // ID에 따른 상품 정보 설정
    switch(id) {
        case "1":
            productImage = "https://cncmall.kr/web/product/big/202506/f6cab159c8853a578bca0de9f34b2996.jpg";
            productImages[0] = "\thttps://cncmall.kr/web/product/small/202506/3344f6807cf717fa2454476369dbb2e5.jpg";
            productImages[1] = "https://cncmall.kr/web/product/small/202506/4119f8423895ce30817f430843f7d3dc.jpg";
            productImages[2] = "https://cncmall.kr/web/product/extra/small/202504/daed2afbf8d16bca073001dba7b6d59a.jpg";

            details[0] = "고급 식품 용기 소재로 친환경과 프리미엄도 갖추었어요";
            details[1] = "이중벽 진공 단열";
            details[2] = "누수 방지 플립형 빨대 뚜껑";
            details[3] = "식기세척기 사용 가능";
            rating = "4.8";
            break;
        case "2":
            productImage = "https://cncmall.kr/web/product/big/202506/f6cab159c8853a578bca0de9f34b2996.jpg";
            productImages[0] = "\thttps://cncmall.kr/web/product/small/202506/3344f6807cf717fa2454476369dbb2e5.jpg";
            productImages[1] = "https://cncmall.kr/web/product/small/202506/4119f8423895ce30817f430843f7d3dc.jpg";
            productImages[2] = "https://cncmall.kr/web/product/extra/small/202504/daed2afbf8d16bca073001dba7b6d59a.jpg";
            details[0] = "고급 식품 용기 소재로 친환경과 프리미엄도 갖추었어요";
            details[1] = "이중벽 진공 단열";
            details[2] = "누수 방지 플립형 빨대 뚜껑";
            details[3] = "식기세척기 사용 가능";
            rating = "4.8";
            break;
        case "3":
            productImage = "https://cncmall.kr/web/product/big/202506/f6cab159c8853a578bca0de9f34b2996.jpg";
            productImages[0] = "\thttps://cncmall.kr/web/product/small/202506/3344f6807cf717fa2454476369dbb2e5.jpg";
            productImages[1] = "https://cncmall.kr/web/product/small/202506/4119f8423895ce30817f430843f7d3dc.jpg";
            productImages[2] = "https://cncmall.kr/web/product/extra/small/202504/daed2afbf8d16bca073001dba7b6d59a.jpg";
            details[0] = "고급 식품 용기 소재로 친환경과 프리미엄도 갖추었어요";
            details[1] = "이중벽 진공 단열";
            details[2] = "누수 방지 플립형 빨대 뚜껑";
            details[3] = "식기세척기 사용 가능";
            rating = "4.8";
            break;
        default:
            productImage = "https://cncmall.kr/web/product/big/202506/f6cab159c8853a578bca0de9f34b2996.jpg";
            productImages[0] = "\thttps://cncmall.kr/web/product/small/202506/3344f6807cf717fa2454476369dbb2e5.jpg";
            productImages[1] = "https://cncmall.kr/web/product/small/202506/4119f8423895ce30817f430843f7d3dc.jpg";
            productImages[2] = "https://cncmall.kr/web/product/extra/small/202504/daed2afbf8d16bca073001dba7b6d59a.jpg";
            details[0] = "고급 식품 용기 소재로 친환경과 프리미엄도 갖추었어요";
            details[1] = "이중벽 진공 단열";
            details[2] = "누수 방지 플립형 빨대 뚜껑";
            details[3] = "식기세척기 사용 가능";
            rating = "4.8";
            break;
    }
%>

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
<c:forEach var="productResponse" items="${productResponse}">
<c:forEach var="detail" items="${productResponse.productDetail}">
<jsp:include page="../common/header.jsp" />
<main class="max-w-7xl mx-auto px-4 py-12">

    <form id="addToCartForm" action="/prdDetlCartUpdate" method="post">
        <input type="hidden" name="productId" value="${productResponse.product.id}">
        <input type="hidden" id="cartSelectedColorInput" name="color" value="">
        <input type="hidden" id="cartSelectedSizeInput" name="size" value="">
        <input type="hidden" id="cartQuantityInput" name="quantity" value="1">
    </form>

    <form id="addToOrderForm" action="/order1" method="post">
        <input type="hidden" name="productId" value="${productResponse.product.id}">
        <input type="hidden" id="orderSelectedColorInput" name="color" value="">
        <input type="hidden" id="orderSelectedSizeInput" name="size" value="">
        <input type="hidden" id="orderQuantityInput" name="quantity" value="1">
    </form>



    <div class="grid lg:grid-cols-2 gap-12">
        <!-- Product Images -->
        <div class="space-y-4">
            <div class="aspect-[3/4] relative overflow-hidden rounded-lg">
                <img id="main-image" src="<%= productImage %>" alt="${productResponse.product.name}"
                     class="w-full h-full object-cover">
            </div>
            <div class="grid grid-cols-3 gap-4">
                <% for(int i = 0; i < productImages.length; i++) { %>
                <div class="aspect-[3/4] relative overflow-hidden rounded-lg cursor-pointer hover:opacity-80 transition-opacity"
                     onclick="changeMainImage('<%= productImages[i] %>')">
                    <img src="<%= productImages[i] %>" alt="${productResponse.product.name} <%= i + 1 %>"
                         class="w-full h-full object-cover">
                </div>
                <% } %>
            </div>
        </div>

        <!-- Product Info -->
        <div class="space-y-6">
            <div>
                <h1 class="text-3xl font-light text-gray-900 mb-2">${productResponse.product.name}</h1>
                <div class="flex items-center gap-4">
                    <p class="text-3xl font-light text-gray-900">₩ ${productResponse.product.price}</p>
                </div>
                <div class="flex items-center gap-2 mt-2">
                    <div class="flex items-center">
                        <% for(int i = 0; i < 5; i++) { %>
                        <i data-lucide="star" class="h-4 w-4 fill-yellow-400 text-yellow-400"></i>
                        <% } %>
                    </div>
                    <span class="text-sm text-beige-600">(<%= rating %>)</span>
                </div>
            </div>

            <p class="text-beige-600 leading-relaxed">${detail.productStrengths}</p>

            <!-- color -->
            <div>
                <h3 class="text-lg font-medium text-gray-900 mb-3">색상</h3>
                <div class="flex gap-2">
                    <c:forEach var="color" items="${productResponse.productDetail[0].color}">
                        <button class="color-btn border-2 border-gray-300 text-gray-700 hover:border-gray-900 px-4 py-2 rounded-lg transition-colors"
                                onclick='selectColor(this, "${color}")'>
                                ${color}
                        </button>
                    </c:forEach>
                </div>
            </div>

            <!-- size -->
            <div>
                <h3 class="text-lg font-medium text-gray-900 mb-3">사이즈</h3>
                <div class="flex gap-2">
                    <c:forEach var="sizeOption" items="${productResponse.productDetail[0].sizeOptions}">
                        <button class="size-btn border-2 border-gray-300 text-gray-700 hover:border-gray-900 px-4 py-2 rounded-lg transition-colors"
                                onclick='selectSize(this, "${sizeOption.size}")'>
                                ${sizeOption.size}
                            <c:if test="${not empty sizeOption.additionalPrice && sizeOption.additionalPrice ne '0'}">
                                (+${sizeOption.additionalPrice})
                            </c:if>
                        </button>
                    </c:forEach>
                </div>
            </div>

            <!-- Quantity -->
            <div>
                <h3 class="text-lg font-medium text-gray-900 mb-3">수량</h3>
                <div class="flex items-center gap-2">
                    <button class="border border-beige-300 hover:bg-beige-100 w-10 h-10 rounded-lg flex items-center justify-center transition-colors"
                            onclick="decreaseQuantity()">
                        <i data-lucide="minus" class="h-4 w-4"></i>
                    </button>
                    <span id="quantity" class="w-12 text-center text-gray-900 font-medium">1</span>
                    <button class="border border-beige-300 hover:bg-beige-100 w-10 h-10 rounded-lg flex items-center justify-center transition-colors"
                            onclick="increaseQuantity()">
                        <i data-lucide="plus" class="h-4 w-4"></i>
                    </button>
                </div>
            </div>

            <!-- Actions -->
            <div class="flex gap-4">
                <button onclick="addToCart()" class="flex-1 bg-gray-900 hover:bg-beige-800 text-white py-3 px-6 rounded-lg transition-colors">
                    장바구니
                </button>
                <button class="border border-beige-300 hover:bg-beige-100 p-3 rounded-lg transition-colors">
                    <i data-lucide="heart" class="h-5 w-5"></i>
                </button>
                <button class="border border-beige-300 hover:bg-beige-100 p-3 rounded-lg transition-colors">
                    <i data-lucide="share-2" class="h-5 w-5"></i>
                </button>
            </div>

            <!-- Buy Now Button -->
            <button onclick="buyNow()" class="w-full border-2 border-gray-900 text-gray-900 hover:bg-beige-900 hover:text-white py-3 px-6 rounded-lg transition-colors">
                구매하기
            </button>

            <!-- Product Details -->
            <div class="bg-white border border-beige-200 rounded-lg p-6">
                <h3 class="text-lg font-medium text-gray-900 mb-4">상품 정보</h3>
                <ul class="space-y-2">
                    <% for(String detail : details) { %>
                    <li class="text-beige-600">• <%= detail %></li>
                    <% } %>
                </ul>
            </div>

            <!-- Shipping Info -->
            <div class="bg-beige-50 border border-beige-200 rounded-lg p-6">
                <h3 class="text-lg font-medium text-gray-900 mb-4">배송 정보</h3>
                <div class="space-y-2 text-sm">
                    <div class="flex justify-between">
                        <span class="text-beige-600">배송비</span>
                        <span class="text-gray-900">5만원 이상 무료배송</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">배송기간</span>
                        <span class="text-gray-900">주문 후 2-3일</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-beige-600">배송지역</span>
                        <span class="text-gray-900">전국 (제주도 별도)</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Tabs -->
    <div class="mt-16">
        <div class="border-b border-beige-200">
            <nav class="flex space-x-8">
                <button class="tab-btn py-4 px-1 border-b-2 border-gray-900 text-gray-900 font-medium"
                        onclick="showTab('description')">
                    상품 설명
                </button>
                <button class="tab-btn py-4 px-1 border-b-2 border-transparent text-beige-600 hover:text-gray-900 transition-colors"
                        onclick="showTab('size-guide')">
                    사이즈 가이드
                </button>
                <button class="tab-btn py-4 px-1 border-b-2 border-transparent text-beige-600 hover:text-gray-900 transition-colors"
                        onclick="showTab('reviews')">
                    리뷰 (24)
                </button>
                <button class="tab-btn py-4 px-1 border-b-2 border-transparent text-beige-600 hover:text-gray-900 transition-colors"
                        onclick="showTab('qna')">
                    Q&A (3)
                </button>
            </nav>
        </div>

        <!-- Tab Contents -->
        <div class="py-8">
            <!-- Description Tab -->
            <div id="description-tab" class="tab-content">
                <div class="prose max-w-none">
                    <h3 class="text-xl font-medium text-gray-900 mb-4">상품 상세 설명</h3>
                    <p class="text-beige-600 leading-relaxed mb-6">${details.productStrengths}</p>

                    <div class="grid md:grid-cols-2 gap-8 mb-8">
                        <div>
                            <h4 class="font-medium text-gray-900 mb-3">특징</h4>
                            <ul class="space-y-2 text-beige-600">
                                <li>• 상쾌하고 깨끗하게</li>
                                <li>• 우수한 살균효과</li>
                                <li>• 100% 자연 친화적 성분</li>
                                <li>• 쉽고 편리한 세척</li>
                            </ul>
                        </div>
                        <div>
                            <h4 class="font-medium text-gray-900 mb-3">관리 방법</h4>
                            <ul class="space-y-2 text-beige-600">
                                <li>• 용기에 따뜻한 물을 채우고 타블렛 하나를 넣어주세요</li>
                                <li>• 15분정도 기다린 후 용기를 흔들어주세요</li>
                                <li>• 용기의 물을 버리고 용기를 깨끗이 헹궈주세요</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Size Guide Tab -->
            <div id="size-guide-tab" class="tab-content hidden">
                <h3 class="text-xl font-medium text-gray-900 mb-6">사이즈 가이드</h3>
                <div class="overflow-x-auto">
                    <table class="w-full border-collapse border border-beige-200">
                        <thead>
                        <tr class="bg-beige-50">
                            <th class="border border-beige-200 px-4 py-3 text-left font-medium text-gray-900">사이즈</th>
                            <th class="border border-beige-200 px-4 py-3 text-left font-medium text-gray-900">총장</th>
                            <th class="border border-beige-200 px-4 py-3 text-left font-medium text-gray-900">가슴둘레</th>
                            <th class="border border-beige-200 px-4 py-3 text-left font-medium text-gray-900">소매길이</th>
                            <th class="border border-beige-200 px-4 py-3 text-left font-medium text-gray-900">어깨너비</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td class="border border-beige-200 px-4 py-3 font-medium">S</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">60cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">88cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">58cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">40cm</td>
                        </tr>
                        <tr class="bg-beige-50">
                            <td class="border border-beige-200 px-4 py-3 font-medium">M</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">62cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">92cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">59cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">42cm</td>
                        </tr>
                        <tr>
                            <td class="border border-beige-200 px-4 py-3 font-medium">L</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">64cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">96cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">60cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">44cm</td>
                        </tr>
                        <tr class="bg-beige-50">
                            <td class="border border-beige-200 px-4 py-3 font-medium">XL</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">66cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">100cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">61cm</td>
                            <td class="border border-beige-200 px-4 py-3 text-beige-600">46cm</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="mt-6 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
                    <p class="text-sm text-yellow-800">
                        <strong>측정 방법:</strong> 상품을 평평한 곳에 놓고 측정한 단면 치수입니다.
                        측정 방법과 위치에 따라 1-3cm 오차가 있을 수 있습니다.
                    </p>
                </div>
            </div>

            <!-- Reviews Tab -->
            <div id="reviews-tab" class="tab-content hidden">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-xl font-medium text-gray-900">고객 리뷰 (24)</h3>
                    <button class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg transition-colors">
                        리뷰 작성
                    </button>
                </div>

                <!-- Review Summary -->
                <div class="bg-beige-50 p-6 rounded-lg mb-6">
                    <div class="flex items-center gap-4 mb-4">
                        <div class="text-3xl font-light text-gray-900"><%= rating %></div>
                        <div>
                            <div class="flex items-center mb-1">
                                <% for(int i = 0; i < 5; i++) { %>
                                <i data-lucide="star" class="h-4 w-4 fill-yellow-400 text-yellow-400"></i>
                                <% } %>
                            </div>
                            <p class="text-sm text-beige-600">24개의 리뷰</p>
                        </div>
                    </div>
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                        <div>
                            <p class="text-sm text-beige-600">핏</p>
                            <p class="font-medium text-gray-900">적당함</p>
                        </div>
                        <div>
                            <p class="text-sm text-beige-600">소재</p>
                            <p class="font-medium text-gray-900">우수함</p>
                        </div>
                        <div>
                            <p class="text-sm text-beige-600">색상</p>
                            <p class="font-medium text-gray-900">만족</p>
                        </div>
                        <div>
                            <p class="text-sm text-beige-600">추천도</p>
                            <p class="font-medium text-gray-900">95%</p>
                        </div>
                    </div>
                </div>

                <!-- Individual Reviews -->
                <div class="space-y-6">
                    <div class="border-b border-beige-200 pb-6">
                        <div class="flex items-start gap-4">
                            <div class="w-10 h-10 bg-beige-200 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-gray-900">김**</span>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <div class="flex items-center">
                                        <% for(int i = 0; i < 5; i++) { %>
                                        <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                        <% } %>
                                    </div>
                                    <span class="text-sm text-beige-600">2024.01.10</span>
                                    <span class="text-sm text-beige-600">크림2.0 10-10827-649</span>
                                </div>
                                <p class="text-gray-900 mb-3">
                                    당장 커피 사러 나갔는데 다음날까지 얼음이 안 녹고 그대로라서 놀랐어요ㅋㅋㅋ
                                    처음 왔을 때 상태를 확인하는데 뚜껑 아랫부분에 약간의 기스가 있었지만 잘 안 보여서 신경 쓰지는 않았어요ㅋㅋㅋ
                                    무엇보다 손잡이가 있어서 들고 다닐 때 너무 편합니다👍🏻👍🏻
                                </p>
                                <div class="flex gap-2">
                                    <img src="https://img1.kakaocdn.net/thumb/S578x578@2x.fwebp.…40419134900_e88ffbdf25504a91a53b18294fd9a8a1.jpeg"
                                         alt="리뷰 이미지" class="w-16 h-16 object-cover rounded">
                                    <img src="	https://img1.kakaocdn.net/thumb/S578x578@2x.fwebp.…250527211712_d67f750dccda4e8a9fc2d9a4096a6990.jpg"
                                         alt="리뷰 이미지" class="w-16 h-16 object-cover rounded">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="border-b border-beige-200 pb-6">
                        <div class="flex items-start gap-4">
                            <div class="w-10 h-10 bg-beige-200 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-gray-900">이**</span>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <div class="flex items-center">
                                        <% for(int i = 0; i < 4; i++) { %>
                                        <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                        <% } %>
                                        <i data-lucide="star" class="h-3 w-3 text-beige-300"></i>
                                    </div>
                                    <span class="text-sm text-beige-600">2024.01.08</span>
                                    <span class="text-sm text-beige-600">블루베리밀크 10-10829-263</span>
                                </div>
                                <p class="text-gray-900">
                                    유행다 지나서 이제야 구매합니당 원래는 다른컬러사려고 했다가 새로나온 색으로 질렀는데 진짜 너무 이쁨니다요ㅠㅠ 잘 쓸게요
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="border-b border-beige-200 pb-6">
                        <div class="flex items-start gap-4">
                            <div class="w-10 h-10 bg-beige-200 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-gray-900">박**</span>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <div class="flex items-center">
                                        <% for(int i = 0; i < 5; i++) { %>
                                        <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                                        <% } %>
                                    </div>
                                    <span class="text-sm text-beige-600">2024.01.05</span>
                                    <span class="text-sm text-beige-600">펄화이트 10-10829-262</span>
                                </div>
                                <p class="text-gray-900">
                                    은은한 오로라빛펄 화이트 정말 예뻐요^^
                                    안에 닦을 때 긴 솔도 필요없고요^^
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-8">
                    <button class="border border-beige-300 text-beige-700 hover:bg-beige-100 px-6 py-2 rounded-lg transition-colors">
                        더 많은 리뷰 보기
                    </button>
                </div>
            </div>

            <!-- Q&A Tab -->
            <div id="qna-tab" class="tab-content hidden">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-xl font-medium text-gray-900">상품 Q&A (3)</h3>
                    <button class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg transition-colors">
                        문의하기
                    </button>
                </div>

                <div class="space-y-4">
                    <div class="bg-white border border-beige-200 rounded-lg p-6">
                        <div class="flex items-start gap-4">
                            <div class="w-8 h-8 bg-blue-100 text-blue-700 rounded-full flex items-center justify-center text-sm font-medium">
                                Q
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="font-medium text-gray-900">김고객</span>
                                    <span class="text-sm text-beige-600">2024.01.12</span>
                                </div>
                                <p class="text-gray-900 mb-4">애쉬 색상 중 뚜껑도 같이 회색인건 몇미리짜리 제품이에요? 살세페이지랑 후기에 올라온게 달라서요</p>

                                <div class="flex items-start gap-4 bg-beige-50 p-4 rounded-lg">
                                    <div class="w-8 h-8 bg-green-100 text-green-700 rounded-full flex items-center justify-center text-sm font-medium">
                                        A
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center gap-2 mb-2">
                                            <span class="font-medium text-gray-900">STANLEY</span>
                                            <span class="text-sm text-beige-600">2024.01.12</span>
                                        </div>
                                        <p class="text-gray-900">
                                            고객님 안녕하세요.
                                            말씀하신 애쉬색상의 뚜껑도 회색인 제품은 2.0이 아닌 제품으로 현재 품절되어 재입고미정입니다. 애쉬2.0 색상은 뚜껑이 흰색인 점 참고부탁드립니다
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white border border-beige-200 rounded-lg p-6">
                        <div class="flex items-start gap-4">
                            <div class="w-8 h-8 bg-blue-100 text-blue-700 rounded-full flex items-center justify-center text-sm font-medium">
                                Q
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="font-medium text-gray-900">이쇼핑</span>
                                    <span class="text-sm text-beige-600">2024.01.10</span>
                                </div>
                                <p class="text-gray-900 mb-4">재입고 예정이 있나요?</p>

                                <div class="flex items-start gap-4 bg-beige-50 p-4 rounded-lg">
                                    <div class="w-8 h-8 bg-green-100 text-green-700 rounded-full flex items-center justify-center text-sm font-medium">
                                        A
                                    </div>
                                    <div class="flex-1">
                                        <div class="flex items-center gap-2 mb-2">
                                            <span class="font-medium text-gray-900">STANLEY</span>
                                            <span class="text-sm text-beige-600">2024.01.10</span>
                                        </div>
                                        <p class="text-gray-900">
                                            현재 일부 사이즈가 품절된 상태입니다. 2월 중순경 재입고 예정이며,
                                            재입고 알림 신청을 해주시면 입고 시 안내드리겠습니다.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="bg-white border border-beige-200 rounded-lg p-6">
                        <div class="flex items-start gap-4">
                            <div class="w-8 h-8 bg-blue-100 text-blue-700 rounded-full flex items-center justify-center text-sm font-medium">
                                Q
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="font-medium text-gray-900">박구매</span>
                                    <span class="text-sm text-beige-600">2024.01.08</span>
                                    <span class="bg-yellow-100 text-yellow-800 px-2 py-1 text-xs rounded">답변대기</span>
                                </div>
                                <p class="text-gray-900">다른 색상 출시 계획이 있나요?</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Related Products -->
    <div class="mt-16">
        <h2 class="text-2xl font-light text-gray-900 mb-8">관련 상품</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            <!-- Related Product 1 -->
            <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                <div class="relative overflow-hidden">
                    <img src="https://shop-phinf.pstatic.net/20250226_147/1740549719615bNqhD_PNG/51504593507427116_595174436.png?type=m510"
                         alt="1개+1개 DIYOU 90% 밀폐 스텐 대용량 텀블러 900ml 손잡이 텀블러(뚜껑,손잡이 포함)"
                         class="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-500">
                </div>
                <div class="p-4">
                    <h3 class="font-medium text-gray-900 mb-2">1개+1개 DIYOU 90% 밀폐 스텐 대용량 텀블러 900ml 손잡이 텀블러(뚜껑,손잡이 포함)</h3>
                    <p class="text-lg font-light text-gray-900">₩89,000</p>
                </div>
            </div>

            <!-- Related Product 2 -->
            <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                <div class="relative overflow-hidden">
                    <img src="https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=300&h=400&fit=crop"
                         alt="스탠리 퀜처 H2.0 플로우스테이트 보온 보냉 빨대 손잡이 텀블러 591ml 20온스"
                         class="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-500">
                </div>
                <div class="p-4">
                    <h3 class="font-medium text-gray-900 mb-2">스탠리 퀜처 H2.0 플로우스테이트 보온 보냉 빨대 손잡이 텀블러 591ml 20온스</h3>
                    <p class="text-lg font-light text-gray-900">₩245,000</p>
                </div>
            </div>

            <!-- Related Product 3 -->
            <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                <div class="relative overflow-hidden">
                    <img src="https://shop-phinf.pstatic.net/20250217_229/1739768604638FEh8L_JPEG/30954784340902937_184161788.jpg?type=m510"
                         alt="스탠리 아이스플로우 플립 스트로 2.0 텀블러 887m"
                         class="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-500">
                </div>
                <div class="p-4">
                    <h3 class="font-medium text-gray-900 mb-2">스탠리 아이스플로우 플립 스트로 2.0 텀블러 887m</h3>
                    <p class="text-lg font-light text-gray-900">₩125,000</p>
                </div>
            </div>

            <!-- Related Product 4 -->
            <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
                <div class="relative overflow-hidden">
                    <img src="https://shop-phinf.pstatic.net/20241011_62/1728658155335k8LEV_JPEG/8233519206248626_1647702423.JPG?type=m510"
                         alt="스탠리 591 텀블러 퀜처 H2.0 플로우스테이트 차량용 텀블러"
                         class="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-500">
                </div>
                <div class="p-4">
                    <h3 class="font-medium text-gray-900 mb-2">스탠리 591 텀블러 퀜처 H2.0 플로우스테이트 차량용 텀블러</h3>
                    <p class="text-lg font-light text-gray-900">₩159,000</p>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    let selectedColor = '';
    let selectedSize = '';
    let quantity = 1;

    // Change main product image
    function changeMainImage(imageSrc) {
        document.getElementById('main-image').src = imageSrc;
    }

    function selectColor(button, color) {
        document.querySelectorAll('.color-btn').forEach(btn => btn.classList.remove('border-gray-900'));
        button.classList.add('border-gray-900');
        selectedColor = color;
        console.log('selectedColor set to:', selectedColor);
    }

    function selectSize(button, size) {
        document.querySelectorAll('.size-btn').forEach(btn => btn.classList.remove('bg-gray-100'));
        button.classList.add('bg-gray-100');
        selectedSize = size;
        console.log('selectedSize set to:', selectedSize);
    }

    function increaseQuantity() {
        quantity++;
        document.getElementById('quantity').textContent = quantity;
        document.getElementById('quantityInput').value = quantity;
    }

    function decreaseQuantity() {
        if (quantity > 1) {
            quantity--;
            document.getElementById('quantity').textContent = quantity;
            document.getElementById('quantityInput').value = quantity;
        }
    }

    function addToCart() {
        if (!selectedColor) {
            alert('색상을 선택해주세요.');
            return;
        }
        if (!selectedSize) {
            alert('사이즈를 선택해주세요.');
            return;
        }

        document.getElementById('cartSelectedColorInput').value = selectedColor;
        document.getElementById('cartSelectedSizeInput').value = selectedSize;
        document.getElementById('cartQuantityInput').value = quantity;
        document.getElementById('addToCartForm').submit();
    }

    function buyNow() {
        if (!selectedColor) {
            alert('색상을 선택해주세요.');
            return;
        }
        if (!selectedSize) {
            alert('사이즈를 선택해주세요.');
            return;
        }

        document.getElementById('orderSelectedColorInput').value = selectedColor;
        document.getElementById('orderSelectedSizeInput').value = selectedSize;
        document.getElementById('orderQuantityInput').value = quantity;
        document.getElementById('addToOrderForm').submit();
    }


    // Tab functionality
    function showTab(tabName) {
        // Hide all tab contents
        document.querySelectorAll('.tab-content').forEach(content => {
            content.classList.add('hidden');
        });

        // Remove active class from all tab buttons
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.classList.remove('border-gray-900', 'text-gray-900');
            btn.classList.add('border-transparent', 'text-beige-600');
        });

        // Show selected tab content
        document.getElementById(tabName + '-tab').classList.remove('hidden');

        // Add active class to selected tab button
        event.target.classList.remove('border-transparent', 'text-beige-600');
        event.target.classList.add('border-gray-900', 'text-gray-900');
    }
    // Initialize Lucide icons
    lucide.createIcons();
</script>

<jsp:include page="../common/footer.jsp" />
</body>
</c:forEach>
</c:forEach>
</html>