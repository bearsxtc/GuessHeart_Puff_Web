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
            #hr{
                margin: 10px 0px !important;
                border: 0;
                height: 3px;
                background-image: linear-gradient(to right, rgba(0,0,0,75), rgba(0,0,0,1), rgba(0,0,0,0));
            }
            #main{
                padding-top: 50px;
                height: 500px;
            }
            .member_list{
                display: relative;
                width: 28%;
                float: left;
            }
            .update_{
                padding-top: 10px;
                margin: 0 auto;
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
                <div class="product_sort" style="margin-right: 125px; margin-left: 25px; margin-top: 20px;">

                    <ul class="product_sort_son">
                        <img src="../images/fruit.png" style="width: 14px;">
                        <span style="text-align: center; vertical-align: middle">會員中心</span>
                        <hr id="hr">
                        <li class="side_menu">
                            <img src="../images/icon.png" style="width: 14px;">
                            <a href="<%= request.getContextPath()%>/member/orders_history.jsp">
                                <span style="width: 87px">
                                    我的訂單 
                                </span>
                            </a>
                        </li>
                        <li class="side_menu">
                            <img src="../images/icon.png" style="width: 14px;">
                            <a href="<%= request.getContextPath()%>/member/updateMember.jsp">
                                <span style="width: 87px">
                                    我的帳戶
                                </span>
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="update" style="margin-top:-7px;width: 50%;float: left">

                    <form action='update.do' method="POST" >
                        <%
                            List<String> errors = (List<String>) request.getAttribute("errors");
                            if (errors != null && errors.size() > 0) {
                        %>
                        <%= errors%>
                        <%}%>
                        <div class="update_">
                            <h4 style="font-size: larger; margin-bottom: 13px;">修改會員資料</h4>
                            <hr id="hr">
                        </div>
                        <div
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
                        <hr id="hr">
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
