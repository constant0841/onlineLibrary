<%--
  Created by IntelliJ IDEA.
  User: sharo
  Date: 2025-06-22
  Time: 오후 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>

<nav class="navbar navbar-expand-md navbar-light bg-light border-bottom sticky-top shadow-sm">
    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">
            STANLEY
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Links -->
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-md-0">
                <li class="nav-item">
                    <a class="nav-link text-primary" href="${pageContext.request.contextPath}/">홈</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-primary" href="${pageContext.request.contextPath}/board">게시판</a>
                </li>
            </ul>

            <!-- Icons (Cart, User) -->
            <ul class="navbar-nav d-flex flex-row gap-2">
                <li class="nav-item">
                    <a class="nav-link text-primary" href="${pageContext.request.contextPath}/cart">
                        <i class="bi bi-bag"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-primary" href="/login">
                        <i class="bi bi-person"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

