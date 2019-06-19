<%-- 
    Document   : product
    Created on : 2019/3/27, 上午 11:04:03
    Author     : Admin
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <title>產品明細</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            function getStock(pid) {
                var schedule = $("#schedule").val();
                if (schedule == "Eve") {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/get_product_stock.jsp?productId=' + pid
                    }).done(getStockDoneHandler);
                }
            }

            function getStockDoneHandler(result) {
                var stock = parseInt(result);
                if (stock > 0) {
                    $("#quantity").attr("min", 1);
                    $("#quantity").attr("max", stock);
                    $("#quantity").val(1);
                } else {
                    $("#quantity").attr("min", 0);
                    $("#quantity").attr("max", 0);
                    $("#quantity").val("");
                    $("#quantity").attr("placeholder", "已無庫存!");
                }
            }

            function addOrderCart() {
                var valid = validate();
                console.log(valid);
                if (valid) {
                    var url = $("#cartForm1").attr("action");
                    var method = $("#cartForm1").attr("method");
                    console.log(url, method);
                    $.ajax({
                        url: url,
                        method: method,
                        data: $("#cartForm1").serialize()
                    }).done(addOrderCartDoneHandler);
                }
            }
             function addOrderCartDoneHandler(result, status, xhr) {
                console.log(result);
                $("#OrderCartTotalQuantity").html(result);
                
                var x = document.getElementById("snackbar");
                x.className = "show";
                setTimeout(function () {
                    x.className = x.className.replace("show", "");
                }, 1500);
            }

            function addCart() {
                var valid = validate();
                console.log(valid);
                if (valid) {
                    var url = $("#cartForm").attr("action");
                    var method = $("#cartForm").attr("method");
                    console.log(url, method);
                    $.ajax({
                        url: url,
                        method: method,
                        data: $("#cartForm").serialize()
                    }).done(addCartDoneHandler);
                }
            }
            function addCartDoneHandler(result, status, xhr) {
                console.log(result);
                $("#cartTotalQuantity").html(result);
                
                var x = document.getElementById("snackbar");
                x.className = "show";
                setTimeout(function () {
                    x.className = x.className.replace("show", "");
                }, 1500);
            }
            function validate() {
                var min = parseInt($("#quantity").attr("min"));
                var max = parseInt($("#quantity").attr("max"));
                var value = parseInt($("#quantity").val());
                console.log(min, max, value);
                var message = "請";
                var isCorrect = true;
                if (isNaN(value) || value < min || value > max) {
                    isCorrect = isCorrect && (value >= min && value <= max);
                    if (message !== "請")
                        message += "和";
                    message += "輸入正確的數量";
                }
                if (!isCorrect) {
                    alert(message);
                }

                return (isCorrect);
            }

            $(function () {
                var tabs = $("#tabs").tabs();
                tabs.find(".ui-tabs-nav").sortable({
                    axis: "x",
                    stop: function () {
                        tabs.tabs("refresh");
                    }
                });
            });
        </script>
        <style>
            .fancybox-slide--html .fancybox-content {
                margin-bottom: 6px;
                width: 550px;
            }
            .productDetail{
                width: 300px;
            }
            .item_img{
                width:250px;
            }

            .cart{
                margin-right: -170px;
            }
            #tabs{
                width: 600px;
                margin: 0 auto;
            }
            #tabs ul{
                background: white;
                border-style: none;
            }
            #tabs ul li{
                width: 30%;
                border-style: none;
            }
            #tabs ul li a{
                font-family: '微軟正黑體';
                font-size: 15px;
                font-weight: 700;

                color: #303030;
                text-align: center;
                margin-right: 2px;
                line-height: 1.42857143;
                border: 1px solid transparent;
                border-radius: 4px 4px 0 0;

            }
            .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover{
                border: 1px solid whitesmoke;
                border-bottom: transparent;
                background: white; 
                font-weight: normal; 
                color: #ffffff; 
            }
            p{
                font-size: 14px;
                line-height: 1.42857143;
                color: #333;
                margin: 10px;
            }
            .ui-tabs .ui-tabs-nav .ui-tabs-anchor{
                float: none;
                text-align: center;
                vertical-align: middle;
            }
            #snackbar {
                visibility: hidden;
                min-width: 250px;
                margin-left: -125px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 2px;
                padding: 16px;
                position: fixed;
                z-index: 1;
                left: 50%;
                top: 30px;
                font-size: 17px;
            }

            #snackbar.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            @-webkit-keyframes fadein {
                from {top: 0; opacity: 0;} 
                to {top: 30px; opacity: 1;}
            }

            @keyframes fadein {
                from {top: 0; opacity: 0;}
                to {top: 30px; opacity: 1;}
            }

            @-webkit-keyframes fadeout {
                from {top: 30px; opacity: 1;} 
                to {top: 0; opacity: 0;}
            }

            @keyframes fadeout {
                from {top: 30px; opacity: 1;}
                to {top: 0; opacity: 0;}
            }
        </style>
    </head>

    <body>
        <%
            String productId = request.getParameter("productId");

            ProductService service = new ProductService();
            Product p = null;
            if (productId != null) {
                p = service.searchProductById(productId);
            }
        %>

        <div id="article"> 
            <div id="main">
                <div class="pd">
                    <div class="productDetail" >
                        <%if (p != null) {%>

                        <img  src="<%= p.getPhotoUrl()%>">

                        <div class="cart">
                            <% if (p.getName().equals("獨家甜筒泡芙") || p.getName().equals("焦糖布蕾泡芙")) {%>
                            <form id='cartForm1' onsubmit="return validate()" method="POST" action="add_order_cart.do"> 
                                <input name="productName" readonly style="border-style: none; font-family: '微軟正黑體'; font-size: larger; font-weight: 800;" value='<%= p.getName()%>'>
                                <% if (p.getTaste() != null && p.getTaste().length() > 0) {%>
                                <h4>口味 : <%= p.getTaste()%></h4>
                                <%} else {%>
                                <br>
                                <%}%>
                                <p>價格 :  <%
                                    Double a = p.getUnitPrice();
                                    DecimalFormat obj = new DecimalFormat("0");
                                    out.print(obj.format(a));
                                    %> 元</p>

                                <input style="padding-left: 10px" type='hidden' name='productId' value='<%= p.getId()%>'>
                                <p>
                                    <label>數量:</label>
                                    <% if (p.getStock() > 0) {%>
                                    <input type='number' id='quantity' name='quantity' required style="width: 120px;" min='<%= p.getStock() > 0 ? 1 : 0%>'
                                           max='<%= p.getStock() > 10 ? 10 : p.getStock()%>'  placeholder="<%= p.getStock() > 0 ? "輸入數量" : "已無庫存"%>"> 
                                    <br>
                                    <a href='javascript:addOrderCart()' style="background-color: #5cb85c; border-color: #4cae4c; color: #fff;
                                       display: inline-block;
                                       padding: 6px 12px;
                                       margin-top: 12px;
                                       margin-bottom: 0;
                                       font-family: '微軟正黑體';
                                       font-size: 15px;
                                       font-weight: 400;
                                       line-height: 1.42857143;
                                       text-align: center;
                                       white-space: nowrap;
                                       vertical-align: middle;
                                       -ms-touch-action: manipulation;
                                       cursor: pointer;
                                       -webkit-user-select: none;
                                       -moz-user-select: none;
                                       -ms-user-select: none;
                                       background-image: none;
                                       border: 1px solid transparent;
                                       border-radius: 4px;
                                       ">
                                        加入預訂購物車
                                    </a>

                                    <%} else {%>
                                    <input type='text' id='quantity' style="width: 120px;" placeholder="已無庫存"> 
                                    <br>
                                    <a href='#' style="    
                                       color: #fff;
                                       background-color: #c9302c;
                                       border-color: #ac2925;
                                       display: inline-block;
                                       padding: 6px 12px;
                                       margin-top: 12px;
                                       margin-bottom: 0;
                                       font-family: '微軟正黑體';
                                       font-size: 15px;
                                       font-weight: 400;
                                       line-height: 1.42857143;
                                       text-align: center;
                                       white-space: nowrap;
                                       vertical-align: middle;
                                       -ms-touch-action: manipulation;
                                       cursor: pointer;
                                       -webkit-user-select: none;
                                       -moz-user-select: none;
                                       -ms-user-select: none;
                                       background-image: none;
                                       border: 1px solid transparent;
                                       border-radius: 4px;
                                       ">
                                        貨到通知我
                                    </a>
                                    <%}%>
                                </p>
                            </form>

                            <%} else {%>

                            <form id='cartForm' onsubmit="return validate()" method="POST" action="add_cart.do"> 
                                <input readonly style="border-style: none; font-family: '微軟正黑體'; font-size: larger; font-weight: 800;" value='<%= p.getName()%>'>
                                <% if (p.getTaste() != null && p.getTaste().length() > 0) {%>
                                <h4>口味 : <%= p.getTaste()%></h4>
                                <%} else {%>
                                <br>
                                <%}%>
                                <p>價格 :  <%
                                    Double a = p.getUnitPrice();
                                    DecimalFormat obj = new DecimalFormat("0");
                                    out.print(obj.format(a));
                                    %> 元</p>

                                <input style="padding-left: 10px" type='hidden' name='productId' value='<%= p.getId()%>'>
                                <p>
                                    <label>數量:</label>
                                    <% if (p.getStock() > 0) {%>
                                    <input type='number' id='quantity' name='quantity' required style="width: 120px;" min='<%= p.getStock() > 0 ? 1 : 0%>'
                                           max='<%= p.getStock() > 10 ? 10 : p.getStock()%>'  placeholder="<%= p.getStock() > 0 ? "輸入數量" : "已無庫存"%>"> 
                                    <br>
                                    <a href='javascript:addCart()' style="background-color: red; border-color: #4cae4c; color: #fff;
                                       display: inline-block;
                                       padding: 6px 12px;
                                       margin-top: 12px;
                                       margin-bottom: 0;
                                       font-family: '微軟正黑體';
                                       font-size: 15px;
                                       font-weight: 400;
                                       line-height: 1.42857143;
                                       text-align: center;
                                       white-space: nowrap;
                                       vertical-align: middle;
                                       -ms-touch-action: manipulation;
                                       cursor: pointer;
                                       -webkit-user-select: none;
                                       -moz-user-select: none;
                                       -ms-user-select: none;
                                       background-image: none;
                                       border: 1px solid transparent;
                                       border-radius: 4px;
                                       ">
                                        加入購物車
                                    </a>
                                    <%} else {%>
                                    <input type='text' id='quantity' style="width: 120px;" placeholder="已無庫存"> 
                                    <br>
                                    <a href='#' style="    
                                       color: #fff;
                                       background-color: #c9302c;
                                       border-color: #ac2925;
                                       display: inline-block;
                                       padding: 6px 12px;
                                       margin-top: 12px;
                                       margin-bottom: 0;
                                       font-family: '微軟正黑體';
                                       font-size: 15px;
                                       font-weight: 400;
                                       line-height: 1.42857143;
                                       text-align: center;
                                       white-space: nowrap;
                                       vertical-align: middle;
                                       -ms-touch-action: manipulation;
                                       cursor: pointer;
                                       -webkit-user-select: none;
                                       -moz-user-select: none;
                                       -ms-user-select: none;
                                       background-image: none;
                                       border: 1px solid transparent;
                                       border-radius: 4px;
                                       ">
                                        貨到通知我
                                    </a>
                                    <%}%>
                                </p>
                            </form>
                            <%}%>
                        </div>
                        <% } else {%>
                        <p>查無此產品!</p>
                        <%}%>
                    </div>
                </div>  
            </div>  
            <div id="snackbar" style="font-family: '微軟正黑體'" >已加入購物車</div>
    </body>

</html>
