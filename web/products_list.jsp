<%-- 
    Document   : products_list
    Created on : 2019/3/11, ?? 12:32:23
    Author     : Admin
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>        
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>產品清單</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
          <%@include file="/WEB-INF/subviews/pd_function.jsp"  %>
        </script>
        <style>
            #main{
                height: auto;
            }
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(0,0,0,1), rgba(0,0,0,0));
            }
        </style>

    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <!--<div id="article">-->  
        <div id="article"> 
            <div id="main">
                <%@include  file="/WEB-INF/subviews/list_link_product.jsp" %>
                <%
                    String search = request.getParameter("search");
                    ProductService service = new ProductService();
                    List<Product> list = null;
                    if (search != null && search.length() > 0) {
                        list = service.searchProductsByDescriptionAndTaste(search);
                    } else {
                        list = service.searchAllProducts();
                    }
                %>
                <div class="today_time">
                    <% if (search != null && search.length() > 0) {%>
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>這是您搜尋的：<span style="color: red"><%= search%></span></h3>
                    <%} else {%>
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>猜心全品項：</h3>
                    <%}%>
                    <hr id="hr">
                </div>
                <div class="product_list">


                    <% if (list != null && list.size() > 0) { %>
                    <table>
                        <tr>
                            <% for (int i = 0; i < list.size(); i++) {
                                    Product p = list.get(i);
                            %>
                            <%@include file="/WEB-INF/subviews/pd_td.jsp" %>
                            <% } %>
                        </tr>      
                        <%} else {%>
                        <p>查無符合 <span style="color:blue"><%= search%></span> 的資料</p>
                        <%}%>
                    </table>
                </div>
                <div id="productDetail"></div>
            </div>  
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>