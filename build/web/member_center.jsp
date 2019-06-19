<%-- 
    Document   : member_center
    Created on : 2019/4/9, 下午 01:03:08
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>會員中心</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            #article{
                height: 700px;
            }
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(0,0,0,1), rgba(0,0,0,0));
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                <div class="product_sort" style="margin-right: 125px; margin-left: 25px; margin-top: 20px;">
                    
                    <ul class="product_sort_son">
                        <img src="images/fruit.png" style="width: 14px;">
                        <span style="text-align: center; vertical-align: middle">會員中心</span>
                        <hr id="hr">
                        <li class="side_menu">
                            <img src="images/icon.png" style="width: 14px;">
                            <a href="<%= request.getContextPath()%>/member/orders_history.jsp">
                                <span style="width: 87px">
                                    我的訂單 
                                </span>
                            </a>
                        </li>
                        <li class="side_menu">
                            <img src="images/icon.png" style="width: 14px;">
                            <a href="<%= request.getContextPath()%>/member/order_orders_history.jsp">
                                <span style="width: 87px">
                                    預訂店取訂單 
                                </span>
                            </a>
                        </li>
                        <li class="side_menu">
                            <img src="images/icon.png" style="width: 14px;">
                            <a href="<%= request.getContextPath()%>/member/updateMember.jsp">
                                <span style="width: 87px">
                                    我的帳戶
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="mem_center_photo">
                    <img src="images/member_center2.png" style="width: 50%; vertical-align: middle; margin-top: 56px">
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
