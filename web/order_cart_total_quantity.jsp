<%-- 
    Document   : cart_total_quantity
    Created on : 2019/4/1, 上午 11:16:47
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.OrderShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    OrderShoppingCart order_cart = (OrderShoppingCart)session.getAttribute("order_cart");
    if(order_cart!=null){
%>
<%=  order_cart.getTotalQuantity()%>
<%  } %>
