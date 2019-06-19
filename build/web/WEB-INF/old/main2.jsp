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
        <title>GHP - 2</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            ul{
                border-bottom: 5px dotted #fff;
            }
            .prod {
                display: inline-block;
                float: left;
                list-style-type: none; 
                vertical-align: middle;
                text-align: center;
            }
            .article{width: 960px;}
            .today_time{
                /*background: red;*/
                padding-top: 2em;
                padding-bottom: 2em;
            }
            .everyDay{

                /*background: yellow;*/
                display: table;
                width: 960px;
                float: left;
                margin: 0 auto;
                text-align: center;
                vertical-align: middle;
                border-bottom: 5px dotted #fff;
            }
            .weekDay{
                /*background: yellowgreen;*/
                display: table;
                width: 960px;
                float: left;
                margin: 0 auto;
                text-align: center;
                vertical-align: middle;
                border-right: 1px dotted #fff;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div class="article">
            <div class="today_time">
                <h3>天天猜心：</h3>
            </div>
            <div class="everyDay">
                <%
                    ProductService service1 = new ProductService();
                    List<Product> list1 = service1.searchProductBySchedule("Eve");
                    for (int i = 0; i < list1.size(); i++) {
                        Product pe = list1.get(i);

                %>
                <ul class="prod">
                    <li><%= pe.getName()%></li>
                        <%if (pe.getTaste() != null) {%>
                    <li><%= pe.getTaste()%></li>
                        <%} else {%>
                    <li></li>
                        <%}%>
                    <li><img  style="width:150px;display:block;margin:auto; " src="<%= pe.getPhotoUrl()%>"></li>
                </ul>
                <%}%>
            </div>
            <div class="today_special">
                <h3><%= LocalDate.now().getDayOfWeek().toString() %>猜心特選：</h3>
            </div>
            <div class="weekDay">

                <%
                    String wdate = LocalDate.now().getDayOfWeek().toString();
                    ProductService service = new ProductService();
                    List<Product> list = service.searchProductBySchedule(wdate);
                    for (int i = 0; i < list.size(); i++) {
                        Product p = list.get(i);
                %>

                <ul class="prod">
                    <li><%= p.getName()%></li>
                    <li><%= p.getTaste()%></li>
                    <li><img  style="width:150px;display:block;margin:auto; " src="<%= p.getPhotoUrl()%>"></li>
                </ul>
                <%}%>

            </div>

        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
