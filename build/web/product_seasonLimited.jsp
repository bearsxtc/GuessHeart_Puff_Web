<%-- 
    Document   : product_seasonLimited
    Created on : 2019/4/12, 下午 06:00:58
    Author     : Admin
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>GH-Puff / 季節限定</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            function getPuffImage(target) {
                $(target).attr("src", "images/icon.jpg");
            }
            function getProduct(pid) {
                //同步GET請求
                location.href = " product.jsp?productId=" + pid;
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
        <style>

            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(0,0,0,1), rgba(0,0,0,0));
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                <%@include file="/WEB-INF/subviews/list_link_product.jsp" %>
                <div class="today_time">
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>季節限定：</h3>
                    <hr id="hr">
                </div>
                <div class="everyDay">
                    <table>  
                        <tr>
                            <%
                                ProductService service1 = new ProductService();
                                List<Product> list1 = service1.searchProductBySchedule("SeasonLimit");
                                for (int i = 0; i < list1.size(); i++) {
                                    Product p = list1.get(i);
                            %>
                            <%@include file="/WEB-INF/subviews/pd_td.jsp" %>

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
