<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 7:06
  To change this template use File | Settings | File Templates.
--%>

<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<%
    String id = request.getParameter("id");
    if (id == null) id = "1";
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
<main class="max-w-6xl mx-auto px-4 py-12">
    <!-- Back Button -->
    <div class="mb-6">
        <a href="/board" class="flex items-center gap-2 text-beige-600 hover:text-gray-900 transition-colors">
            <i data-lucide="arrow-left" class="h-4 w-4"></i>
            게시판으로 돌아가기
        </a>
    </div>

    <div class="grid lg:grid-cols-3 gap-8">
        <!-- Main Content -->
        <div class="lg:col-span-2">
            <div class="bg-white border border-beige-200 shadow-lg rounded-lg">
                <div class="p-6 border-b border-beige-100">
                    <div class="flex items-start justify-between">
                        <div class="flex-1">
                            <div class="flex items-center gap-2 mb-3">
                                <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">공지사항</span>
                            </div>
                            <h1 class="text-2xl font-light text-gray-900 mb-4">2024 F/W 신상품 출시 안내</h1>
                            <div class="flex items-center gap-6 text-sm text-beige-600">
                                <span class="font-medium">관리자</span>
                                <span>2024-01-15 10:00</span>
                                <div class="flex items-center gap-1">
                                    <i data-lucide="eye" class="h-4 w-4"></i>
                                    <span>245</span>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-2">
                            <button class="text-beige-400 hover:text-gray-900 p-2">
                                <i data-lucide="edit" class="h-4 w-4"></i>
                            </button>
                            <button class="text-beige-400 hover:text-red-500 p-2">
                                <i data-lucide="trash-2" class="h-4 w-4"></i>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="p-8">
                    <!-- Post Content -->
                    <div class="text-gray-900 leading-relaxed mb-8">
                        <p class="mb-4">안녕하세요, STANLEY입니다.</p>
                        <p class="mb-6"다양한 컬러와 사이즈로 언제 어디서나 즐겨요</p>

                        <h3 class="text-xl font-medium mb-4">🍂 New Colors 빛나는 Shimmer 시리즈를 만나보세요</h3>

                        <h4 class="text-lg font-medium mb-2">미니멀 아우터 라인</h4>
                        <ul class="list-disc list-inside mb-4 text-beige-700">
                            <li><strong>베이지 울 코트</strong>: 클래식한 실루엣과 고급스러운 울 소재</li>
                            <li><strong>블랙 트렌치 코트</strong>: 시크하고 모던한 디자인</li>
                            <li><strong>그레이 패딩 재킷</strong>: 따뜻함과 스타일을 모두 잡은 아이템</li>
                        </ul>

                        <h4 class="text-lg font-medium mb-2">니트웨어 컬렉션</h4>
                        <ul class="list-disc list-inside mb-6 text-beige-700">
                            <li><strong>캐시미어 블렌드 스웨터</strong>: 부드럽고 따뜻한 착용감</li>
                            <li><strong>터틀넥 니트</strong>: 베이직하면서도 세련된 디자인</li>
                            <li><strong>카디건</strong>: 레이어링하기 좋은 다양한 컬러</li>
                        </ul>

                        <h3 class="text-xl font-medium mb-4">📅 출시 일정</h3>
                        <ul class="list-disc list-inside mb-6 text-beige-700">
                            <li><strong>1차 출시</strong>: 2024년 1월 20일 (토)</li>
                            <li><strong>2차 출시</strong>: 2024년 2월 5일 (월)</li>
                            <li><strong>3차 출시</strong>: 2024년 2월 20일 (화)</li>
                        </ul>

                        <h3 class="text-xl font-medium mb-4">🎁 런칭 이벤트</h3>
                        <p class="mb-4">신상품 출시를 기념하여 다음과 같은 혜택을 제공합니다:</p>
                        <ol class="list-decimal list-inside mb-6 text-beige-700">
                            <li><strong>얼리버드 할인</strong>: 1차 출시 상품 20% 할인 (선착순 100명)</li>
                            <li><strong>무료 배송</strong>: 전 상품 무료배송 (기간 한정)</li>
                            <li><strong>적립금 2배</strong>: 신상품 구매 시 적립금 2배 적립</li>
                        </ol>

                        <h3 class="text-xl font-medium mb-4">💡 스타일링 팁</h3>
                        <p class="mb-4">이번 시즌 트렌드는 '미니멀 시크'입니다. 베이지, 블랙, 그레이의 뉴트럴 톤으로 깔끔하고 세련된 룩을 연출해보세요.</p>

                        <p class="mb-4">더 자세한 정보는 홈페이지를 통해 확인하실 수 있습니다.</p>

                        <p>감사합니다.</p>
                    </div>

                    <!-- Attachments -->
                    <div class="pt-6 border-t border-beige-100">
                        <h4 class="font-medium text-gray-900 mb-4">첨부파일</h4>
                        <div class="space-y-2">
                            <div class="flex items-center justify-between p-3 bg-beige-50 rounded border border-beige-200">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="download" class="h-4 w-4 text-beige-500"></i>
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">2024_FW_컬렉션_카탈로그.pdf</p>
                                        <p class="text-xs text-beige-500">2.3MB</p>
                                    </div>
                                </div>
                                <button class="text-beige-600 hover:text-gray-900 text-sm">다운로드</button>
                            </div>
                            <div class="flex items-center justify-between p-3 bg-beige-50 rounded border border-beige-200">
                                <div class="flex items-center gap-3">
                                    <i data-lucide="download" class="h-4 w-4 text-beige-500"></i>
                                    <div>
                                        <p class="text-sm font-medium text-gray-900">사이즈_가이드.jpg</p>
                                        <p class="text-xs text-beige-500">856KB</p>
                                    </div>
                                </div>
                                <button class="text-beige-600 hover:text-gray-900 text-sm">다운로드</button>
                            </div>
                        </div>
                    </div>

                    <!-- Post Actions -->
                    <div class="flex items-center justify-between pt-6 border-t border-beige-100">
                        <div class="flex items-center gap-4">
                            <button id="like-btn" class="flex items-center gap-2 text-beige-500 hover:text-red-500 transition-colors">
                                <i data-lucide="thumbs-up" class="h-5 w-5"></i>
                                좋아요 <span id="like-count">18</span>
                            </button>
                            <button class="flex items-center gap-2 text-beige-500 hover:text-gray-900 transition-colors">
                                <i data-lucide="message-circle" class="h-5 w-5"></i>
                                댓글 <span id="comment-count">3</span>
                            </button>
                        </div>
                        <button class="flex items-center gap-2 text-beige-500 hover:text-gray-900 transition-colors">
                            <i data-lucide="share-2" class="h-5 w-5"></i>
                            공유
                        </button>
                    </div>
                </div>
            </div>

            <!-- Comments Section -->
            <div class="bg-white border border-beige-200 shadow-lg rounded-lg mt-6">
                <div class="p-6 border-b border-beige-100">
                    <h2 class="text-xl font-medium text-gray-900">댓글 3개</h2>
                </div>
                <div class="p-6 space-y-6">
                    <!-- Write Comment -->
                    <div class="space-y-4 p-4 bg-beige-50 rounded-lg">
                        <label class="block text-gray-900 font-medium">댓글 작성</label>
                        <textarea id="new-comment" placeholder="댓글을 입력하세요..." rows="4"
                                  class="w-full px-3 py-2 border border-beige-200 rounded-lg focus:border-gray-900 focus:outline-none resize-none"></textarea>
                        <div class="flex justify-end">
                            <button onclick="addComment()" class="bg-gray-900 hover:bg-beige-800 text-white px-4 py-2 rounded-lg transition-colors">
                                댓글 등록
                            </button>
                        </div>
                    </div>

                    <!-- Comments List -->
                    <div id="comments-list" class="space-y-4">
                        <div class="border-t border-beige-100 pt-4">
                            <div class="flex justify-between items-start mb-2">
                                <div class="flex items-center gap-3">
                                    <span class="font-medium text-gray-900">김고객</span>
                                    <span class="text-sm text-beige-500">2024-01-15 14:30</span>
                                </div>
                                <button class="flex items-center gap-1 text-beige-500 hover:text-red-500 transition-colors">
                                    <i data-lucide="thumbs-up" class="h-3 w-3"></i>
                                    5
                                </button>
                            </div>
                            <p class="text-gray-900 leading-relaxed">정말 유용한 정보네요! 감사합니다.</p>
                        </div>

                        <div class="border-t border-beige-100 pt-4">
                            <div class="flex justify-between items-start mb-2">
                                <div class="flex items-center gap-3">
                                    <span class="font-medium text-gray-900">이쇼핑</span>
                                    <span class="text-sm text-beige-500">2024-01-15 15:45</span>
                                </div>
                                <button class="flex items-center gap-1 text-red-500">
                                    <i data-lucide="thumbs-up" class="h-3 w-3 fill-current"></i>
                                    3
                                </button>
                            </div>
                            <p class="text-gray-900 leading-relaxed">저도 같은 문제가 있었는데 해결됐어요. 고맙습니다!</p>
                        </div>

                        <div class="border-t border-beige-100 pt-4">
                            <div class="flex justify-between items-start mb-2">
                                <div class="flex items-center gap-3">
                                    <span class="font-medium text-gray-900">박구매</span>
                                    <span class="text-sm text-beige-500">2024-01-15 16:20</span>
                                </div>
                                <button class="flex items-center gap-1 text-beige-500 hover:text-red-500 transition-colors">
                                    <i data-lucide="thumbs-up" class="h-3 w-3"></i>
                                    2
                                </button>
                            </div>
                            <p class="text-gray-900 leading-relaxed">다음에도 이런 유용한 정보 부탁드려요~</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="space-y-6">
            <!-- Post Navigation -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-4 border-b border-beige-100">
                    <h3 class="text-lg font-medium text-gray-900">게시글 이동</h3>
                </div>
                <div class="p-4 space-y-3">
                    <div>
                        <p class="text-sm text-beige-600 mb-1">이전 글</p>
                        <a href="/boardDetl?id=2" class="text-gray-900 hover:text-beige-600 text-sm transition-colors">
                            배송 지연 안내드립니다
                        </a>
                    </div>
                    <div>
                        <p class="text-sm text-beige-600 mb-1">다음 글</p>
                        <a href="/boardDetl?id=4" class="text-gray-900 hover:text-beige-600 text-sm transition-colors">
                            교환/반품 정책 안내
                        </a>
                    </div>
                </div>
            </div>

            <!-- Related Posts -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-4 border-b border-beige-100">
                    <h3 class="text-lg font-medium text-gray-900">관련 게시글</h3>
                </div>
                <div class="p-4 space-y-3">
                    <a href="/boardDetl?id=2" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                        <div class="flex items-center gap-2 mb-1">
                            <span class="bg-red-100 text-red-700 px-2 py-1 text-xs rounded">공지사항</span>
                        </div>
                        <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">배송 지연 안내드립니다</h4>
                        <div class="flex items-center gap-2 text-xs text-beige-500">
                            <span>2024-01-14</span>
                            <span>•</span>
                            <span>조회 189</span>
                        </div>
                    </a>

                    <a href="/boardDetl?id=4" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                        <div class="flex items-center gap-2 mb-1">
                            <span class="bg-blue-100 text-blue-700 px-2 py-1 text-xs rounded">FAQ</span>
                        </div>
                        <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">교환/반품 정책 안내</h4>
                        <div class="flex items-center gap-2 text-xs text-beige-500">
                            <span>2024-01-12</span>
                            <span>•</span>
                            <span>조회 156</span>
                        </div>
                    </a>

                    <a href="/boardDetl?id=5" class="block hover:bg-beige-50 p-2 rounded transition-colors">
                        <div class="flex items-center gap-2 mb-1">
                            <span class="bg-purple-100 text-purple-700 px-2 py-1 text-xs rounded">이벤트</span>
                        </div>
                        <h4 class="text-sm font-medium text-gray-900 hover:text-beige-600 mb-1 transition-colors">회원 등급별 혜택 안내</h4>
                        <div class="flex items-center gap-2 text-xs text-beige-500">
                            <span>2024-01-11</span>
                            <span>•</span>
                            <span>조회 203</span>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="bg-white border border-beige-200 rounded-lg">
                <div class="p-4 border-b border-beige-100">
                    <h3 class="text-lg font-medium text-gray-900">빠른 메뉴</h3>
                </div>
                <div class="p-4 space-y-2">
                    <a href="/board" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                        전체 게시글 보기
                    </a>
                    <a href="/board/write/.jsp" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                        새 글 작성하기
                    </a>
                    <a href="/board?category=공지사항" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                        공지사항만 보기
                    </a>
                    <a href="/board?category=FAQ" class="block w-full border border-beige-300 text-beige-700 hover:bg-beige-100 px-4 py-2 rounded text-left transition-colors">
                        FAQ 보기
                    </a>
                </div>
            </div>

            <!-- Customer Service -->
            <div class="bg-beige-100 border border-beige-200 rounded-lg">
                <div class="p-4 border-b border-beige-200">
                    <h3 class="text-lg font-medium text-gray-900">고객센터</h3>
                </div>
                <div class="p-4 space-y-3">
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
        </div>
    </div>
