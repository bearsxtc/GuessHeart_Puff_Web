<%-- 
    Document   : product_sort
    Created on : 2019/4/12, 下午 03:36:32
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
        <title>GH-Puff / 經典猜心</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            <%@include file="/WEB-INF/subviews/pd_function.jsp" %>
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
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>經典猜心：</h3>
                    <hr id="hr">
                </div>
                <div class="everyDay">
                    <table>  
                        <tr>
                            <%
                                ProductService service1 = new ProductService();
                                List<Product> list1 = service1.searchProductByName("猜心泡芙");
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
