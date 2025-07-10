package OnlineLibrary.Cart.service;

import OnlineLibrary.Cart.entity.CartEntity;
import OnlineLibrary.Cart.repository.CartRepository;
import OnlineLibrary.Products.entity.ProductEntity;
import OnlineLibrary.Products.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class CartService {

    private final CartRepository cartRepository;
    private final ProductService productService;

    @Autowired
    public CartService(CartRepository cartRepository, ProductService productService) {
        this.cartRepository = cartRepository;
        this.productService = productService;
    }

    /**
     * 장바구니에 상품을 추가하거나 기존 상품의 수량을 업데이트합니다.
     * userId와 productId는 Integer 타입입니다.
     * @param userId 장바구니를 소유한 사용자의 ID (Integer 타입)
     * @param productId 추가/업데이트할 상품의 ID (Integer 타입)
     * @param quantity 추가할 수량
     * @return 저장되거나 업데이트된 CartEntity 객체
     * @throws Exception 상품을 찾을 수 없거나 재고가 부족할 경우 예외 발생
     */
    @Transactional
    public CartEntity addOrUpdateCartItem(Integer userId, Integer productId, int quantity) throws Exception {
        // 1. 상품 정보 조회 (유효성 검사 및 가격 계산을 위해 필요)
        Optional<ProductEntity> productOpt = productService.getProductById(productId); // productId는 Integer
        if (!productOpt.isPresent()) {
            throw new Exception("상품을 찾을 수 없습니다. (ID: " + productId + ")");
        }
        ProductEntity product = productOpt.get();

        // 2. 상품 판매 상태 확인
        if (!"판매중".equals(product.getSalesStatus())) {
            throw new Exception("현재 판매중인 상품이 아닙니다.");
        }

        // 3. 해당 사용자의 장바구니에 이미 동일한 상품이 있는지 확인
        // CartRepository의 findByUserIdAndProductId 메소드 파라미터 타입이 Integer로 변경되었음을 반영
        Optional<CartEntity> existingCartItemOpt = cartRepository.findByUserIdAndProductId(userId, productId);

        CartEntity cartItem;
        if (existingCartItemOpt.isPresent()) {
            // 4. 이미 장바구니에 있는 경우: 수량 및 총 가격 업데이트
            cartItem = existingCartItemOpt.get();
            int currentQuantity = cartItem.getProductCount(); // CartEntity의 Getter 사용
            int newQuantity = currentQuantity + quantity;

            // 재고 초과 여부 확인
            if (newQuantity > product.getStockQuantity()) {
                throw new Exception("선택하신 수량이 재고를 초과합니다. (현재 재고: " + product.getStockQuantity() + "개, 장바구니에 이미 " + currentQuantity + "개 존재)");
            }
            cartItem.setProductCount(newQuantity); // CartEntity의 Setter 사용
            // 총 가격 업데이트: ProductEntity의 getProductPrice()가 Integer를 반환한다고 가정
            // ProductEntity의 getProductPrice()가 Double 등을 반환한다면 타입 캐스팅 또는 Double로 변경 필요
            cartItem.setTotalPrice(newQuantity * product.getProductPrice()); // CartEntity의 Setter 사용
        } else {
            // 5. 장바구니에 없는 새로운 상품인 경우: 새 CartEntity 생성 및 초기화
            cartItem = new CartEntity();
            cartItem.setUserId(userId); // CartEntity의 Setter 사용
            cartItem.setProductId(productId); // CartEntity의 Setter 사용
            cartItem.setProductCount(quantity); // CartEntity의 Setter 사용
            cartItem.setIsSelected(true); // CartEntity의 Setter 사용
            // 총 가격 설정
            cartItem.setTotalPrice(quantity * product.getProductPrice()); // CartEntity의 Setter 사용
        }

        // 6. 변경된 CartEntity를 데이터베이스에 저장
        return cartRepository.save(cartItem);
    }

    /**
     * 특정 사용자의 모든 장바구니 항목을 조회합니다.
     * userId는 Integer 타입입니다.
     * @param userId 조회할 사용자의 ID (Integer 타입)
     * @return 해당 사용자의 장바구니 항목 리스트
     */
    @Transactional(readOnly = true)
    public List<CartEntity> getCartItemsByUserId(Integer userId) {
        return cartRepository.findByUserId(userId);
    }

    /**
     * 특정 사용자의 장바구니에 담긴 총 상품 개수를 조회합니다.
     * userId는 Integer 타입입니다.
     * @param userId 조회할 사용자의 ID (Integer 타입)
     * @return 해당 사용자의 장바구니 총 항목 개수
     */
    @Transactional(readOnly = true)
    public Long getCartItemCount(Integer userId) {
        return cartRepository.countByUserId(userId);
    }

    /**
     * 특정 사용자의 장바구니 항목 수량을 업데이트합니다.
     * 재고 확인 및 총 가격 재계산 로직 포함.
     *
     * @param userId 장바구니를 소유한 사용자의 ID
     * @param productId 수량을 변경할 상품의 ID
     * @param newQuantity 변경할 새로운 수량
     * @return 업데이트된 CartEntity 객체
     * @throws Exception 상품을 찾을 수 없거나 재고 부족 등의 경우
     */
    @Transactional
    public CartEntity updateCartItemQuantity(Integer userId, Integer productId, int newQuantity) throws Exception {
        Optional<CartEntity> cartItemOpt = cartRepository.findByUserIdAndProductId(userId, productId);
        if (!cartItemOpt.isPresent()) {
            throw new Exception("장바구니에 해당 상품이 없습니다.");
        }
        CartEntity cartItem = cartItemOpt.get();

        // 상품 정보 재확인 (재고 확인을 위해)
        Optional<ProductEntity> productOpt = productService.getProductById(productId);
        if (!productOpt.isPresent()) {
            throw new Exception("상품 정보를 찾을 수 없습니다."); // 이 경우는 드물지만 방어적으로
        }
        ProductEntity product = productOpt.get();

        if (newQuantity <= 0) {
            throw new Exception("수량은 1개 이상이어야 합니다.");
        }
        if (newQuantity > product.getStockQuantity()) {
            throw new Exception("재고가 부족합니다. (현재 재고: " + product.getStockQuantity() + ")");
        }

        cartItem.setProductCount(newQuantity);
        cartItem.setTotalPrice(newQuantity * product.getProductPrice()); // 총 가격 업데이트
        return cartRepository.save(cartItem);
    }

    /**
     * 특정 사용자의 장바구니에서 특정 상품을 삭제합니다.
     *
     * @param userId 장바구니를 소유한 사용자의 ID
     * @param productId 삭제할 상품의 ID
     */
    @Transactional
    public void removeCartItem(Integer userId, Integer productId) {
        // 복합 키로 항목을 찾아서 삭제
        // CartId cartId = new CartId(userId, productId); // CartId를 직접 생성하여 deleteById 사용
        // cartRepository.deleteById(cartId);

        // 또는 쿼리 메소드를 사용하여 바로 삭제
        // findByUserIdAndProductId가 Optional<CartEntity>를 반환하므로, 이를 찾아서 삭제
        cartRepository.findByUserIdAndProductId(userId, productId).ifPresent(cartRepository::delete);
    }

    /**
     * 특정 사용자의 장바구니를 모두 비웁니다.
     */
    @Transactional
    public void clearCart(Integer userId) {
        // 해당 사용자의 모든 장바구니 항목을 삭제
        cartRepository.deleteByUserId(userId); // CartRepository에 이 메소드 추가 필요
    }


}