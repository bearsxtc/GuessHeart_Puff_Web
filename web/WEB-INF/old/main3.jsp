<%-- 
    Document   : index
    Created on : 2019/3/25, 下午 07:14:49
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <title>GH-Puff</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
    </head>
    <style>
        .image{
            /*width: 80%;*/
            min-width: 500px;
            max-width: 800px;
        }

        .hot_topic {
            display:table-cell;
            vertical-align:middle;
            text-align:center;
        }
    </style>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp" />
        <main class="article">
            <h2 class="hidden">HOT TOPIC</h2>
            <div class="box">
                <div class="hot_topic">
                    <img class="image" src="images/1.jpg">
                    <img class="image" src="images/2.jpg">
                    <img class="image" src="images/3.jpg">
                </div>
            </div>
            <h2>NEWS</h2>
            <div class="news">

            </div>
            <h2 class="hidden">ARTICLES</h2>
            <div class="articles">

            </div>
        </main>
        <%@include file="/WEB-INF/subviews/footer.jsp" %>
    </body>
</html>
    