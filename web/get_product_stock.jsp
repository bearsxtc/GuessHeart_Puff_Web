<%-- 
    Document   : get_product_stock
    Created on : 2019/4/10, 下午 04:31:57
    Author     : Admin
--%>

<%@page import="uuu.ghp.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String productId=request.getParameter("productId");
String schedule=request.getParameter("schedule");

ProductService service = new ProductService();
int stock = service.getProductStock(productId, schedule);
%>
<%= stock%>
