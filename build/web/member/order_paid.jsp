<%-- 
    Document   : paid
    Created on : 2018/9/6, 下午 04:31:43
    Author     : Admin
--%>

<%@page import="uuu.ghp.model.Order_OrderService"%>
<%@page import="uuu.ghp.entity.Order_Order"%>
<%@page import="uuu.ghp.model.OrderService"%>
<%@page import="uuu.ghp.entity.Order"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>通知已轉帳</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <%@include file="/WEB-INF/subviews/global.jsp" %>
        <style>
            #main{
                width: 30%;
                margin: 60px auto;
            }
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background: black
                    /*background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(200,200,200,1), rgba(254,254,254,0));*/
            }
        </style>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>

        <%
            Customer member = (Customer) session.getAttribute("member");
            Order_Order order_order = (Order_Order) request.getAttribute("order_order");
            if (member != null && order_order == null) {
                String orderId = request.getParameter("orderId");
                if (orderId != null && orderId.matches("\\d+")) {
                    Order_OrderService service = new Order_OrderService();
                    order_order = service.selectOrder_OrderById(orderId);
                    if (order_order != null && !member.equals(order_order.getMember())) {
                        order_order = null;
                    }
                }
            }
        %>        
        <div id="article">     
            <div id="main">
                <span style="font-size: larger; font-weight: 800">通知付款</span>
                <img src="../images/icon.png" style="width: 16px;">
                <hr id="hr">
                <%if (order_order != null) {%>
                <form action="order_paid.do" method="GET">
                    ${requestScope.errors}
                    <p>
                        <label>訂單編號: </label>
                        <input hidden name="orderId" value="<%= order_order.getId()%>">
                        <input readonly value="<%= order_order.getFormatedId()%>">
                    </p>
                    <p>
                        <label>轉帳銀行: </label>
                        <input required name="bank" placeholder="請輸入轉帳銀行名稱" value="${param.bank}">
                    </p>                    
                    <p>
                        <label>帳號後五碼: </label>
                        <input required name="last5Code" placeholder="請輸入轉帳帳號後5碼" value="${param.last5Code}">
                    </p>                     
                    <p>
                        <label>轉帳金額: </label>
                        <input required type="number" min="1" name="amount" value="<%= request.getParameter("amount") == null ? Math.round(order_order.getTotalAmountWithFee()) : request.getParameter("amount")%>" >
                    </p>                    
                    <p>
                        <label>轉帳日期: </label>
                        <input  type="date" required name="date" min="<%= order_order.getOrderDate()%>" max="<%= LocalDate.now()%>" value="${param.date}">
                        <label>時間: </label><input  type="time" required name="time" value="${param.time}">
                    </p>           
                    <input type="submit" value="確定">
                </form>            
                <%} else {%>
                <p>查無此訂單</p>            
                <%}%>            
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"%>
    </body>
</html>