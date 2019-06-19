<%-- 
    Document   : register
    Created on : 2019/3/30, 上午 10:06:22
    Author     : Admin
--%>

<%@page import="uuu.ghp.entity.Customer"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">     
        <title>會員註冊</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <script>
            function refreshCaptcha() {
                $("#captchaImage").attr("src", "images/register_captcha.jpeg?get=" + new Date());
            }
            function myFunction() {
                var x = document.getElementById("snackbar");
                x.className = "show";
                setTimeout(function () {
                    x.className = x.className.replace("show", "");
                }, 3000);
            }
        </script>
        <style>
            #article{

                padding-top: 20px;
                padding-bottom: 2em;
                height: 600px;
            }

            input::-webkit-input-placeholder {
                color: #aab2bd;
                font-size: 12px;

            }
            .rge{
                border:20px solid transparent;
            }
            .regis_bar{
                width: 40%;
                background-color: white;
                border: 1px solid #aaa;
                padding: 5px 8px;
                border-radius: 7px;
                font-weight: 200;
                font-size: 20px;
                margin: 0 auto;
                margin-bottom: 10px;

            }
            .regis{
                width: 800px;
                margin: 0 auto;
            }
            .regis_{
                padding-top: 10px;
                margin: 0 auto;
            }
            .regis_BTN{
                width: 335px;
                margin: 0 auto;
            }
            h4{
                text-align: center;
            }
            .captcha_name{
                font-weight: 500;
                font-size: 14px;
            }
            #snackbar {
                visibility: hidden;
                min-width: 250px;
                margin-left: -125px;
                background-color: #333;
                color: #fff;
                text-align: center;
                border-radius: 2px;
                padding: 16px;
                position: fixed;
                z-index: 1;
                left: 50%;
                top: 30px;
                font-size: 17px;
            }
            #snackbar.show {
                visibility: visible;
                -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
                animation: fadein 0.5s, fadeout 0.5s 2.5s;
            }

            @-webkit-keyframes fadein {
                from {top: 0; opacity: 0;} 
                to {top: 30px; opacity: 1;}
            }

            @keyframes fadein {
                from {top: 0; opacity: 0;}
                to {top: 30px; opacity: 1;}
            }

            @-webkit-keyframes fadeout {
                from {top: 30px; opacity: 1;} 
                to {top: 0; opacity: 0;}
            }

            @keyframes fadeout {
                from {top: 30px; opacity: 1;}
                to {top: 0; opacity: 0;}
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                <img src="images/register.png" style="float: left; width: 40%; margin-right: -171px; 
                     margin-left: 130px; opacity: 0.55">
                <div class="register_main" style="float: left;">
                    <div class="regis_" >
                        <h4 style="font-size: larger; margin-bottom: 13px;" >會員註冊</h4>
                    </div>
                    <form name="myForm" action='register.do' method="POST" class="regis" >
                        <%
                            List<String> errors = (List<String>) request.getAttribute("errors");
                            if (errors != null && errors.size() > 0) {
                                out.println(errors);
                            }
                        %>
                        <%
                            if (errors != null && errors.size() > 0) {
                        %>
                        <%= errors%>
                        <%}%>
                        <div class="regis_bar">
                            <span class="far fa-envelope" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></span>
                            <input name='email' type='email' required placeholder='請輸入Email' style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("email")%>">
                        </div>          
                        <div class="regis_bar">
                            <sapn class="fas fa-user-edit"></sapn>
                            <input name='name' type='text' required placeholder='請輸入姓名' style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("name")%>">
                        </div>
                        <div class="regis_bar">
                            <sapn class="fas fa-lock" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></sapn>
                            <input name='password1' type='password' placeholder='請輸入密碼(6-20個字)' style="border-style: none; vertical-align: middle"
                                   minlength="6" maxlength="20" required>
                        </div>
                        <div class="regis_bar">
                            <sapn class="fas fa-lock" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></sapn>
                            <input name='password2' type='password' placeholder='請再確認密碼(6-20個字)' style="border-style: none; vertical-align: middle"
                                   minlength="6" maxlength="20" required>
                        </div>
                        <div class="regis_bar">
                            <sapn class="fas fa-venus-mars" style=" vertical-align: middle; padding-right: 2px;"></sapn>
                            <input type='radio' name='gender' id='male' value="<%= Customer.MALE%>" required style="border-style: none; vertical-align: middle"
                                   <%= String.valueOf(Customer.MALE).equals(request.getParameter("gender")) ? "checked" : ""%>><label for='male'><span style="font-size: 14px">男</span></label>
                            <input type='radio' name='gender' id='female' value="<%= Customer.FEMALE%>" required style="border-style: none; vertical-align: middle"
                                   <%= String.valueOf(Customer.FEMALE).equals(request.getParameter("gender")) ? "checked" : ""%>><label for='female'><span style="font-size: 14px">女</span></label>
                        </div>

                        <div class="regis_bar">
                            <sapn class="fas fa-birthday-cake" style=" vertical-align: middle; padding-right: 2px;"></sapn>
                            <input name='birthday' type='date' required  style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("birthday")%>">
                        </div>                
                        <div class="regis_bar">
                            <sapn class="fas fa-phone" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;" ></sapn>
                            <input name='phone' type='text' required placeholder='請輸入連絡電話' style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("phone")%>">
                        </div>
                        <div class="regis_bar">
                            <sapn class="fas fa-location-arrow" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></sapn>
                            <input name='address' type='text' placeholder='請輸入聯絡地址' style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("address")%>">
                        </div>                


                        <div class="regis_bar">                    
                            <img src="images/icon.png" style="width: 24px;  vertical-align: middle; padding-right: 2px;">                                            
                            <input type="text" placeholder="請依右圖輸入驗證碼" name="captcha" required style="border-style: none; vertical-align: middle"
                                   value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("captcha")%>">                    
                            <a href="javascript:refreshCaptcha()" title="點選圖片即可更新">
                                <img id="captchaImage" src="images/register_captcha.jpeg" style="vertical-align: middle">
                            </a>                    
                        </div>
                        <div class="regis_BTN" style="position: relative; ">
                            <button type="submit" onsubmit="myFunction" ons style="background:url('images/register_BTN.png');width: 329px; height: 57px; 
                                    padding: 5px; margin-top: 10px; opacity: 0.75; margin-left: 7px; vertical-align: middle ; border-style: none; border-radius: 5px; font-family:'微軟正黑體';  ">

                            </button>
                        </div>
                    </form>                         
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
        <div id="snackbar">註冊成功</div>
    </body>
</html>
