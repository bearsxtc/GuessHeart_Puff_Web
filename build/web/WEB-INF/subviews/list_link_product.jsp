<%-- 
    Document   : list_link
    Created on : 2019/4/12, 下午 03:47:31
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="product_sort">
    <ul class="product_sort_son">
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_daily.jsp">
                <span style="width: 87px">
                    日常猜心 
                    <br> 
                    <img src="images/opacity.png">
                    Daily Guess
                </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_classic.jsp">
                <span style="width: 87px">
                    經典猜心 
                    <br> 
                    <img src="images/opacity.png">
                    Classic Flavor
                </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_hot_sale.jsp">
            <span>
                熱銷商品 
                <br>
                <img src="images/opacity.png">
                Hot Sale
            </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_seasonLimited.jsp">
                <span>
                    季節限定 
                    <br> 
                    <img src="images/opacity.png">
                    Season Limited
                </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_cone.jsp">
                <span>獨家甜筒泡芙 </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/product_boolay.jsp">
            <span>焦糖布蕾泡芙 </span>
            </a>
        </li>
    </ul>
</div>
