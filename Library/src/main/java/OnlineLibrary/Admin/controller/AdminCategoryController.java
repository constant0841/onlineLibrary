package OnlineLibrary.Admin.controller;

import OnlineLibrary.Products.entity.Category;
import OnlineLibrary.Products.service.CategoryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {

    @Autowired
    private CategoryService categoryService;

    /**
     * 카테고리 관리 페이지 조회
     */
    @GetMapping
    public String categoryManage(HttpSession session, Model model) {

        // 관리자 권한 체크
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) {
            return authCheck;
        }

        return "admin/adminCategory";
    }

    /**
     * 카테고리 목록 조회 (AJAX) - 실제 DB 연동
     */
    @GetMapping("/list")
    @ResponseBody
    public ResponseEntity<List<Map<String, String>>> getCategoryList(HttpSession session) {
        try {
            System.out.println("=== 카테고리 목록 조회 요청 ===");

            // 실제 CategoryService 사용
            List<Category> categories = categoryService.getAllCategories();

            // Category 엔티티를 Map으로 변환
            List<Map<String, String>> result = new ArrayList<>();
            for (Category category : categories) {
                Map<String, String> categoryMap = new HashMap<>();
                categoryMap.put("categoryId", category.getCategoryId());
                categoryMap.put("categoryName", category.getCategoryName());
                result.add(categoryMap);
            }

            System.out.println("DB에서 조회한 카테고리 개수: " + result.size());

            return ResponseEntity.ok(result);

        } catch (Exception e) {
            System.err.println("카테고리 목록 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.ok(new ArrayList<>());
        }
    }

    /**
     * 카테고리 등록 (AJAX) - 실제 DB 연동
     */
    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerCategory(
            @RequestParam String categoryId,
            @RequestParam String categoryName,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("=== 카테고리 등록 요청 ===");
            System.out.println("ID: " + categoryId + ", Name: " + categoryName);

            // 카테고리 ID 유효성 검사 (영문 소문자, 언더스코어만)
            if (!categoryId.matches("^[a-z_]+$")) {
                response.put("success", false);
                response.put("message", "카테고리 ID는 영문 소문자와 언더스코어(_)만 사용 가능합니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 중복 검사
            if (categoryService.existsById(categoryId)) {
                response.put("success", false);
                response.put("message", "이미 존재하는 카테고리 ID입니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 카테고리 등록
            Category category = new Category();
            category.setCategoryId(categoryId);
            category.setCategoryName(categoryName);

            categoryService.saveCategory(category);

            response.put("success", true);
            response.put("message", "카테고리가 성공적으로 등록되었습니다.");

        } catch (Exception e) {
            System.err.println("카테고리 등록 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "카테고리 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 카테고리 삭제
     */
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteCategoryPost(
            @RequestParam String categoryId,
            HttpSession session) {

        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("=== 카테고리 삭제 요청 (POST): " + categoryId + " ===");

            // 카테고리 존재 확인
            if (!categoryService.existsById(categoryId)) {
                response.put("success", false);
                response.put("message", "존재하지 않는 카테고리입니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 해당 카테고리를 사용하는 상품이 있는지 확인
            if (categoryService.isUsedByProducts(categoryId)) {
                response.put("success", false);
                response.put("message", "해당 카테고리를 사용하는 상품이 있어 삭제할 수 없습니다.");
                return ResponseEntity.badRequest().body(response);
            }

            // 카테고리 삭제
            categoryService.deleteCategory(categoryId);

            response.put("success", true);
            response.put("message", "카테고리가 성공적으로 삭제되었습니다.");

        } catch (Exception e) {
            System.err.println("카테고리 삭제 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "카테고리 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 기본 카테고리 일괄 등록 (AJAX) - 실제 DB 연동
     */
    @PostMapping("/register-defaults")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerDefaultCategories(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("=== 기본 카테고리 일괄 등록 요청 ===");

            // 기본 카테고리 목록
            Map<String, String> defaultCategories = new HashMap<>();
            defaultCategories.put("literature", "문학");
            defaultCategories.put("humanities", "인문");
            defaultCategories.put("self_help", "자기계발");
            defaultCategories.put("business", "경제/경영");
            defaultCategories.put("science", "과학/기술");
            defaultCategories.put("arts", "예술/취미");

            int addedCount = 0;

            for (Map.Entry<String, String> entry : defaultCategories.entrySet()) {
                String categoryId = entry.getKey();
                String categoryName = entry.getValue();

                // 이미 존재하는 카테고리는 스킵
                if (!categoryService.existsById(categoryId)) {
                    Category category = new Category();
                    category.setCategoryId(categoryId);
                    category.setCategoryName(categoryName);

                    categoryService.saveCategory(category);
                    addedCount++;
                }
            }

            response.put("success", true);
            response.put("message", addedCount + "개의 카테고리가 등록되었습니다.");
            response.put("addedCount", addedCount);

        } catch (Exception e) {
            System.err.println("기본 카테고리 등록 중 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "기본 카테고리 등록 중 오류가 발생했습니다: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }

    /**
     * 세션에서 사용자가 관리자인지 확인
     */
    private boolean isAdmin(HttpSession session) {
        try {
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
            String userEmail = (String) session.getAttribute("userEmail");

            System.out.println("권한 체크 - userEmail: " + userEmail + ", isAdmin: " + isAdmin);

            return isAdmin != null && isAdmin;

        } catch (Exception e) {
            System.err.println("관리자 권한 체크 중 오류: " + e.getMessage());
            return false;
        }
    }

    /**
     * 로그인 상태 확인
     */
    private boolean isLoggedIn(HttpSession session) {
        try {
            String userEmail = (String) session.getAttribute("userEmail");
            return userEmail != null && !userEmail.trim().isEmpty();
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 관리자 권한 체크 및 리다이렉트
     */
    private String checkAdminAuth(HttpSession session) {
        if (!isLoggedIn(session)) {
            System.out.println("미로그인 사용자의 관리자 페이지 접근 시도");
            return "redirect:/login?error=login_required";
        }

        if (!isAdmin(session)) {
            System.out.println("권한 없는 사용자의 관리자 페이지 접근 시도");
            return "redirect:/login?error=admin_required";
        }

        System.out.println("관리자 권한 확인됨");
        return null;
    }
}