//package com.tumblermall.cart.controller;
//
//import com.tumblermall.cart.dto.CartRequestDTO;
//import com.tumblermall.cart.service.CartService;
//import com.tumblermall.cart.vo.CartRequestVO;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//
//import java.util.List;
//
////테스트용임 나중에 주석처리할것.
//@Controller
//public class CartController {
//    @Autowired
//    CartService cartService;
//
//    @GetMapping("/cartTest")
//    public String write(Model model) {
//        int userId = 1;
//
//        List<CartRequestVO> cartList = cartService.showList(userId);
////        System.out.println("cartList size: " + cartList.size());
////
////        for (CartRequestVO vo : cartList) {
////               System.out.println("상품명: " + vo.getProductName());
////        }
//
//        model.addAttribute("cartList", cartList);
//        return "/product/cartTest";
//    }
//
//}
