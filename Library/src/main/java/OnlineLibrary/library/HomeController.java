package OnlineLibrary.library;

import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.Products.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
import java.util.stream.Collectors;

@Controller
public class HomeController {

    @Autowired
    private ProductService productService;

    /**
     * 메인 페이지 및 검색 통합 처리
     */
    @GetMapping({"/", "/main"})
    public ModelAndView main(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "show", required = false) String show,
            @RequestParam(value = "sort", required = false) String sort,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "12") int size,
            HttpSession session) {

        ModelAndView mav = new ModelAndView("main/main");

        try {
            System.out.println("=== 메인 페이지 요청 처리 ===");
            System.out.println("검색어: " + keyword);
            System.out.println("카테고리: " + category);
            System.out.println("전체보기: " + show);
            System.out.println("정렬: " + sort);
            System.out.println("페이지: " + page);

            // 로그인 상태 확인
            String userEmail = (String) session.getAttribute("userEmail");
            String userName = (String) session.getAttribute("userName");
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

            mav.addObject("isLoggedIn", userEmail != null);
            mav.addObject("userName", userName != null ? userName : "");
            mav.addObject("isAdmin", isAdmin != null ? isAdmin : false);

            // 전체 상품 목록 조회
            List<ProductEntity> allProducts = productService.getAllProducts();
            mav.addObject("totalProducts", allProducts.size());

            // 검색어가 있거나 전체보기 요청인 경우
            if ((keyword != null && !keyword.trim().isEmpty()) ||
                    (show != null && "all".equals(show)) ||
                    (category != null && !category.trim().isEmpty())) {

                List<ProductEntity> searchResults = new ArrayList<>();

                if (keyword != null && !keyword.trim().isEmpty()) {
                    // 키워드 검색
                    String searchKeyword = keyword.toLowerCase().trim();
                    searchResults = allProducts.stream()
                            .filter(product ->
                                    (product.getProductName() != null &&
                                            product.getProductName().toLowerCase().contains(searchKeyword)) ||
                                            (product.getAuthor() != null &&
                                                    product.getAuthor().toLowerCase().contains(searchKeyword)) ||
                                            (product.getPublisher() != null &&
                                                    product.getPublisher().toLowerCase().contains(searchKeyword))
                            )
                            .collect(Collectors.toList());

                    System.out.println("검색 키워드: " + keyword + ", 검색 결과: " + searchResults.size() + "개");
                } else if (category != null && !category.trim().isEmpty()) {
                    // 카테고리 검색 - ProductService에서 카테고리별 상품 조회
                    try {
                        searchResults = productService.getProductsByCategory(category);
                        System.out.println("카테고리: " + category + ", 검색 결과: " + searchResults.size() + "개");
                    } catch (Exception e) {
                        System.err.println("카테고리 검색 중 오류: " + e.getMessage());
                        // 오류 시 전체 상품 반환
                        searchResults = new ArrayList<>(allProducts);
                    }
                } else {
                    // 전체 상품 조회
                    searchResults = new ArrayList<>(allProducts);
                }

                // 정렬 처리
                if (sort != null) {
                    switch (sort) {
                        case "price_low":
                            searchResults.sort(Comparator.comparing(ProductEntity::getProductPrice));
                            break;
                        case "price_high":
                            searchResults.sort(Comparator.comparing(ProductEntity::getProductPrice).reversed());
                            break;
                        case "rating":
                            searchResults.sort(Comparator.comparing(ProductEntity::getProductRating,
                                    Comparator.nullsLast(Comparator.reverseOrder())));
                            break;
                        case "date":
                            searchResults.sort(Comparator.comparing(ProductEntity::getCreatedDate,
                                    Comparator.nullsLast(Comparator.reverseOrder())));
                            break;
                        case "sales":
                            searchResults.sort(Comparator.comparing(ProductEntity::getSalesIndex,
                                    Comparator.nullsLast(Comparator.reverseOrder())));
                            break;
                        default: // name
                            searchResults.sort(Comparator.comparing(ProductEntity::getProductName,
                                    Comparator.nullsLast(Comparator.naturalOrder())));
                            break;
                    }
                }

                // 페이징 처리
                int totalResults = searchResults.size();
                int startIndex = (page - 1) * size;
                int endIndex = Math.min(startIndex + size, totalResults);

                List<ProductEntity> paginatedResults = new ArrayList<>();
                if (startIndex < totalResults) {
                    paginatedResults = searchResults.subList(startIndex, endIndex);
                }

                // 검색 결과 관련 모델 추가
                mav.addObject("products", paginatedResults);
                mav.addObject("keyword", keyword);
                mav.addObject("category", category);
                mav.addObject("totalResults", totalResults);
                mav.addObject("currentPage", page);
                mav.addObject("pageSize", size);
                mav.addObject("totalPages", (int) Math.ceil((double) totalResults / size));
                mav.addObject("hasNext", endIndex < totalResults);
                mav.addObject("hasPrevious", page > 1);

            } else {
                // 메인 페이지 기본 데이터

                // 베스트셀러 (판매지수 기준 상위 4개)
                List<ProductEntity> bestSellers = allProducts.stream()
                        .filter(p -> p.getSalesIndex() != null && p.getSalesIndex() > 0)
                        .sorted((p1, p2) -> Integer.compare(p2.getSalesIndex(), p1.getSalesIndex()))
                        .limit(4)
                        .collect(Collectors.toList());

                // 신간 도서 (등록일 기준 최신 4개)
                List<ProductEntity> newBooks = allProducts.stream()
                        .filter(p -> p.getCreatedDate() != null)
                        .sorted((p1, p2) -> p2.getCreatedDate().compareTo(p1.getCreatedDate()))
                        .limit(4)
                        .collect(Collectors.toList());

                // 추천 도서 (판매중인 모든 도서에서 랜덤 4개)
                List<ProductEntity> recommendedBooks = allProducts.stream()
                        .filter(p -> "판매중".equals(p.getSalesStatus()))
                        .collect(Collectors.toList());
                Collections.shuffle(recommendedBooks);
                recommendedBooks = recommendedBooks.stream().limit(4).collect(Collectors.toList());

                mav.addObject("bestSellers", bestSellers);
                mav.addObject("newBooks", newBooks);
                mav.addObject("recommendedBooks", recommendedBooks);

                System.out.println("메인 페이지 로드 완료 - 총 상품: " + allProducts.size());
                System.out.println("베스트셀러: " + bestSellers.size() + "개");
                System.out.println("신간: " + newBooks.size() + "개");
                System.out.println("추천: " + recommendedBooks.size() + "개");
            }

        } catch (Exception e) {
            System.err.println("페이지 로드 중 오류: " + e.getMessage());
            e.printStackTrace();

            // 오류 시 빈 데이터로 설정
            mav.addObject("bestSellers", new ArrayList<>());
            mav.addObject("newBooks", new ArrayList<>());
            mav.addObject("recommendedBooks", new ArrayList<>());
            mav.addObject("products", new ArrayList<>());
            mav.addObject("totalProducts", 0);
            mav.addObject("totalResults", 0);
        }

        return mav;
    }

    /**
     * 검색 전용 엔드포인트 (기존 유지 - 리다이렉트)
     */
    @GetMapping("/search")
    public String search(
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "category", required = false) String category,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "12") int size) {

        StringBuilder redirect = new StringBuilder("redirect:/?");

        if (keyword != null && !keyword.trim().isEmpty()) {
            redirect.append("keyword=").append(keyword).append("&");
        }
        if (category != null && !category.trim().isEmpty()) {
            redirect.append("category=").append(category).append("&");
        }
        if (page > 1) {
            redirect.append("page=").append(page).append("&");
        }
        if (size != 12) {
            redirect.append("size=").append(size).append("&");
        }

        return redirect.toString();
    }

    /**
     * 상품 상세 페이지
     */
    @GetMapping("/product/{id}")
    public String productDetail(@PathVariable("id") Integer productId,
                                HttpSession session, Model model) {
        try {
            System.out.println("=== 상품 상세 페이지 요청: ID " + productId + " ===");

            // 로그인 상태 확인
            String userEmail = (String) session.getAttribute("userEmail");
            String userName = (String) session.getAttribute("userName");
            Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

            model.addAttribute("isLoggedIn", userEmail != null);
            model.addAttribute("userName", userName != null ? userName : "");
            model.addAttribute("isAdmin", isAdmin != null ? isAdmin : false);

            // 상품 정보 조회
            Optional<ProductEntity> productOpt = productService.getProductById(productId);
            if (productOpt.isPresent()) {
                ProductEntity product = productOpt.get();
                model.addAttribute("product", product);

                // 관련 상품 (같은 저자의 다른 책들)
                List<ProductEntity> relatedProducts = productService.getAllProducts().stream()
                        .filter(p -> p.getAuthor() != null &&
                                p.getAuthor().equals(product.getAuthor()) &&
                                !p.getProductId().equals(productId))
                        .limit(4)
                        .collect(Collectors.toList());

                model.addAttribute("relatedProducts", relatedProducts);

                System.out.println("상품 상세 조회 성공: " + product.getProductName());
                System.out.println("관련 상품: " + relatedProducts.size() + "개");

                return "product/productDetl";
            } else {
                System.out.println("상품을 찾을 수 없음: ID " + productId);
                return "redirect:/?error=product_not_found";
            }

        } catch (Exception e) {
            System.err.println("상품 상세 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/?error=internal_error";
        }
    }
}