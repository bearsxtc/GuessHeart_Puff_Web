<%-- 
    Document   : all_cart
    Created on : 2019/4/17, 下午 08:22:52
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.ShoppingCart"%>
<%@page import="uuu.ghp.entity.CartItem"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="uuu.ghp.entity.OrderShoppingCart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>購物車</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
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
            .ui-widget.ui-widget-content {
                /* border: 1px solid #c5c5c5; */
                border-style: none;
            }
            .ui-corner-all, .ui-corner-bottom, .ui-corner-right, .ui-corner-br {
                /* border-bottom-right-radius: 3px; */
                border-style: none;
            }

            .ui-corner-all, .ui-corner-bottom, .ui-corner-left, .ui-corner-bl {
                /* border-bottom-left-radius: 3px; */
                border-style: none;
            }
            .ui-corner-all, .ui-corner-top, .ui-corner-right, .ui-corner-tr {
                /* border-top-right-radius: 3px; */
                border-style: none;
            }
            .ui-corner-all, .ui-corner-top, .ui-corner-left, .ui-corner-tl {
                /* border-top-left-radius: 3px; */
                border-style: none;
            }
            .ui-widget-content {
                /* border: 1px solid #dddddd; */
                border-style: none;
                background: #ffffff;
                color: #333333;
            }
            .ui-widget {
                border-style: none;
                font-family: '微軟正黑體';
                font-size: 1.2em;
            }
            .ui-tabs {
                border-style: none;
                position: relative;
                /* padding: .2em; */
            }
            .ui-tabs .ui-tabs-nav {
                margin: 0;
                /* padding: .2em .2em 0; */
            }
            .ui-widget-header {
                background: white;
                color: #333333;
                font-weight: bold;
            }
            .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover {
                border: 1.5px solid #d26900;
                background: #ff8000;
                font-weight: normal;
            </style>
            <script>
//                $(document).on("click", "#goShoppingButton", goShopping);
//                function goShopping() {
//
//                    location.href = "../products_list.jsp";
//                }
//                function checkQuantity(inputQuantity) {
//                    var min = parseInt($(inputQuantity).attr("min"));
//                    var max = parseInt($(inputQuantity).attr("max"));
//                    var quantity = parseInt($(inputQuantity).val());
//                    if (quantity < min || quantity > max) {
//                        $(inputQuantity).addClass("stockShortage");
//                    } else {
//                        $(inputQuantity).removeClass("stockShortage");
//                        var url = $("#cartForm").attr("action");
//                        var method = $("#cartForm").attr("method");
//                        console.log(url, method);
//                        $.ajax({
//                            url: url,
//                            method: method,
//                            data: $("#cartForm").serialize()
//                        }).done(updateCartDoneHandler);
//                    }
//                }
//                 function updateCartDoneHandler(result, status, xhr) {
//                    console.log(result);
//                    $("html").html(result);
//                }
//                
//                 function checkOrderQuantity(inputQuantity) {
//                    var min = parseInt($(inputQuantity).attr("min"));
//                    var max = parseInt($(inputQuantity).attr("max"));
//                    var quantity = parseInt($(inputQuantity).val());
//                    if (quantity < min || quantity > max) {
//                        $(inputQuantity).addClass("stockShortage");
//                    } else {
//                        $(inputQuantity).removeClass("stockShortage");
//                        var url = $("#cartForm1").attr("action");
//                        var method = $("#cartForm1").attr("method");
//                        console.log(url, method);
//                        $.ajax({
//                            url: url,
//                            method: method,
//                            data: $("#cartForm1").serialize()
//                        }).done(updateCartDoneHandler2);
//                    }
//                }
//                function updateCartDoneHandler2(result, status, xhr) {
//                    console.log(result);
//                    $("html").html(result);
//                }

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
        </head>
        <body>
            <jsp:include page="/WEB-INF/subviews/header.jsp"/>
            <div id="article">
                <div id="main">
                    <div id="tabs">
                        <ul>
                            <li><a href="#tabs-1">購物車清單</a></li>
                            <li><a href="#tabs-2">預訂清單</a></li>

                        </ul>
                        <hr id="hr">
                        <div id="tabs-1">
                            <%@include file="/member/cart.jsp" %>
                           
                            </div>


                            <!--預訂購物車-->
                            <div id="tabs-2">
                                <div role="tabpanel" class="tab-pane active" id="product-detail-3">
                                    <%@include file="/member/order_cart.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%@include file="/WEB-INF/subviews/footer.jsp"  %>
            </body>
        </html>
