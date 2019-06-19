<%-- 
    Document   : cart
    Created on : 2019/4/1, 上午 09:19:00
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.OrderShoppingCart"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.entity.CartItem"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.entity.ShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>預訂店取</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
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
        </style>

        <script>
            $(document).on("click", "#goShoppingButton", goShopping);
            function goShopping() {

                location.href = "../products_list.jsp";
            }
            function checkQuantity(inputQuantity) {
                var min = parseInt($(inputQuantity).attr("min"));
                var max = parseInt($(inputQuantity).attr("max"));
                var quantity = parseInt($(inputQuantity).val());
                if (quantity < min || quantity > max) {
                    $(inputQuantity).addClass("stockShortage");
                } else {
                    $(inputQuantity).removeClass("stockShortage");
                    var url = $("#cartForm1").attr("action");
                    var method = $("#cartForm1").attr("method");
                    console.log(url, method);
                    $.ajax({
                        url: url,
                        method: method,
                        data: $("#cartForm1").serialize()
                    }).done(updateCartDoneHandler);
                }
            }
            function updateCartDoneHandler(result, status, xhr) {
                console.log(result);
                $("html").html(result);
            }

        </script>

    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <%
                OrderShoppingCart order_cart = (OrderShoppingCart) session.getAttribute("order_cart");
            %>  
            <div id="main">
                <div class="cart">
                    <% if (order_cart != null && !order_cart.isEmpty()) {
                            ProductService service = new ProductService();

                    %>

                    <form id ="cartForm1" method="POST" action="update_order_cart.do">
                        <div class="list" style="width:85%; min-width: 500px; margin: 0 auto;">
                            <table style="width: 90%;margin: auto">
                                <h2 >預訂店取清單</h2>   
                                <hr id="hr">

                                <tr><th>商品名稱</th><th>口味</th><th>價格</th><th>數量</th><th>小計</th><th></th></tr>
                                        <%                                            
                                            for (CartItem item : order_cart.getCartItemSet()) {
                                                Product p = item.getProduct();
                                                int stock = service.getProductStock(String.valueOf(p.getId()), String.valueOf(p.getSchedule()));
                                        %>
                                <tr>
                                    <td><img src="<%= "../" + p.getPhotoUrl()%>" style="width:50px;vertical-align: middle; text-align: left; margin:0px 17px 7px -50px;"><%= p.getName()%></td>
                                    <td><%= p.getTaste()%></td>
                                    <td>
                                        <%
                                            Double b = p.getUnitPrice();
                                            DecimalFormat ob = new DecimalFormat();
                                            int priceb = Integer.parseInt(ob.format(b));
//                                            out.print(ob.format(b));
                                        %>
                                        <input value="<%=priceb%>" 
                                               readonly style="border-style: none; font-size: larger; width:50px; text-align: center " >
                                    </td>
                                    <!--數量 -->
                                    <td>
                                        <input onchange="checkQuantity(this)"  <%= stock < order_cart.getQuantity(item) ? "class='stockShortage'" : ""%>  id="quantity"
                                               style="width:3em" type="number" name="order_quantity_<%= item.hashCode()%>"  
                                               value="<%= order_cart.getQuantity(item)%>" min="<%= p.getStock() > 0 ? 1 : 0%>" max="<%= p.getStock()%>"> 
                                    </td>
                                    <!--小計 -->
                                    <%
                                        Double a = order_cart.getQuantity(item) * p.getUnitPrice();
                                        DecimalFormat obj = new DecimalFormat("0");
                                        int pricea = Integer.parseInt(obj.format(a));
//                                            out.print(obj.format(a));
                                    %>
                                    <td style="color: #d50000;font-size: medium" >
                                        <span readonly style="border-style: none; font-size: larger; width:50px; text-align: center "><%= pricea%></span>
                                    </td>
                                    <!--刪除 -->
                                    <td>
                                        <button name="order_delete_<%= item.hashCode()%>" style="border-style: none; background: white">
                                            <i style="font-size: large" class="far fa-trash-alt"></i>
                                        </button>
                                    </td>
                                </tr>                    
                                <% }%>
                            </table>
                            <hr id="hr"> 
                        </div>
                        <!--總金額 -->
                        <div class="check_out" style="width: 90%; ">
                            <h4 style="text-align: right" >總金額： <small>NT$</small>
                                <span style="color: red;font-size: larger; font-weight: 900;border-style: none; font-size: larger;
                                       width:50px; text-align: center;" readonly><%= order_cart.getTotalAmount()%> </span>
                                元
                            </h4>
                        </div>
                        <div class="btn" style="width: 80%; min-width: 500px; margin: 30px auto;opacity: 0.8">
                            <button value="繼續猜心" name="submit1" id="goShoppingButton" style="margin: 5px; padding: 5px; background: white; border: 1px solid black; border-radius: 8px; vertical-align: middle;font-weight: 700;font-family: '微軟正黑體' ">
                                <i class="fas fa-angle-double-left"></i>
                                <span>繼續猜心</span>
                            </button>

                            <button value="確認結帳" name="submit1" style="margin: 5px; padding: 5px; background: white; border: 1px solid black; border-radius: 8px; vertical-align: middle; float: right;font-weight: 700;font-family: '微軟正黑體' " >
                                <span>確認結帳</span>
                                <i class="fas fa-angle-double-right"></i>
                            </button>
                        </div>
                    </form>
                    <% } else {%>
                    <div style="width: 800px; margin: 0 auto">
                        <a href="../products_list.jsp">
                            <img src="<%= request.getContextPath()%>/images/noitem2.png" alt="購物車是空的，請回到賣場購物" >
                        </a>
                    </div>
                    <% }%> 
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
