<%-- 
    Document   : cart_total_quantity
    Created on : 2019/4/1, 上午 11:16:47
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
    if(cart!=null){
%>
<%=  cart.getTotalQuantity()%>
<%  } %>