</main>

<script>
    let isLiked = false;
    let likeCount = 18;

    document.getElementById('like-btn').addEventListener('click', function() {
        isLiked = !isLiked;
        likeCount = isLiked ? likeCount + 1 : likeCount - 1;

        document.getElementById('like-count').textContent = likeCount;

        const icon = this.querySelector('i');
        if (isLiked) {
            this.classList.remove('text-beige-500');
            this.classList.add('text-red-500');
            icon.classList.add('fill-current');
        } else {
            this.classList.remove('text-red-500');
            this.classList.add('text-beige-500');
            icon.classList.remove('fill-current');
        }
    });

    function addComment() {
        const textarea = document.getElementById('new-comment');
        const content = textarea.value.trim();

        if (content) {
            const commentsList = document.getElementById('comments-list');
            const now = new Date();
            const timestamp = now.toLocaleString('ko-KR');

            const commentDiv = document.createElement('div');
            commentDiv.className = 'border-t border-beige-100 pt-4';
            commentDiv.innerHTML = `
                <div class="flex justify-between items-start mb-2">
                    <div class="flex items-center gap-3">
                        <span class="font-medium text-gray-900">현재사용자</span>
                        <span class="text-sm text-beige-500">${timestamp}</span>
                    </div>
                    <button class="flex items-center gap-1 text-beige-500 hover:text-red-500 transition-colors">
                        <i data-lucide="thumbs-up" class="h-3 w-3"></i>
                        0
                    </button>
                </div>
                <p class="text-gray-900 leading-relaxed">${content}</p>
            `;

            commentsList.appendChild(commentDiv);
            textarea.value = '';

            // Update comment count
            const commentCount = document.getElementById('comment-count');
            commentCount.textContent = parseInt(commentCount.textContent) + 1;

            // Re-initialize Lucide icons
            lucide.createIcons();
        }
    }

    // Initialize Lucide icons
    lucide.createIcons();
</script>
<jsp:include page="../common/footer.jsp" />
</body>
</html>



