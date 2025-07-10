package OnlineLibrary.Admin.controller;

import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.Products.service.ProductService;
import OnlineLibrary.Products.service.CategoryService;
import OnlineLibrary.Common.service.FileUploadService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.*;

@Controller
@RequestMapping("/admin/product")
public class AdminProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private FileUploadService fileUploadService;

    /**
     * 상품 관리 페이지 조회
     */
    @GetMapping
    public String productManage(HttpSession session, Model model) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) {
            return authCheck;
        }

        model.addAttribute("isAdmin", "true");
        model.addAttribute("adminRole", true);
        model.addAttribute("categories", categoryService.getAllCategories());

        return "admin/adminProduct";
    }

    /**
     * 상품 목록 조회 (AJAX)
     */
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getProductList(HttpSession session) {
        try {
            if (!isLoggedIn(session) || !isAdmin(session)) {
                return ResponseEntity.status(403).body(new ArrayList<>());
            }

            System.out.println("=== 상품 목록 조회 요청 ===");

            List<ProductEntity> products = productService.getAllProducts();
            List<Map<String, Object>> result = new ArrayList<>();

            for (ProductEntity product : products) {
                Map<String, Object> productMap = new HashMap<>();
                productMap.put("productId", product.getProductId());
                productMap.put("productName", product.getProductName());
                productMap.put("isbn", product.getIsbn() != null ? product.getIsbn() : "");
                productMap.put("salesIndex", product.getSalesIndex() != null ? product.getSalesIndex() : 0);
                productMap.put("productPrice", product.getProductPrice());
                productMap.put("publisher", product.getPublisher());
                productMap.put("author", product.getAuthor());
                productMap.put("stockQuantity", product.getStockQuantity() != null ? product.getStockQuantity() : 0);
                productMap.put("salesStatus", product.getSalesStatus() != null ? product.getSalesStatus() : "");
                productMap.put("productRating", product.getProductRating() != null ? product.getProductRating() : 0);
                productMap.put("imageUrl", product.getImageUrl() != null ? product.getImageUrl() : "/images/no-image.png");
                productMap.put("pdfPreviewUrl", product.getPdfPreviewUrl() != null ? product.getPdfPreviewUrl() : "");
                productMap.put("createdDate", product.getCreatedDate() != null ? product.getCreatedDate().toString() : "");

                result.add(productMap);
            }

            System.out.println("조회된 상품 개수: " + result.size());
            return ResponseEntity.ok(result);

        } catch (Exception e) {
            System.err.println("상품 목록 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.ok(new ArrayList<>());
        }
    }

    /**
     * 상품 등록 - JavaScript FormData 키명과 매칭
     */
    /**
     * 상품 등록 - 텍스트만 (파일 업로드 제외)
     */
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerProduct(
            @RequestParam("productName") String productName,
            @RequestParam("isbn") String isbn,
            @RequestParam("productPrice") Integer productPrice,
            @RequestParam("publisher") String publisher,
            @RequestParam("author") String author,
            @RequestParam("stockQuantity") Integer stockQuantity,
            @RequestParam("salesStatus") String salesStatus,
            @RequestParam(value = "productSize", required = false) String productSize,
            @RequestParam(value = "productRating", required = false, defaultValue = "0") Integer productRating,
            @RequestParam(value = "salesIndex", required = false, defaultValue = "0") Integer salesIndex,
            @RequestParam(value = "productDescription", required = false) String productDescription,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (!isLoggedIn(session) || !isAdmin(session)) {
                response.put("success", false);
                response.put("message", "관리자 권한이 필요합니다.");
                return ResponseEntity.status(403).body(response);
            }

            System.out.println("=== 상품 등록 요청 (텍스트만) ===");
            System.out.println("상품명: " + productName + ", ISBN: " + isbn + ", 가격: " + productPrice);

            // 기본값 설정 및 null 체크
            if (productSize == null || productSize.trim().isEmpty()) productSize = "";
            if (productDescription == null || productDescription.trim().isEmpty()) productDescription = "";

            // 상품 엔티티 생성
            ProductEntity product = new ProductEntity();
            product.setProductName(productName);
            product.setIsbn(isbn);
            product.setProductPrice(productPrice);
            product.setPublisher(publisher);
            product.setAuthor(author);
            product.setStockQuantity(stockQuantity);
            product.setSalesStatus(salesStatus);
            product.setProductSize(productSize);
            product.setProductRating(productRating);
            product.setSalesIndex(salesIndex);
            product.setProductDescription(productDescription);
            product.setSalesCount(0);
            product.setCreatedDate(LocalDate.now());
            product.setUpdatedDate(LocalDate.now());

            // 기본 이미지 설정 (파일 업로드 없음)
            product.setImageUrl("/images/no-image.png");

            // 상품 저장
            productService.saveProduct(product);

            response.put("success", true);
            response.put("message", "상품이 성공적으로 등록되었습니다.");

        } catch (Exception e) {
            System.err.println("상품 등록 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "상품 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 상품 삭제 - 파일도 함께 삭제
     */
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteProduct(
            @RequestParam Integer productId,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (!isLoggedIn(session) || !isAdmin(session)) {
                response.put("success", false);
                response.put("message", "관리자 권한이 필요합니다.");
                return ResponseEntity.status(403).body(response);
            }

            System.out.println("=== 상품 삭제 요청: " + productId + " ===");

            // 상품 정보 조회 (파일 삭제를 위해)
            Optional<ProductEntity> productOpt = productService.getProductById(productId);
            if (!productOpt.isPresent()) {
                response.put("success", false);
                response.put("message", "존재하지 않는 상품입니다.");
                return ResponseEntity.badRequest().body(response);
            }

            ProductEntity product = productOpt.get();

            // 파일 삭제
            if (product.getImageUrl() != null && !"/images/no-image.png".equals(product.getImageUrl())) {
                fileUploadService.deleteFile(product.getImageUrl());
            }
            if (product.getPdfPreviewUrl() != null && !product.getPdfPreviewUrl().isEmpty()) {
                fileUploadService.deleteFile(product.getPdfPreviewUrl());
            }

            // 상품 삭제
            productService.deleteProduct(productId);

            response.put("success", true);
            response.put("message", "상품이 성공적으로 삭제되었습니다.");

        } catch (Exception e) {
            System.err.println("상품 삭제 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "상품 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    // 권한 체크 메서드들
    private boolean isAdmin(HttpSession session) {
        try {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            return isAdmin != null && isAdmin;
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isLoggedIn(HttpSession session) {
        try {
            String userEmail = (String) session.getAttribute("userEmail");
            return userEmail != null && !userEmail.trim().isEmpty();
        } catch (Exception e) {
            return false;
        }
    }

    private String checkAdminAuth(HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/login?error=login_required";
        }
        if (!isAdmin(session)) {
            return "redirect:/login?error=admin_required";
        }
        return null;
    }
}