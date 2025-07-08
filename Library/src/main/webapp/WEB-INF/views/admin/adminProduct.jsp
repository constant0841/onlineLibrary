<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookHub 관리자 - 상품 관리</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
    <style>
        .beige-100 { background-color: #f7f5f3; }
        .beige-200 { background-color: #ede8e3; }
        .beige-300 { background-color: #e3ddd6; }
        .beige-600 { color: #8b7355; }
        .beige-700 { color: #6b5b47; }
        .beige-800 { background-color: #5a4a38; }
        .text-beige-600 { color: #8b7355; }
        .text-beige-700 { color: #6b5b47; }
        .border-beige-200 { border-color: #ede8e3; }
        .border-beige-300 { border-color: #e3ddd6; }
        .bg-beige-800:hover { background-color: #5a4a38; }

        .file-upload-area {
            border: 2px dashed #e3ddd6;
            transition: all 0.3s ease;
        }
        .file-upload-area:hover {
            border-color: #8b7355;
            background-color: #f7f5f3;
        }
        .file-upload-area.dragover {
            border-color: #6b5b47;
            background-color: #ede8e3;
        }
    </style>
</head>
<body class="bg-gray-50">

<header class="bg-white shadow-sm border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center">
                <a href="/admin" class="text-2xl font-light text-gray-900 hover:text-beige-600 transition-colors">
                    <span class="text-beige-600">Book</span>Hub <span class="text-sm text-gray-500">관리자</span>
                </a>
            </div>
            <nav class="flex items-center space-x-6">
                <a href="/admin/product" class="text-beige-600 font-medium">상품 관리</a>
                <a href="/admin/category" class="text-gray-700 hover:text-beige-600 transition-colors">카테고리 관리</a>
                <a href="/admin/order" class="text-gray-700 hover:text-beige-600 transition-colors">주문 관리</a>
                <a href="/admin/member" class="text-gray-700 hover:text-beige-600 transition-colors">회원 관리</a>
                <a href="/admin/stock" class="text-gray-700 hover:text-beige-600 transition-colors">재고 관리</a>
            </nav>
            <div class="flex items-center space-x-3">
                <a href="/" class="text-gray-700 hover:text-beige-600 transition-colors">
                    <i data-lucide="external-link" class="h-5 w-5 mr-1 inline"></i>
                    사용자 화면
                </a>
                <a href="/logout" class="text-gray-700 hover:text-beige-600 transition-colors">
                    <i data-lucide="log-out" class="h-5 w-5 mr-1 inline"></i>
                    로그아웃
                </a>
            </div>
        </div>
    </div>
</header>

<div class="bg-white border-b border-beige-200">
    <div class="max-w-7xl mx-auto px-4 py-3">
        <nav class="flex" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="/admin" class="text-beige-600 hover:text-beige-700">관리자</a></li>
                <li><i data-lucide="chevron-right" class="h-4 w-4 text-gray-400"></i></li>
                <li class="text-gray-900">상품 관리</li>
            </ol>
        </nav>
    </div>
</div>

<main class="max-w-7xl mx-auto px-4 py-8">
    <div class="bg-white shadow-sm rounded-lg border border-beige-200 mb-8">
        <div class="px-6 py-4 border-b border-beige-200">
            <h2 class="text-xl font-light text-gray-900 flex items-center">
                <i data-lucide="plus-circle" class="h-5 w-5 mr-2 text-beige-600"></i>
                상품 등록
            </h2>
        </div>

        <form id="productForm" class="p-6" enctype="multipart/form-data">
            <!-- 기본 정보 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <div class="space-y-4">
                    <div>
                        <label for="product_name" class="block text-sm font-medium text-gray-700 mb-2">상품명 *</label>
                        <input type="text" id="product_name" name="product_name" required
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 자바의 정석">
                    </div>

                    <!-- 새로 추가: ISBN -->
                    <div>
                        <label for="isbn" class="block text-sm font-medium text-gray-700 mb-2">ISBN *</label>
                        <input type="text" id="isbn" name="isbn" required
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 978-89-7914-206-9">
                    </div>

                    <div>
                        <label for="author" class="block text-sm font-medium text-gray-700 mb-2">저자 *</label>
                        <input type="text" id="author" name="author" required
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 남궁성">
                    </div>
                    <div>
                        <label for="publisher" class="block text-sm font-medium text-gray-700 mb-2">출판사 *</label>
                        <input type="text" id="publisher" name="publisher" required
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 도우출판">
                    </div>
                    <div>
                        <label for="product_size" class="block text-sm font-medium text-gray-700 mb-2">상품 크기</label>
                        <input type="text" id="product_size" name="product_size"
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 188×257mm">
                    </div>
                </div>
                <div class="space-y-4">
                    <div>
                        <label for="product_price" class="block text-sm font-medium text-gray-700 mb-2">가격 *</label>
                        <input type="number" id="product_price" name="product_price" required min="0"
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 35000">
                    </div>
                    <div>
                        <label for="stock_quantity" class="block text-sm font-medium text-gray-700 mb-2">재고 수량 *</label>
                        <input type="number" id="stock_quantity" name="stock_quantity" required min="0"
                               class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                               placeholder="예: 100">
                    </div>
                    <div>
                        <label for="sales_status" class="block text-sm font-medium text-gray-700 mb-2">판매 상태 *</label>
                        <select id="sales_status" name="sales_status" required
                                class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent">
                            <option value="">선택하세요</option>
                            <option value="판매중">판매중</option>
                            <option value="일시품절">일시품절</option>
                            <option value="절판">절판</option>
                            <option value="입고예정">입고예정</option>
                        </select>
                    </div>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label for="product_rating" class="block text-sm font-medium text-gray-700 mb-2">평점 (1-5)</label>
                            <input type="number" id="product_rating" name="product_rating" min="1" max="5" step="0.1"
                                   class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                   placeholder="예: 4.5">
                        </div>
                        <!-- 새로 추가: 판매지수 -->
                        <div>
                            <label for="sales_index" class="block text-sm font-medium text-gray-700 mb-2">판매지수</label>
                            <input type="number" id="sales_index" name="sales_index" min="0"
                                   class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                                   placeholder="예: 85">
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-6">
                <label for="product_description" class="block text-sm font-medium text-gray-700 mb-2">상품 설명 *</label>
                <textarea id="product_description" name="product_description" rows="6" required
                          class="w-full px-3 py-2 border border-beige-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-beige-600 focus:border-transparent"
                          placeholder="상품에 대한 상세 설명을 입력하세요..."></textarea>
            </div>

            <!-- 파일 업로드 섹션 -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
                <!-- 책 이미지 업로드 -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">책 이미지</label>
                    <div class="file-upload-area rounded-lg p-6 text-center cursor-pointer" id="imageUploadArea">
                        <input type="file" id="book_image" name="book_image" accept="image/*" class="hidden">
                        <i data-lucide="image" class="h-12 w-12 text-gray-400 mx-auto mb-3"></i>
                        <p class="text-sm text-gray-600 mb-2">클릭하거나 파일을 드래그하여 업로드</p>
                        <p class="text-xs text-gray-400">JPG, PNG, GIF (최대 5MB)</p>
                    </div>
                    <div id="imagePreview" class="mt-4 hidden">
                        <img id="previewImg" src="" alt="미리보기" class="w-full h-48 object-cover rounded-lg">
                    </div>
                </div>

                <!-- PDF 미리보기 업로드 -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">미리보기 PDF</label>
                    <div class="file-upload-area rounded-lg p-6 text-center cursor-pointer" id="pdfUploadArea">
                        <input type="file" id="preview_pdf" name="preview_pdf" accept=".pdf" class="hidden">
                        <i data-lucide="file-text" class="h-12 w-12 text-gray-400 mx-auto mb-3"></i>
                        <p class="text-sm text-gray-600 mb-2">클릭하거나 PDF 파일을 드래그하여 업로드</p>
                        <p class="text-xs text-gray-400">PDF 파일 (최대 10MB)</p>
                    </div>
                    <div id="pdfPreview" class="mt-4 hidden">
                        <div class="flex items-center p-3 bg-beige-100 rounded-lg">
                            <i data-lucide="file-text" class="h-6 w-6 text-beige-600 mr-3"></i>
                            <span id="pdfFileName" class="text-sm text-gray-700"></span>
                            <button type="button" id="removePdf" class="ml-auto text-red-500 hover:text-red-700">
                                <i data-lucide="x" class="h-4 w-4"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="flex space-x-3">
                <button type="submit"
                        class="flex-1 bg-gray-900 hover:bg-beige-800 text-white py-3 px-6 rounded-lg transition-colors flex items-center justify-center">
                    <i data-lucide="plus" class="h-5 w-5 mr-2"></i>
                    상품 등록
                </button>
                <button type="button" onclick="clearForm()"
                        class="px-6 py-3 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors flex items-center">
                    <i data-lucide="refresh-ccw" class="h-4 w-4 mr-2"></i>
                    초기화
                </button>
            </div>
        </form>
    </div>

    <!-- 상품 목록 -->
    <div class="bg-white shadow-sm rounded-lg border border-beige-200">
        <div class="px-6 py-4 border-b border-beige-200">
            <h2 class="text-xl font-light text-gray-900 flex items-center">
                <i data-lucide="package" class="h-5 w-5 mr-2 text-beige-600"></i>
                상품 목록
            </h2>
        </div>
        <div class="p-6">
            <div id="empty-state" class="text-center py-8">
                <i data-lucide="package-x" class="h-12 w-12 text-gray-400 mx-auto mb-3"></i>
                <p class="text-gray-500">등록된 상품이 없습니다.</p>
                <p class="text-sm text-gray-400">상단에서 상품을 등록해주세요.</p>
            </div>
            <div id="product-list" class="hidden">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-beige-200">
                        <thead class="bg-beige-100">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">이미지</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">상품명</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ISBN</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">저자</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">출판사</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">가격</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">재고</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">평점</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">판매지수</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">상태</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">작업</th>
                        </tr>
                        </thead>
                        <tbody id="product-table-body" class="bg-white divide-y divide-beige-200">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        console.log("상품 관리 페이지 로드 완료");

        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        initFileUploads();
        loadProducts();
    });

    // 파일 업로드 초기화
    function initFileUploads() {
        // 이미지 업로드
        const imageArea = document.getElementById('imageUploadArea');
        const imageInput = document.getElementById('book_image');
        const imagePreview = document.getElementById('imagePreview');
        const previewImg = document.getElementById('previewImg');

        imageArea.addEventListener('click', () => imageInput.click());
        imageArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            imageArea.classList.add('dragover');
        });
        imageArea.addEventListener('dragleave', () => {
            imageArea.classList.remove('dragover');
        });
        imageArea.addEventListener('drop', (e) => {
            e.preventDefault();
            imageArea.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0 && files[0].type.startsWith('image/')) {
                imageInput.files = files;
                handleImagePreview(files[0]);
            }
        });

        imageInput.addEventListener('change', (e) => {
            if (e.target.files[0]) {
                handleImagePreview(e.target.files[0]);
            }
        });

        // PDF 업로드
        const pdfArea = document.getElementById('pdfUploadArea');
        const pdfInput = document.getElementById('preview_pdf');
        const pdfPreview = document.getElementById('pdfPreview');
        const pdfFileName = document.getElementById('pdfFileName');
        const removePdf = document.getElementById('removePdf');

        pdfArea.addEventListener('click', () => pdfInput.click());
        pdfArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            pdfArea.classList.add('dragover');
        });
        pdfArea.addEventListener('dragleave', () => {
            pdfArea.classList.remove('dragover');
        });
        pdfArea.addEventListener('drop', (e) => {
            e.preventDefault();
            pdfArea.classList.remove('dragover');
            const files = e.dataTransfer.files;
            if (files.length > 0 && files[0].type === 'application/pdf') {
                pdfInput.files = files;
                handlePdfPreview(files[0]);
            }
        });

        pdfInput.addEventListener('change', (e) => {
            if (e.target.files[0]) {
                handlePdfPreview(e.target.files[0]);
            }
        });

        removePdf.addEventListener('click', () => {
            pdfInput.value = '';
            pdfPreview.classList.add('hidden');
        });
    }

    function handleImagePreview(file) {
        const reader = new FileReader();
        reader.onload = (e) => {
            document.getElementById('previewImg').src = e.target.result;
            document.getElementById('imagePreview').classList.remove('hidden');
        };
        reader.readAsDataURL(file);
    }

    function handlePdfPreview(file) {
        document.getElementById('pdfFileName').textContent = file.name;
        document.getElementById('pdfPreview').classList.remove('hidden');
    }

    function loadProducts() {
        console.log("=== 상품 목록 로드 시작 ===");

        fetch('/admin/product/list')
            .then(response => response.json())
            .then(products => {
                const emptyState = document.getElementById('empty-state');
                const productList = document.getElementById('product-list');
                const tableBody = document.getElementById('product-table-body');

                if (!products || products.length === 0) {
                    emptyState.classList.remove('hidden');
                    productList.classList.add('hidden');
                    return;
                }

                emptyState.classList.add('hidden');
                productList.classList.remove('hidden');

                let html = '';
                products.forEach(product => {
                    html += `
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <img src="${product.imageUrl || '/images/no-image.png'}" alt="${product.productName}"
                                 class="h-16 w-12 object-cover rounded">
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${product.productName || ''}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${product.isbn || ''}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${product.author || ''}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${product.publisher || ''}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${(product.productPrice || 0).toLocaleString()}원</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${product.stockQuantity || 0}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <div class="flex items-center">
                                <span class="text-yellow-400">★</span>
                                <span class="ml-1">${product.productRating || 0}</span>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${product.salesIndex || 0}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                ${product.salesStatus || ''}
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <button onclick="deleteProduct(${product.productId})"
                                    class="text-red-600 hover:text-red-900">
                                <i data-lucide="trash-2" class="h-4 w-4"></i>
                            </button>
                        </td>
                    </tr>
                `;
                });

                tableBody.innerHTML = html;
                lucide.createIcons();
            })
            .catch(error => {
                console.error('상품 목록 로드 오류:', error);
                document.getElementById('empty-state').classList.remove('hidden');
                document.getElementById('product-list').classList.add('hidden');
            });
    }

    document.getElementById('productForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData();
        formData.append('productName', document.getElementById('product_name').value.trim());
        formData.append('isbn', document.getElementById('isbn').value.trim());
        formData.append('author', document.getElementById('author').value.trim());
        formData.append('publisher', document.getElementById('publisher').value.trim());
        formData.append('productPrice', document.getElementById('product_price').value);
        formData.append('stockQuantity', document.getElementById('stock_quantity').value);
        formData.append('salesStatus', document.getElementById('sales_status').value);
        formData.append('productSize', document.getElementById('product_size').value.trim());
        formData.append('productRating', document.getElementById('product_rating').value || 0);
        formData.append('salesIndex', document.getElementById('sales_index').value || 0);
        formData.append('productDescription', document.getElementById('product_description').value.trim());

// 이미지, PDF 파일 추가
        const imageFile = document.getElementById('book_image').files[0];
        if (imageFile) formData.append('bookImage', imageFile);

        const pdfFile = document.getElementById('preview_pdf').files[0];
        if (pdfFile) formData.append('previewPdf', pdfFile);

        fetch('/admin/product/register', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    clearForm();
                    loadProducts();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('상품 등록 중 오류가 발생했습니다.');
            });

    });
    function deleteProduct(productId) {
        if (!confirm('정말 삭제하시겠습니까?')) return;

        const formData = new FormData();
        formData.append('productId', productId);

        fetch('/admin/product/delete', {
            method: 'POST',
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    loadProducts();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('상품 삭제 중 오류가 발생했습니다.');
            });
    }

    function clearForm() {
        document.getElementById('productForm').reset();
        document.getElementById('imagePreview').classList.add('hidden');
        document.getElementById('pdfPreview').classList.add('hidden');
    }
</script>
</body>
</html>