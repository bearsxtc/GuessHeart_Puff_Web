<%-- 
    Document   : ${name}
    Created on : ${date}, ${time}
    Author     : ${user}
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
${doctype}
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="${encoding}">     
        <title>JSP Page</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                
            </div>
        </div>
         <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
