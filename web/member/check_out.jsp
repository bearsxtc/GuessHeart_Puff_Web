<%-- 
    Document   : check_out
    Created on : 2019/4/1, 下午 01:38:52
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.entity.ShippingType"%>
<%@page import="uuu.ghp.entity.PaymentType"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.entity.CartItem"%>
<%@page import="uuu.ghp.entity.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>結帳作業</title>
        <style>
            label{
                font-size: 14px;
            }
        </style>        
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            $(document).on("click", "#goShoppingButton", goShopping);
            function goShopping() {
                //alert("goShopping");
                location.href = "../products_list.jsp";
            }

            $(document).on("click", "#back_to_cart", back_to_cart);
            function back_to_cart() {
                location.href = "cart.jsp";
            }

            function changeShippingOption() {
                var shipping = $("#paymentType>option:selected").attr("data-shipping");
                if (shipping.length > 0) {
                    var shippingArray = shipping.split(",");
                    var options = $("#shippingType option");
                    $.map(options, function (option) {
                        $(option).attr("disabled", true);
                    });
                    for (i = 0; i < shippingArray.length; i++) {
                        $("#shippingType>option[value='" + shippingArray[i] + "']").attr("disabled", false);
                    }
                    $("#shippingType>option[value='']").attr("disabled", false);
                    $("#shippingType").val("${param.shippingType}");
                }
                calculateFee();
            }

            function calculateFee() {
                var paymentFee = parseFloat($("#paymentType>option:selected").attr("data-fee"));
                var shippingFee = parseFloat($("#shippingType>option:selected").attr("data-fee"));
                var totalAmount = parseFloat($("#totalAmount").text());
                console.log(paymentFee, shippingFee, totalAmount);
                $("#totalAmountWithFee").text((isNaN(paymentFee) ? 0 : paymentFee) + (isNaN(shippingFee) ? 0 : shippingFee) + totalAmount);
            }

            function shippingChange() {
                var width = parseFloat($("#phone").css("width"));
                console.log(width);

                $("#address").removeAttr("list");
                $("#address").removeAttr("autocomplete");
                $("#address").removeAttr("placeholder");
                $("#address").attr("readonly", false);
                $("#address").css("width", width);
                $("#storeButton").css("display", "none");
                $("#address").val("");
                if ($("#shippingType").val() == "<%= ShippingType.SHOP.name()%>") {
                    $("#address").attr("placeholder", "請選擇門市");
                    $("#address").attr("list", "shopList");
                    $("#address").attr("autocomplete", "off");
                } else {
                    $("#address").attr("placeholder", "請輸入收件地址");
                }
            }

            function changeSize() {
                var width = parseFloat($("#phone").css("width"));
                if ($("#shippingType").val() == "<%= ShippingType.SHOP.name()%>") {
                    $("#address").css("width", width - 77);
                } else {
                    $("#address").css("width", width);
                }
            }

            $(function () {
                changeShippingOption();
            });

            $(document).on("change", "#check", sametobuy);
            function sametobuy() {
                var x = document.getElementById("check");
                if (x.checked == true) {
                    $("#rs_name").val("${sessionScope.member.name}");
                    $("#rs_email").val("${sessionScope.member.email}");
                    $("#rs_phone").val("${sessionScope.member.phone}");
                    
                } else {
                    $("#rs_name").val("");
                    $("#rs_email").val("");
                    $("#rs_phone").val("");
                    
                }
            }

        </script>
        <style>
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background: black
                    /*background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(200,200,200,1), rgba(254,254,254,0));*/
            }
            td{
                text-align: center;
            }
            body{
                font-family: '微軟正黑體';
            }
        </style>
    </head>
    <body onresize="changeSize()">
        <jsp:include page="/WEB-INF/subviews/header.jsp" />

        <div id="article">
            <%
                ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
            %>            
            <% if (cart != null && !cart.isEmpty()) {%>
            ${requestScope.errors}
            <div id="main">
                <div class="ch">
                    <form method="POST" action="check_out.do">                
                        <div class="list" style="width:60%; min-width: 500px; margin: 0 auto;">
                            <table style="width: 90%;margin: auto">
                                <h2 >訂單明細</h2>   
                                <hr id="hr">
                                <tr><th>商品名稱</th><th>口味</th><th>價格</th><th>數量</th><th>小計</th></tr>
                                </thead>

                                <% for (CartItem item : cart.getCartItemSet()) {
                                        Product p = item.getProduct();
                                %>
                                <tr>
                                    <td><img src="<%= "../" + p.getPhotoUrl()%> " style="width:50px;vertical-align: middle;text-align: left; margin:0px 17px 7px -50px;"><%= p.getName()%></td>
                                    <td><%= p.getTaste()%></td>
                                    <td>
                                        <span style=" font-size: 14px; ">NT$</span>
                                        <%
                                            Double b = p.getUnitPrice();
                                            DecimalFormat obj1 = new DecimalFormat("0");
                                            out.print(obj1.format(b));
                                        %>
                                    </td>
                                    <td><%= cart.getQuantity(item)%></td>
                                    <td style="color: #d50000;font-size: medium">
                                        <span style="color: #d50000; font-size: 14px; ">NT$</span>
                                        <%
                                            Double a = cart.getQuantity(item) * p.getUnitPrice();
                                            DecimalFormat obj = new DecimalFormat("0");
                                            out.print(obj.format(a));
                                        %> 元
                                    </td>
                                </tr>                    
                                <% }%>
                            </table>
                            <hr id="hr">
                        </div>


                        <div class="check_out" style="width: 80%; ">
                            <h4 style="text-align: right" >總金額： <small>NT$</small><span style="color: red;font-size: larger; font-weight: 900"><%= cart.getTotalAmount()%></span>元</h4>
                        </div>
                        <table style="width: 60%; margin: 20px auto 10px">
                            <tr>
                                <td >
                                    <div style="width:45%;float:left;">
                                        <label>付款方式：</label>
                                        <select name="paymentType" id="paymentType" required onchange="changeShippingOption()">
                                            <option value="">請選擇...</option>
                                            <% for (PaymentType pType : PaymentType.values()) {
                                                    String shipping = "";
                                                    for (ShippingType shType : pType.getShippingTypeArray()) {
                                                        if (shipping.length() > 0) {
                                                            shipping += ",";
                                                        }
                                                        shipping += shType.name();
                                                    }
                                            %>
                                            <option value="<%= pType.name()%>" <%= pType.name().equals(request.getParameter("paymentType")) ? "selected" : ""%>
                                                    data-fee="<%= pType.getFee()%>" data-shipping="<%= shipping%>">
                                                <%= pType%>
                                            </option>
                                            <% } %>
                                        </select>
                                    </div>

                                    <div style="width:45%;float:left;">
                                        <label disabled>貨運方式：</label>
                                        <select name="shippingType" id="shippingType" required onchange="shippingChange()">
                                            <option value="">請選擇...</option>
                                            <% for (ShippingType shType : ShippingType.values()) {%>
                                            <option value="<%= shType.name()%>" <%= shType.name().equals(request.getParameter("shippingType")) ? "selected" : ""%>
                                                    data-fee="<%= shType.getFee()%>"><%= shType%></option>
                                            <% }%>
                                        </select>
                                    </div>
                                </td>
                            </tr>
                        </table>

                        <table style="width: 60%; margin: 20px auto 10px">           
                            <tr>
                                <td>
                                    <span style="width:45%;float: left">
                                        <fieldset>
                                            <legend><img src="../images/icon.png" style="width: 16px; padding-right: 2px;">訂購人</legend>
                                            <label>姓名：</label><input id="by_name" readonly value="<%= ((Customer) session.getAttribute("member")).getName()%>" name="br_name"><br>
                                            <label>Email：</label><input id="by_email" readonly value="${sessionScope.member.email}" name="by_email"><br>
                                            <label>電話：</label><input id="by_phone" readonly value="${sessionScope.member.phone}" name="by_phone"><br>
                                            <label>地址：</label><input id="by_addr" readonly value="${sessionScope.member.address}" name="by_address"><br>
                                        </fieldset>
                                    </span>
                                    <span style="width:45%;float: right">
                                        <fieldset>
                                            <legend><img src="../images/icon.png" style="width: 16px; padding-right: 2px;">收件人 
                                                <input type="checkbox" id="check" onchange="sametobuy(this)"><span style="font-size: small">同訂購人</span>
                                            </legend>

                                            <label>姓名：</label>
                                            <input id="rs_name" required value="" name="name"><br>
                                            <label>Email：</label>
                                            <input id="rs_email" required value="" name="email"><br>
                                            <label>電話：</label>
                                            <input id="rs_phone" required value="" name="phone"><br>
                                            <label>地址：</label>
                                            <input  required autocomplete="off" value="" id="address" name="address"><br>
                                            <datalist id="shopList">
                                                <option value="高雄總店-802 高雄市泰順街60號">
                                            </datalist>
                                        </fieldset>
                                    </span>
                                </td>
                            </tr>
                        </table> 

                        <div style="width: 25%; margin: 20px auto 10px; opacity: 0.6">
                            <button value="回到賣場" id="goShoppingButton" style="margin: 5px; padding: 5px; background: white; border: 1px solid black; border-radius: 8px; vertical-align: middle">
                                <i style="font-size: 16px;" class="fas fa-arrow-alt-circle-left">
                                    <span style="font-family: '微軟正黑體';">回到賣場</span>
                                </i>
                            </button>
                            <button value="回到購物車" id="back_to_cart" style="margin: 5px; padding: 5px; background: white; border: 1px solid black; border-radius: 8px; vertical-align: middle">
                                <i style="font-size: 16px;  "class="fas fa-arrow-alt-circle-up">
                                    <span style="font-family: '微軟正黑體';">回到購物車</span>
                                </i>
                            </button>
                            <button type="submit" value="送出訂單" style="margin: 5px; padding: 5px; background: white; border: 1px solid black; border-radius: 8px; vertical-align: middle">
                                <i style="font-size: 16px;" class="fas fa-arrow-alt-circle-right">
                                    <span style="font-family: '微軟正黑體';">送出訂單</span>
                                </i>
                            </button>
                        </div>

                    </form>   
                    <%} else {%>
                    <p>購物車是空的，請<a href="../products_list.jsp">回到賣場購物，然後才能結帳</a></p>
                    <%}%>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
