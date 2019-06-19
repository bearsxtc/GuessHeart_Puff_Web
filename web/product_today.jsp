<%-- 
    Document   : main2
    Created on : 2019/4/2, 上午 10:52:56
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>GH-Puff / 今日猜心</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>

            #article{
                height: 700px;
            }

            .prod {
                /*display:inline-block;*/
                width:150px;
                padding:10px 5px;
                height:250px;
                font-size: 8px;
                vertical-align: middle;
                text-align: center;
            }

            .today_time{
                /*background: red;*/
                padding-top: 2em;
                padding-bottom: 2em;
            }
            .everyDay{

                /*background: yellow;*/
                /*display:flex;*/
                width: 100%;
                /*flex-direction: row;*/
                margin: 2px auto;
                text-align: center;
                vertical-align: middle;
            }
            .weekDay{
                /*background: yellowgreen;*/
                /*display:flex;*/
                width: 100%;
                /*flex-direction: row;*/
                margin: 2px auto;
                text-align: center;
                vertical-align: middle;

            }
            .hr{
                margin: 10px 0px !important;
                border: 0;
                height: 1px;
                background-image: linear-gradient(to right, rgba(0,0,0,50), rgba(0,0,0,0.10), rgba(0,0,0,0));
            }
        </style>
        <script>
            function getPuffImage(target) {
                $(target).attr("src", "../images/icon.jpg");
            }
            function getProduct(pid) {
                //同步GET請求
                location.href = "product.jsp?productId=" + pid;

            }

            function getProductAjax(pid) {
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
    </head>

    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article"> 
            <div id="main">
                <%@include file="/WEB-INF/subviews/list_link_product.jsp" %>
                <div class="today_special">
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i><%= LocalDate.now().getDayOfWeek().toString()%>猜心特選：</h3>
                    <hr class="hr">
                </div>
                <div class="weekDay">
                    <table>
                        <tr>
                            <%
                                String wdate = LocalDate.now().getDayOfWeek().toString();
                                ProductService service = new ProductService();
                                List<Product> list = service.searchProductBySchedule(wdate);
                                for (int i = 0; i < list.size(); i++) {
                                    Product p = list.get(i);
                            %>


                            <td class="prod">
                                <a href='javascript:getProduct(<%= p.getId()%>)'>                        
                                    <img  src="<%=p.getPhotoUrl()%>" onerror="getPuffImage(this)">
                                    <h4 style="text-align: center"><%= p.getName()%></h4>
                                </a>
                                <div>
                                    <% if (p.getTaste().length() > 0 && !p.getTaste().equals("null")) {%>
                                    <p>口味：<%= p.getTaste()%></p>
                                    <%} else {%>
                                    <br>
                                    <%}%>
                                </div>

                                <div style="margin: 10px 0px 10px 0px;">

                                    <span style="color: #d50000; font-size: 14px; ">NT$</span> <span style="color: #d50000;font-size: medium">
                                        <%
                                            Double a = p.getUnitPrice();
                                            DecimalFormat obj = new DecimalFormat("0");
                                            out.print(obj.format(a));
                                        %>
                                    </span>
                                </div>
                                <a href='javascript:getProductAjax(<%= p.getId()%>)'>   
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
        <div id="productDetail"></div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
