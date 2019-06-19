<%-- 
    Document   : orders_history
    Created on : 2019/3/18, 上午 11:30:51
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.Order_Order"%>
<%@page import="uuu.ghp.model.Order_OrderService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.entity.PaymentType"%>
<%@page import="uuu.ghp.model.OrderService"%>
<%@page import="uuu.ghp.entity.Order"%>
<%@page import="java.util.List"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>歷史訂單</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            th{
                text-align: center;
                margin-bottom: 5px;
            }
            td{
                text-align: center;
                margin-bottom: 5px;
            }
            .order_history{
                float: left;
                width: 50%;
                margin-bottom: 60px;
            }
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background: black;
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(0,0,0,1), rgba(0,0,0,0));
                /*background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(200,200,200,1), rgba(254,254,254,0));*/
            }
        </style>        
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>


        <div id="article">
            <div id="main">
                <div class="product_sort" style="margin-right: 125px; margin-left: 25px; margin-top: 20px;">

                    <ul class="product_sort_son">
                        <img src="../images/fruit.png" style="width: 14px;">
                        <span style="text-align: center; vertical-align: middle">會員中心</span>
                        <hr style="margin: 10px 0px !important;
                            border: 0;
                            height: 3px;background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(200,200,200,1), rgba(254,254,254,0));">
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
                            <a href="<%= request.getContextPath()%>/member/order_orders_history.jsp">
                                <span style="width: 87px">
                                    預訂店取訂單 
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
                <%
                    Customer member = (Customer) session.getAttribute("member");
                    List<Order_Order> list2 = null;
                    if (member != null) {
                        Order_OrderService service1 = new Order_OrderService();
                        list2 = service1.selectOrder_OrdersByCustomerAccount(member.getEmail());
                    }


                %>          


                <% if (list2 != null && list2.size() > 0) { %>

                <div class="order_history">
                    <h2 >預訂訂單</h2>   
                    <hr id="hr">
                    <table style="width: 100%;margin:0 auto">
                        <thead>
                            <tr>
                                <th>訂單編號</th><th>日期</th><th>付款方式</th><th>貨運方式</th><th>總金額</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Order_Order order : list2) {%>
                            <tr>
                                <td>
                                    <a href="order_order.jsp?order_orderId=<%= order.getId()%>">
                                        <%= order.getFormatedId()%>
                                    </a>
                                </td>
                                <td><%=order.getOrderDate()%>

                                </td>

                                <td>
                                    <%= order.getPaymentType().getDescription()%>
                                    <% if (order.getPaymentType() == PaymentType.ATM && order.getStatus() == 0) {%>
                                    <br>
                                    <a href="order_paid.jsp?orderId=<%= order.getId()%>"><small style="color: #de2d0f; font-weight: 700">通知猜心，您已付款</small></a>
                                    <% }%>
                                </td>

                            </td><td><%= order.getShippingType().getDescription()%></td>
                        <td><%
                            Double a = order.getTotalAmount() + order.getPaymentFee() + order.getShippingFee();
                            DecimalFormat obj = new DecimalFormat();
                            out.print(obj.format(a));
                            %>元</td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%} else {%>
            <p>查無訂單紀錄!</p>
            <%}%>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/subviews/footer.jsp"  %>
</body>
</html>
