<%-- 
    Document   : product
    Created on : 2019/3/27, 上午 11:04:03
    Author     : Admin
--%>


<%@page import="uuu.ghp.entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <title>產品明細</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>

    </head>
    <% Product p = new Product();%>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <div class="article">
            <img style="width:40%;min-width:300px;max-width:500px;float:left" src="images/product1.jpg">
            <div style="padding-left: 15px">
                <h3>NAME : 猜心泡芙</h3>
                <h4>TASTE : 草莓戀人</h4>
                <p>PRICE : 60 元</p>
                
                <div style="clear:both; padding-top: 10px;">
	        <hr>
                <span>這款內餡屬於重乳口味，濃郁的奶香搭配著天然的草莓甜，有別於「草莓甜心」
                    多多系列的酸甜，「草莓戀人」有著溫和牛奶的襯托，相信兩者都會是草莓控的愛啊。</span>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp" %>
    </body>
</html>
