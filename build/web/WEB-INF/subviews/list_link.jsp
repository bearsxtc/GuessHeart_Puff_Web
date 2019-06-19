<%-- 
    Document   : list_link
    Created on : 2019/4/12, 下午 03:47:31
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="product_sort" style="margin-right: 125px; margin-left: 25px; margin-top: 20px;">

    <ul class="product_sort_son">
        <img src="../images/fruit.png" style="width: 14px;">
        <span style="text-align: center; vertical-align: middle">會員中心</span>
        <hr id="hr">
        <li class="side_menu">
            <img src="../images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/member/orders_history.jsp">
                <span style="width: 87px">
                    我的訂單 
                </span>
            </a>
        </li>
        <li class="side_menu">
            <img src="../images/icon.png" style="width: 14px;">
            <a href="<%= request.getContextPath()%>/member/updateMember.jsp">
                <span style="width: 87px">
                    我的帳戶
                </span>
            </a>
        </li>
    </ul>
</div>