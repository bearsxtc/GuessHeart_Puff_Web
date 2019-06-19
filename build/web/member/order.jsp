<%-- 
Document   : order
Created on : 2019/4/2, 下午 03:29:18
Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.entity.PaymentType"%>
<%@page import="uuu.ghp.entity.OrderItem"%>
<%@page import="uuu.ghp.model.OrderService"%>
<%@page import="uuu.ghp.entity.Order"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>訂單明細</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                /*background: black*/
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(200,200,200,1), rgba(254,254,254,0));
            }
            td{
                text-align: center;
            }
            label{
                border-style: none;
            }
            .hd{
                background: transparent;
                border: 1px solid transparent;
            }
            .orderData1{
                width: -webkit-fill-available;
                border-style: none;
                border-bottom: 1px solid #5d5d5d;
                margin-bottom: 7px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            Customer member = (Customer) session.getAttribute("member");
            Order order = (Order) request.getAttribute("order");
            String orderId = request.getParameter("orderId");
//            System.out.println("member = " + member);
//            System.out.println("order = " + order); //null
            if (order == null && orderId != null) {
                OrderService service = new OrderService();
                order = service.searchOrderById(orderId);
//                System.out.println("member = " + member);
//                System.out.println("order = " + order);//Yes
                if (order != null && !order.getMember().equals(member)) {
                    order = null;
                }
            }
//            System.out.println("member2 = " + member);
//            System.out.println("order2 = " + order);//null
        %>
        <div id="article">
            <div id="main">

                <div class="product_sort" style="margin-right: 20px; margin-left: 25px; margin-top: 20px;">
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

                <div class="order" style="width: 50%; float: left; ">
                    <%  if (order != null) {%>
                    <div class="info" style="width:50%;min-width: 360px;float: left;margin: 37px;">
                        訂單編號： <span class="orderData"><%= order.getFormatedId()%></span>
                        <hr style="background-color: #5d5d5d; width: 260px; float: left"><br><br>
                        訂單狀態： <span class="orderData"><%= order.getStatusString()%></span><br>
                        <hr class="hd">
                        訂購時間： <span class="orderData"><%= order.getOrderDate()%> ,
                            <%
                                String str = order.getOrderTime().toString();
                                String[] tokens = str.split(":");
                                out.print(tokens[0] + " : " + tokens[1]);
                            %>
                        </span><br>
                        <hr class="hd">
                        付款資訊： <span class="orderData"><%= order.getPaymentType().getDescription()%></span>
                        <%if (order.getPaymentFee() > 0) {%>
                        ,手續費：<span class="orderData"><%= order.getPaymentFee()%>. <%= String.valueOf(order.getPaymentNote()).equals("null") ? "" : order.getPaymentNote()%></span><br>
                        <%}%>
                        <% if (order.getPaymentType() == PaymentType.ATM && order.getStatus() == 0) {%>
                        <a href="paid.jsp?orderId=<%= order.getId()%>">通知已付款</a>
                        <% } %>
                        <% if (order.getPaymentNote() != null && order.getPaymentNote().length() > 0) {%>
                        <br><span class="orderData" style="display: inline-block;margin-left:3px;font-size:smaller"><%= order.getPaymentNote()%></span>
                        <%}%>
                        <br>
                        <hr class="hd">
                        貨運資訊： <span class="orderData"><%= order.getShippingType().getDescription()%></span> 
                        <hr class="hd">
                        物流費：<span class="orderData">
                            <%
                                Double a = order.getShippingFee();
                                DecimalFormat obj = new DecimalFormat("0");
                                out.print(obj.format(a));
                            %> 


                            <%= String.valueOf(order.getPaymentNote()).equals("null") ? "" : order.getShippingNote()%></span><br>
                        <hr class="hd">
                        總金額(含手續費/物流費)： <span class="orderData"><b>
                                <%
                                    Double b = order.getTotalAmountWithFee();
                                    DecimalFormat obj1 = new DecimalFormat();
                                    out.print(obj1.format(b));
                                %>元</b></span>
                    </div>

                    <div class="info_form"  style="width:35%;float: left; margin: 60px 0px 30px -20px;">
                        <fieldset>
                            <legend style="margin-bottom: 12px; margin-left: 42px;">
                                <i style="margin-right: 5px;" class="fas fa-parachute-box">
                                    <span style="margin:0px 0px 5px 5px;">收件人資訊</span>
                                </i>
                            </legend>
                            <label>姓名 <i class="fas fa-angle-right"></i> </label><input class="orderData1" readonly value="<%=  order.getRecipientName()%>"><br>
                            <label>Email <i class="fas fa-angle-right"></i> </label><input class="orderData1" readonly value="<%=  order.getRecipientEmail()%>"><br>
                            <label>電話 <i class="fas fa-angle-right"></i> </label><input class="orderData1" readonly value="<%=  order.getRecipientPhone()%>"><br>
                            <label>地址 <i class="fas fa-angle-right"></i> </label><input class="orderData1" readonly value="<%=  order.getShippingAddress()%>"><br>
                        </fieldset>
                    </div>
                    <%  if (order.getOrderItemSet().size() > 0) {%>

                    <div style="clear: both;width: 100%;">
                        <table style="width:90%; min-width: 350px;margin:auto">
                            <caption style="font-size: larger; font-weight: 700;">訂購明細<hr style=" background-color: #5d5d5d"></caption>

                            <thead>
                                <tr>
                                    <th style=" ">產品資訊</th><th>價格</th><th>數量</th><th>小計</th>                
                                </tr>
                            </thead>
                            <% for (OrderItem item : order.getOrderItemSet()) {%>

                            <tr>
                                <td>
                                    <img src="<%= "../" + item.getProduct().getPhotoUrl()%>" style="width: 32px;vertical-align: middle;margin: auto">
                                    <%=item.getProduct().getName()%>
                                </td>
                                <td>
                                    <%
                                        Double c = item.getPrice();
                                        DecimalFormat obj2 = new DecimalFormat();
                                        out.print(obj2.format(c));
                                    %>
                                </td>
                                <td><%=item.getQuantity()%></td>
                                <td>
                                    <%
                                        Double d = item.getPrice() * item.getQuantity();
                                        DecimalFormat obj3 = new DecimalFormat();
                                        out.print(obj3.format(d));
                                    %>
                                </td>
                            </tr>

                            <% }%>



                        </table>
                        <hr style=" background-color: #5d5d5d; width: 616.36px;font-size: larger;font-weight: 700;">
                        <div class="check_out" style="width: 90%; ">

                            <h4 style="text-align: right; margin-right: -25px; margin-bottom: 100px" >總金額： <small>NT$</small>
                                <span style="color: red;font-size: larger; font-weight: 900">
                                    <%
                                        Double f = order.getTotalAmount();
                                        DecimalFormat obj5 = new DecimalFormat();
                                        out.print(obj5.format(f));
                                    %>
                                </span>元
                            </h4>
                        </div>
                    </div>                
                    <%  }
                    } else {%>    
                    <p>查無此訂單</p>
                    <%}%>   
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
