<%-- 
    Document   : header
    Created on : 2019/3/27, 上午 11:20:26
    Author     : Admin
--%>

<%@page import="java.util.List"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Customer member = (Customer) session.getAttribute("member");
%>

<header>
    <div class="bg">
        <div class="flex-container">
            <% if (member == null) {%>
            <div class="boxitem">      
                <a href="<%=request.getContextPath()%>/login.jsp">
                    <span class="fas fa-sign-in-alt"></span>
                    <span>登入</span>
                </a>   
            </div>     
            <%} else {%>
            <div class="boxitem">
                <a href="<%=request.getContextPath()%>/logout.do">
                    <span class="fas fa-sign-out-alt"></span>
                    <span>登出</span>
                </a> 
            </div>
            <%}%>

            <% if (member == null) {%>
            <div class="boxitem">
                <a href="<%=request.getContextPath()%>/member_center.jsp">
                    <span class="far fa-user"></span>
                    <span>會員中心</span>
                </a>
            </div>
            <%} else {%>
            <div class="boxitem">
                <a href="<%=request.getContextPath()%>/member_center.jsp">
                    <span class="far fa-user"></span>
                    <span><%= member != null ? member.getName() : ""%></span>
                </a>
            </div>
            <%}%>
            <div id="item2" class="boxitem">
                <a href="https://zh-tw.facebook.com/GHpuff/">
                    <span class="fab fa-facebook-f"></span>
                    <span>聯絡我們</span>
                </a>
            </div>
            <div id="item3" class="boxitem"> 
                <a href="<%=request.getContextPath()%>/member/cart.jsp">
                    <span class="fas fa-shopping-cart"></span>
                    <span id="cartTotalQuantity" style="color:red">
                        <%@include file="/cart_total_quantity.jsp" %>
                    </span>
                    <span>購物車</span>
                </a>
            </div>
            <div class="boxitem"> 
                <a href="<%=request.getContextPath()%>/member/order_cart.jsp">
                    <span class="fas fa-shopping-basket"></span>
                    <span id="orderCartTotalQuantity" style="color:red">
                        <%@include file="/order_cart_total_quantity.jsp" %>
                    </span>
                    <span>預訂店取</span>
                </a>
            </div>

            <div id="item4" class="boxitem">
                <form id="form" method="GET" action="<%=request.getContextPath()%>/products_list.jsp">
                    <input id="search_input" class="item4_1" type="search" placeholder="查詢商品" autocomplete="off" style="width: 78px; " name="search">
                    <!--            <input id="search_icon" class="item4_1" type="submit" value=""  >-->
                    <button id="search_icon" style="border-style: none; background-color: white"> 
                        <span class="fas fa-search"></span>
                    </button>
                </form>
            </div>
        </div>  
    </div>
    <div class="header">
        <h1 class="logo">
            <a href="<%= request.getContextPath()%>/main.jsp">INDEX</a>
        </h1>
    </div>
        <nav class="global_nav">
        <ul class="nav_ul">
            <li class="nav_item"><a href="<%=request.getContextPath()%>/product_today.jsp"><span>今日猜心 / Day's GH</span></a></li>
            <li class="nav_item"><a href="<%=request.getContextPath()%>/about_us.jsp"><span>猜心紀事 / About Us</span></a></li>               
            <li class="nav_item"><a href="<%=request.getContextPath()%>/products_list.jsp"><span>猜心項目 / Products</span></a></li>
            <li class="nav_item"><a href="<%=request.getContextPath()%>/register.jsp"><span>加入猜心 / Join Us</span></a></li>
        </ul>
    </nav>
    <div id="loginBox"></div>
</header>
