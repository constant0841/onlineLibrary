<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-24
  Time: 오전 11:10
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%
    // 파라미터 받기
    String category = request.getParameter("category");
    String series = request.getParameter("series");
    String special = request.getParameter("special");
    String sort = request.getParameter("sort");
    String search = request.getParameter("search");

    // 기본값 설정
    if (sort == null) sort = "latest";

    // 페이지 제목 설정
    String pageTitle = "전체 상품";
    String pageDescription = "CHIC STORE의 모든 상품을 만나보세요";

    if (category != null) {
        switch(category) {
            case "clas": pageTitle = "클래식 시리즈"; pageDescription = "더 오랫동안 따뜻하고 신선하게"; break;
            case "go": pageTitle = "go 시리즈"; pageDescription = "어디를 가더라도 편리하게"; break;

        }
    } else if (series != null) {
        switch(series) {
            case "adv": pageTitle = "어드벤쳐 시리즈"; pageDescription = "단단한 내구성 + 야외에 최적화"; break;
            case "mas": pageTitle = "마스터시리즈"; pageDescription = "독보적인 경험을 해보세요"; break;

        }
    } else if (special != null) {
        switch(special) {
            case "rega": pageTitle = "레거시 시리즈"; pageDescription = "디자인은 클래식하게,\n" + "성능은 더 뛰어나게"; break;
            case "tita": pageTitle = "티타늄 시리즈"; pageDescription = "혁신적인 제품과 함께 하세요"; break;
        }
    }

    // 상품 데이터 (실제로는 데이터베이스에서 가져와야 함)
    String[][] products = {
            {"1", "클래식 진공 보온병1", "189,000", "220,000", "tita", "minimal", "true", "true", "4.8", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"2", "클래식 진공 보온병2", "89,000", "", "adv", "modern", "false", "false", "4.9", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"3", "클래식 진공 보온병3", "245,000", "", "tita", "classic", "true", "false", "4.7", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"4", "클래식 진공 보온병4", "125,000", "", "adv", "minimal", "false", "false", "4.6", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"5", "클래식 진공 보온병5", "159,000", "189,000", "dress", "minimal", "false", "true", "4.5", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"6", "클래식 진공 보온병6", "198,000", "", "go", "premium", "true", "false", "4.8", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"7", "클래식 진공 보온병7", "145,000", "165,000", "shoes", "classic", "false", "true", "4.4", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"8", "클래식 진공 보온병8", "89,000", "", "go", "premium", "true", "false", "4.7", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"9", "클래식 진공 보온병9", "225,000", "", "tita", "modern", "true", "false", "4.6", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"10", "클래식 진공 보온병10", "189,000", "210,000", "knitwear", "premium", "false", "true", "4.9", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"11", "클래식 진공 보온병11", "98,000", "", "clas", "classic", "false", "false", "4.3", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"},
            {"12", "클래식 진공 보온병12", "245,000", "", "go", "minimal", "true", "false", "4.8", "https://kr.stanley1913.com/cdn/shop/products/B2B_Large_PNG-Master_Trigger_Action_Mug_12oz_Foundry_Black-front_1800x1800_3b4727d1-db34-458c-b3c0-f191847e86c0_720x.png?v=1612220470"}

    };

    // 필터링된 상품 목록 생성
    java.util.List<String[]> filteredProducts = new java.util.ArrayList<>();
    for (String[] product : products) {
        boolean include = true;

        // 카테고리 필터
        if (category != null && !category.equals(product[4])) {
            include = false;
        }

        // 시리즈 필터
        if (series != null && !series.equals(product[5])) {
            include = false;
        }

        // 특별 필터 - 이거 구현해도 되고 안해도 되고 선택 사항입니당 하고 싶으면 더 하고 힘들면 안해도 괜찮아!
        if (special != null) {
            switch(special) {
                case "new":
                    if (!"true".equals(product[6])) include = false;
                    break;
                case "sale":
                    if (!"true".equals(product[7])) include = false;
                    break;
                case "best":
                    if (Double.parseDouble(product[8]) < 4.7) include = false;
                    break;
            }
        }

        // 검색 필터
        if (search != null && !search.trim().isEmpty()) {
            if (!product[1].toLowerCase().contains(search.toLowerCase())) {
                include = false;
            }
        }

        if (include) {
            filteredProducts.add(product);
        }
    }

    // 정렬
    if ("price_low".equals(sort)) {
        filteredProducts.sort((a, b) -> Integer.compare(
                Integer.parseInt(a[2].replace(",", "")),
                Integer.parseInt(b[2].replace(",", ""))
        ));
    } else if ("price_high".equals(sort)) {
        filteredProducts.sort((a, b) -> Integer.compare(
                Integer.parseInt(b[2].replace(",", "")),
                Integer.parseInt(a[2].replace(",", ""))
        ));
    } else if ("rating".equals(sort)) {
        filteredProducts.sort((a, b) -> Double.compare(
                Double.parseDouble(b[8]),
                Double.parseDouble(a[8])
        ));
    }
%>

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
<jsp:include page="../common/header.jsp" />

<main class="max-w-7xl mx-auto px-4 py-12">
    <!-- 페이지 헤더 -->
    <div class="text-center mb-12">
        <h1 class="text-4xl font-light text-gray-900 mb-4"><%= pageTitle %></h1>
        <p class="text-lg text-beige-600 max-w-2xl mx-auto"><%= pageDescription %></p>
        <div class="mt-6">
            <span class="text-sm text-beige-500">총 <%= filteredProducts.size() %>개의 상품</span>
        </div>
    </div>

    <!-- 필터 및 정렬 -->
    <div class="bg-white border border-beige-200 rounded-lg p-6 mb-8">
        <div class="flex flex-col lg:flex-row gap-6">
            <!-- 카테고리 필터 -->
            <div class="flex-1">
                <h3 class="text-sm font-medium text-gray-900 mb-3">카테고리</h3>
                <div class="flex flex-wrap gap-2">
                    <a href="/products" class="<%= category == null ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        전체
                    </a>
                    <a href="/products?category=clas" class="<%= "outer".equals(category) ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        클래식 시리즈
                    </a>
                    <a href="/products?category=go" class="<%= "knitwear".equals(category) ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        go 시리즈
                    </a>
                </div>
            </div>

            <!-- 시리즈 필터 -->
            <div class="flex-1">
                <h3 class="text-sm font-medium text-gray-900 mb-3">시리즈</h3>
                <div class="flex flex-wrap gap-2">
                    <a href="/products<%= category != null ? "?category=" + category : "" %>" class="<%= series == null ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        전체
                    </a>
                    <a href="/products?series=adv<%= category != null ? "&category=" + category : "" %>" class="<%= "minimal".equals(series) ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        어드벤쳐 시리즈
                    </a>
                    <a href="/products?series=mas<%= category != null ? "&category=" + category : "" %>" class="<%= "classic".equals(series) ? "bg-gray-900 text-white" : "bg-beige-100 text-beige-700 hover:bg-beige-200" %> px-3 py-1 rounded-full text-sm transition-colors">
                        마스터시리즈
                    </a>
                </div>
            </div>

            <!-- 검색 및 정렬 -->
            <div class="flex gap-4">
                <!-- 검색 -->
                <form method="get" action="/products" class="flex gap-2">
                    <% if (category != null) { %><input type="hidden" name="category" value="<%= category %>"><% } %>
                    <% if (series != null) { %><input type="hidden" name="series" value="<%= series %>"><% } %>
                    <% if (special != null) { %><input type="hidden" name="special" value="<%= special %>"><% } %>
                    <div class="relative">
                        <i data-lucide="search" class="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-beige-400"></i>
                        <input type="text" name="search" value="<%= search != null ? search : "" %>" placeholder="상품 검색"
                               class="pl-10 pr-4 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none text-sm">
                    </div>
                    <button type="submit" class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                        검색
                    </button>
                </form>

                <!-- 정렬 -->
                <select onchange="changeSort(this.value)" class="px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none text-sm">
                    <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>최신순</option>
                    <option value="price_low" <%= "price_low".equals(sort) ? "selected" : "" %>>가격 낮은순</option>
                    <option value="price_high" <%= "price_high".equals(sort) ? "selected" : "" %>>가격 높은순</option>
                    <option value="rating" <%= "rating".equals(sort) ? "selected" : "" %>>평점순</option>
                </select>
            </div>
        </div>
    </div>

    <!-- 상품 그리드 -->
    <% if (filteredProducts.isEmpty()) { %>
    <div class="text-center py-16">
        <div class="w-16 h-16 bg-beige-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <i data-lucide="search-x" class="h-8 w-8 text-beige-400"></i>
        </div>
        <h3 class="text-xl font-medium text-gray-900 mb-2">검색 결과가 없습니다</h3>
        <p class="text-beige-600 mb-6">다른 검색어나 필터를 시도해보세요</p>
        <a href="/products" class="bg-gray-900 hover:bg-beige-800 text-white px-6 py-3 rounded-lg transition-colors">
            전체 상품 보기
        </a>
    </div>
    <% } else { %>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-8">
        <% for (String[] product : filteredProducts) { %>
        <div class="group bg-white border border-beige-200 shadow-sm hover:shadow-lg transition-all duration-300 rounded-lg overflow-hidden">
            <div class="relative overflow-hidden">
                <img src="<%= product[9] %>" alt="<%= product[1] %>"
                     class="w-full h-80 object-cover group-hover:scale-105 transition-transform duration-500">

                <!-- 배지 -->
                <div class="absolute top-4 left-4 flex flex-col gap-2">
                    <% if ("true".equals(product[6])) { %>
                    <span class="bg-gray-900 text-white px-2 py-1 text-xs rounded">NEW</span>
                    <% } %>
                    <% if ("true".equals(product[7])) { %>
                    <span class="bg-red-500 text-white px-2 py-1 text-xs rounded">SALE</span>
                    <% } %>
                </div>

                <!-- 평점 -->
                <div class="absolute top-4 right-4">
                    <div class="flex items-center gap-1 bg-white/90 px-2 py-1 rounded">
                        <i data-lucide="star" class="h-3 w-3 fill-yellow-400 text-yellow-400"></i>
                        <span class="text-xs font-medium"><%= product[8] %></span>
                    </div>
                </div>

                <!-- 호버 액션 -->
                <div class="absolute inset-0 bg-black/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center">
                    <div class="flex gap-2">
                        <a href="product-detail?id=<%= product[0] %>"
                           class="bg-white hover:bg-gray-100 text-gray-900 p-2 rounded-full transition-colors">
                            <i data-lucide="eye" class="h-4 w-4"></i>
                        </a>
                        <button onclick="addToWishlist('<%= product[0] %>')"
                                class="bg-white hover:bg-gray-100 text-gray-900 p-2 rounded-full transition-colors">
                            <i data-lucide="heart" class="h-4 w-4"></i>
                        </button>
                        <button onclick="quickAddToCart('<%= product[0] %>')"
                                class="bg-white hover:bg-gray-100 text-gray-900 p-2 rounded-full transition-colors">
                            <i data-lucide="shopping-bag" class="h-4 w-4"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="p-6">
                <a href="/productDetl?id=<%= product[0] %>">
                    <h3 class="font-medium text-gray-900 mb-2 group-hover:text-beige-600 transition-colors">
                        <%= product[1] %>
                    </h3>
                </a>

                <div class="flex items-center gap-2 mb-3">
                    <span class="text-xl font-light text-gray-900">₩<%= product[2] %></span>
                    <% if (product[3] != null && !product[3].isEmpty()) { %>
                    <span class="text-sm text-beige-500 line-through">₩<%= product[3] %></span>
                    <% } %>
                </div>

                <!-- 시리즈 태그 -->
                <div class="mb-4">
                            <span class="inline-block bg-beige-100 text-beige-700 px-2 py-1 text-xs rounded">
                                <%= product[5].substring(0, 1).toUpperCase() + product[5].substring(1) %>
                            </span>
                </div>

                <a href="/productDetl?id=<%= product[0] %>"
                   class="block w-full bg-gray-900 hover:bg-beige-800 text-white text-center py-2 rounded-lg opacity-0 group-hover:opacity-100 transition-all duration-300">
                    상품 보기
                </a>
            </div>
        </div>
        <% } %>
    </div>

    <!-- 페이지네이션 -->
    <div class="flex justify-center mt-12">
        <div class="flex gap-2">
            <button class="border border-beige-300 hover:bg-beige-100 px-3 py-2 rounded transition-colors">이전</button>
            <button class="bg-gray-900 text-white px-3 py-2 rounded">1</button>
            <button class="border border-beige-300 hover:bg-beige-100 px-3 py-2 rounded transition-colors">2</button>
            <button class="border border-beige-300 hover:bg-beige-100 px-3 py-2 rounded transition-colors">3</button>
            <button class="border border-beige-300 hover:bg-beige-100 px-3 py-2 rounded transition-colors">다음</button>
        </div>
    </div>
    <% } %>

    <!-- 추천 카테고리 -->
    <div class="mt-16">
        <h2 class="text-2xl font-light text-gray-900 mb-8 text-center">추천 카테고리</h2>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
            <a href="/products?special=new" class="group text-center">
                <div class="w-20 h-20 bg-gradient-to-br from-blue-100 to-blue-200 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                    <i data-lucide="sparkles" class="h-8 w-8 text-blue-600"></i>
                </div>
                <h3 class="font-medium text-gray-900 group-hover:text-beige-600 transition-colors">아무거나</h3>
            </a>

            <a href="/products?special=sale" class="group text-center">
                <div class="w-20 h-20 bg-gradient-to-br from-red-100 to-red-200 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                    <i data-lucide="percent" class="h-8 w-8 text-red-600"></i>
                </div>
                <h3 class="font-medium text-gray-900 group-hover:text-beige-600 transition-colors">강조하고 싶은</h3>
            </a>

            <a href="/products?special=best" class="group text-center">
                <div class="w-20 h-20 bg-gradient-to-br from-yellow-100 to-yellow-200 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                    <i data-lucide="crown" class="h-8 w-8 text-yellow-600"></i>
                </div>
                <h3 class="font-medium text-gray-900 group-hover:text-beige-600 transition-colors">상품을</h3>
            </a>

            <a href="/products?series=premium" class="group text-center">
                <div class="w-20 h-20 bg-gradient-to-br from-purple-100 to-purple-200 rounded-full flex items-center justify-center mx-auto mb-3 group-hover:scale-110 transition-transform">
                    <i data-lucide="gem" class="h-8 w-8 text-purple-600"></i>
                </div>
                <h3 class="font-medium text-gray-900 group-hover:text-beige-600 transition-colors">넣어도 돼요</h3>
            </a>
        </div>
    </div>
</main>

<script>
    // 정렬 변경
    function changeSort(sortValue) {
        const url = new URL(window.location);
        url.searchParams.set('sort', sortValue);
        window.location.href = url.toString();
    }

    // 위시리스트 추가
    function addToWishlist(productId) {
        // 실제로는 서버에 위시리스트 추가 요청
        alert('위시리스트에 추가되었습니다.');
    }

    // 빠른 장바구니 추가
    function quickAddToCart(productId) {
        // 실제로는 서버에 장바구니 추가 요청
        alert('장바구니에 추가되었습니다.');
    }

    // Initialize Lucide icons
    lucide.createIcons();
</script>

<jsp:include page="../common/footer.jsp" />
</body>
</html>


