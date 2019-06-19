<%-- 
    Document   : main2
    Created on : 2019/4/2, 上午 10:52:56
    Author     : Admin
--%>

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
        <title>GH-Puff</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>



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
        </style>
        <script>
            function getPuffImage(target) {
                $(target).attr("src", "images/icon.jpg");
            }
            function getProduct(pid) {
                //同步GET請求
//                location.href = "product.jsp?productId=" + pid;

                //非同步GET請求
                $.ajax({
                    url: "product.jsp?productId=" + pid
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
                <div class="today_time">
                    <h3>天天猜心：</h3>
                </div>
                <div class="everyDay">
                    <table>  
                        <tr>
                            <%
                                ProductService service1 = new ProductService();
                                List<Product> list1 = service1.searchProductBySchedule("Eve");
                                for (int i = 0; i < list1.size(); i++) {
                                    Product pe = list1.get(i);

                            %>


                            <td class="productItem" >
                                <a href='javascript:getProduct(<%= pe.getId()%>)'>                        
                                    <img style="width:100px;" src="<%= pe.getPhotoUrl()%>" onerror="getPuffImage(this)">
                                    <h4 style="text-align: center"><%= pe.getName()%></h4>
                                </a>
                                <div>
                                    <% if (pe.getTaste().length() > 0 && !pe.getTaste().equals("null")) {%>
                                    <p>口味：<%= pe.getTaste()%></p>
                                    <%} else {%>
                                    <br>
                                    <%}%>
                                </div>
                                <div>
                                    <p>價錢：<%= pe.getUnitPrice()%>元</p>
                                </div>
                            </td>

                            <%}%>
                        </tr>
                    </table>
                </div>
                <div class="today_special">
                    <h3><%= LocalDate.now().getDayOfWeek().toString()%>猜心特選：</h3>
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
                                    <img style="width:100px" src="<%= p.getPhotoUrl()%>" onerror="getPuffImage(this)">
                                    <h4 style="text-align: center"><%= p.getName()%></h4>
                                </a>
                                <div>
                                    <% if (p.getTaste().length() > 0 && !p.getTaste().equals("null")) {%>
                                    <p>口味：<%= p.getTaste()%></p>
                                    <%} else {%>
                                    <br>
                                    <%}%>
                                </div>
                                <div>
                                    <p>價錢：<%= p.getUnitPrice()%>元</p>
                                </div>
                            </td>
                            <%}%>
                        </tr>
                    </table>
                </div>
                <div id="productDetail"></div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
