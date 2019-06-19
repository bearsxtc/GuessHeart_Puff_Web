<%-- 
    Document   : product_cone
    Created on : 2019/4/12, 下午 06:06:24
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
        <title>GH-Puff / 獨家甜筒泡芙</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            <%@include file="/WEB-INF/subviews/pd_function.jsp"  %>
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
                    <h3><i style="margin-right: 5px;" class="fas fa-stroopwafel"></i>焦糖布蕾泡芙：</h3>
                    <hr id="hr">
                </div>
                <div class="everyDay">
                    <table>  
                        <tr>
                            <%
                                ProductService service1 = new ProductService();
                                List<Product> list1 = service1.searchProductByName("焦糖布蕾泡芙");
                                for (int i = 0; i < list1.size(); i++) {
                                    Product p = list1.get(i);
                            %>
                            <td class="productItem" >
                                <a href='javascript:getProduct(<%= p.getId()%>)'>                        
                                    <img src="<%=p.getPhotoUrl()%>" onerror="getPuffImage(this)">
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
                                        <i class="fa fa-shopping-cart">
                                            <span style="font-family: '微軟正黑體'">加入購物車</span>
                                        </i>
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
