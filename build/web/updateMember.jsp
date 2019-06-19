<%-- 
    Document   : updateMember
    Created on : 2019/3/30, 下午 01:31:58
    Author     : Admin
--%>


<%@page import="uuu.ghp.model.CustomerService"%>
<%@page import="uuu.ghp.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>會員修改</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            
            #main{
                padding-top: 50px;
                height: 500px;
            }
            .member_list{
                display: relative;
                width: 28%;
                float: left;
            }
            .update{
                
                width: 72%;
                float: left;
            }
            footer{
                clear: both;
            }
        </style>
    </head>
    <%

        Customer member = (Customer) session.getAttribute("member");
    %>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                <div class="member_list">
                    <ul class="member_list_son">
                        <li><a href="<%= request.getContextPath()%>/member/orders_history.jsp">我的訂單</a></li>
                        <li><a href="<%= request.getContextPath()%>/updateMember.jsp">我的帳戶</a></li>
                    </ul>
                </div>
                <div class="update">
                    <form action='update.do' method="POST" >
                        <%
                            List<String> errors = (List<String>) request.getAttribute("errors");
                            if (errors != null && errors.size() > 0) {
                        %>
                        <%= errors%>
                        <%}%>

                        <p>
                            <label>帳號: </label>
                            <input name='userid' type='text' required disabled value="<%= member.getEmail()%>">
                        </p>
                        <p>
                            <label>姓名: </label>
                            <input name='name' type='text' required value="${empty param.name ? sessionScope.member.name : param.name}">
                        </p>
                        <p>
                            <label>輸入新密碼: </label>
                            <input name='password1' type='password' placeholder='請輸入密碼(6~20個字)'
                                   minlength="6" maxlength="20" required><br>

                        </p>

                        <p>
                            <label>Email: </label>
                            <input name='email' type='email' required value="${empty param.email ? sessionScope.member.email : param.email}>">
                        </p>              
                        <p>
                            <label>生日:</label>
                            <input name='birthday' type='date' disabled required value="${empty param.birthday ? sessionScope.member.birthday : param.birthday}">
                        </p>                
                        <p>
                            <label>電話:</label>
                            <input name='phone' type='text' required value="${empty param.phone ? sessionScope.member.phone : param.phone}">
                        </p>
                        <p>
                            <label>地址:</label>
                            <input name='address' type='text'value="${empty param.address ? sessionScope.member.address : param.address}">
                        </p>           
                        <p>
                            <label>再次輸入密碼，以確認修改:</label>
                            <input name='password2' type='password' placeholder='請再確認密碼(6~20個字)'
                                   minlength="6" maxlength="20" required>
                        </p>
                        <input type='submit' value="確定修改">
                    </form>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
