<%-- 
    Document   : index
    Created on : 2019/3/25, 下午 07:14:49
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <title>GH-Puff</title>
        <link href="OwlCarousel2-2.3.4/dist/assets/owl.carousel.css" rel="stylesheet" type="text/css"/>
        <link href="OwlCarousel2-2.3.4/dist/assets/owl.theme.default.min.css" rel="stylesheet" type="text/css"/>
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
                    $("#quantity").attr("placeholder", "已無庫存");
                }
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
            }
            function validate() {
                var min = parseInt($("#quantity").attr("min"));
                var max = parseInt($("#quantity").attr("max"));
                if (min == 0 && max == 0) {
                    alert("此產品已無庫存，無法加入購物車");
                    return false;
                }
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

            function getProduct(pid) {
                //同步GET請求
//                location.href = "product.jsp?productId=" + pid;

                //非同步GET請求
                $.ajax({
                    url: "product_ajax.jsp?productId=" + pid
                }).done(getProductDoneHandler);
            }

            function getProductDoneHandler(result, status, xhr) {
                console.log(result);
                $("#productDetail").html(result);
                $.fancybox.open({
                    src: "#productDetail"
                });
            }
        </script>
        <style>
            footer{
                margin-top: 25px;
            }
/*            .image{
                width: 80%;
                min-width: 500px;
                max-width: 960px;
            }*/
            #article{
                height: auto;
            }

            .season_limit{
                width: 80%;
                margin: 0 auto;
            }

            .hot_sale{
                width: 80%;
                margin: 0 auto;
            }


            .AD{
                width: 80%;
                margin: 0 auto;
                height: 200px;
            }

            #HS{
                margin-right: 53px;
                width: 300px;
            }

        </style>

    </head>
    <body>

        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <div id="article">
            <div id="main">

                <div class="owl-carousel owl-theme">
                    <div class="center"><img  src="images/2 - 複製.jpg"></div>
                    <div class="center"><img  src="images/11.jpg"></div>
                    <div class="center"><img  src="images/12.jpg"></div>
                    <div class="center"><img  src="images/13.jpg"></div>
                    <div class="center"><img  src="images/15.jpg"></div>
                    <div class="center"><img  src="images/7.jpg"></div>
                    <div class="center"><img  src="images/8.jpg"></div>
                    <div class="center"><img  src="images/9.jpg"></div>
                    <div class="center"><img  src="images/4.jpg"></div>
                    <div class="center"><img  src="images/5 - 複製.jpg"></div>
                    <div class="center"><img  src="images/6 - 複製.jpg"></div>
                    <div class="center"><img  src="images/10.jpg"></div>
                    <div class="center"><img  src="images/16.jpg"></div>
                    <div class="center"><img  src="images/17.jpg"></div>
                </div>
                <div class="AD">

                </div>

                <div class="season_limit">
                    <div class="today_time">

                        <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>季節限定：</h3>
                        <hr id="hr">
                    </div>
                    <div class="everyDay">
                        <table>  
                            <tr>
                                <%
                                    ProductService service = new ProductService();
                                    List<Product> list = service.selectProductBySeasonLimited();
                                    for (int i = 0; i < list.size(); i++) {
                                        Product p = list.get(i);
                                %>
                                <td class="productItem" >

                                    <img src="<%=p.getPhotoUrl()%>" onerror="getPuffImage(this)">
                                    <h1 style="text-align: center; font-size: large"><%= p.getName()%>
                                        <% if (p.getTaste().length() > 0 && !p.getTaste().equals("null")) {%>
                                        /
                                        <small><%= p.getTaste()%></small>
                                        <%} else {%>
                                        <br>
                                        <%}%>
                                    </h1>

                                    <div style="margin: 10px 0px 10px 0px;">

                                        <span style="color: #d50000; font-size: 14px; ">NT$</span> <span style="color: #d50000;font-size: medium">
                                            <%
                                                Double a = p.getUnitPrice();
                                                DecimalFormat obj = new DecimalFormat("0");
                                                out.print(obj.format(a));
                                            %>
                                        </span>
                                    </div>
                                    <a href='javascript:getProduct(<%= p.getId()%>)'>   
                                        <button type="button" class="btn btn-primary show-quick-dialog" data-value="10" 
                                                style="
                                                width: 115.64px;
                                                height: 33px;
                                                vertical-align: middle;
                                                text-align: center;
                                                background: transparent; 
                                                margin-bottom: 10px;
                                                border: 1px solid black;
                                                " >
                                            <i class="fa fa-shopping-cart"></i>
                                            加入購物車
                                        </button>
                                    </a>
                                </td>

                                <%}%>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="hot_sale">
                    <div class="today_time">
                        <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>熱銷商品：</h3>
                        <hr id="hr">
                    </div>
                    <div class="everyDay">
                        <table>  
                            <tr>
                                <%
                                    ProductService serviceH = new ProductService();
                                    List<Product> listH = serviceH.selectHotSaleProduct();
                                    for (int i = 0; i < listH.size(); i++) {
                                        Product p = listH.get(i);
                                %>
                                <td id="HS" class="productItem" >
                                    <a href='javascript:getProduct(<%= p.getId()%>)'>                        
                                        <img style="width: 100% " src="<%=p.getPhotoUrl()%>" onerror="getPuffImage(this)">
                                        <h1 style="text-align: center; font-size: large"><%= p.getName()%>
                                            <% if (p.getTaste().length() > 0 && !p.getTaste().equals("null")) {%>
                                            /
                                            <small><%= p.getTaste()%></small>
                                            <%} else {%>
                                            <br>
                                            <%}%>
                                        </h1>
                                    </a>
                                    <div style="margin: 10px 0px 10px 0px;">
                                        <span style="color: #d50000; font-size: 14px;">NT$</span> <span style="color: #d50000;font-size: medium">
                                            <%
                                                Double a = p.getUnitPrice();
                                                DecimalFormat obj = new DecimalFormat("0");
                                                out.print(obj.format(a));
                                            %></span>
                                    </div>
                                    <a href='javascript:getProduct(<%= p.getId()%>)'>   
                                        <button type="button" class="btn btn-primary show-quick-dialog" data-value="10" 
                                                style="
                                                width: 115.64px;
                                                height: 33px;
                                                vertical-align: middle;
                                                text-align: center;
                                                background: transparent; 
                                                margin-bottom: 10px;
                                                border: 1px solid black;
                                                " >
                                            <i class="fa fa-shopping-cart"></i>
                                            加入購物車
                                        </button>
                                    </a>
                                </td>

                                <%}%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="productDetail"></div>
        <%@include file="/WEB-INF/subviews/footer.jsp" %>
        <script src="OwlCarousel2-2.3.4/docs/assets/vendors/jquery.min.js" type="text/javascript"></script>
        <script src="OwlCarousel2-2.3.4/dist/owl.carousel.js" type="text/javascript"></script>
        <script>
            var owl = $('.owl-carousel');
            owl.owlCarousel({
//                item:1,
//                animateOut: 'slideOutDown',
//                animateIn: 'flipInX',
                loop: true,
                nav: true,
                margin: 0,
                itemsDesktop:[1920,1],
                autoplay: true,
                autoplayTimeout: 3500,
                autoplayHoverPause: false,
                animateOut: 'fadeOut',
                responsive: {
                    0: {
                        items: 1
                    }
                }
            });
//            owl.on('mousewheel', '.owl-stage', function (e) {
//                if (e.deltaY > 0) {
//                    owl.trigger('next.owl');
//                } else {
//                    owl.trigger('prev.owl');
//                }
//                e.preventDefault();
//            });
        </script>
    </body>
</html>
