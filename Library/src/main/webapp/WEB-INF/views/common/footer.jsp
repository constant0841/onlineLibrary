<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-19
  Time: 오전 11:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<footer class="bg-gray-900 text-white py-12">
    <div class="max-w-7xl mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-2xl font-bold mb-4">STANLEY</h3>
                <p class="text-beige-200 mb-4">
                    LIFELONG COMPANION
                </p>
            </div>
            <div>
                <h4 class="font-medium mb-4">고객 서비스</h4>
                <ul class="space-y-2 text-beige-200">
                    <li><a href="/board" class="hover:text-white transition-colors">공지사항</a></li>
                    <li><a href="/board" class="hover:text-white transition-colors">FAQ</a></li>
                    <li><a href="/board" class="hover:text-white transition-colors">1:1 문의</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-medium mb-4">쇼핑 정보</h4>
                <ul class="space-y-2 text-beige-200">
                    <li><a href="#" class="hover:text-white transition-colors">배송 안내</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">교환/반품</a></li>
                    <li><a href="#" class="hover:text-white transition-colors">사이즈 가이드</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-medium mb-4">SNS</h4>
                <ul class="space-y-2 text-beige-200">
                    <li>인스타그램 : stanley_korea</li>
                    <li>톡딜 : stanleykorea</li>
                    <li>블로그 : stanley-pmi</li>
                    <li>페이스북 : stanleypmikorea</li>
                </ul>
            </div>
        </div>
        <div class="border-t border-beige-700 mt-8 pt-8 text-center text-beige-300">
            <p>&copy; 2024 STANLEY. All rights reserved.</p>
        </div>
    </div>
</footer>
