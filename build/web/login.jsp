<%-- 
    Document   : login
    Created on : 2019/3/29, 下午 07:20:01
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
        <title>會員登入</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <style>
            #article{
                padding-top: 10px;
                padding-bottom: 5em;
                height: 600px;
            }



            .login_bar{
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
            .login{
                width: 800px;
                margin: 0 auto;
            }
            .login_{
                padding-top: 10px;
                margin: 0 auto;
            }
            h4{
                text-align: center;
            }
            .login_BTN{
                width: 335px;
                margin: 0 auto;
            }
            .captcha_name{
                font-weight: 500;
                font-size: 14px;
            }

            input::-webkit-input-placeholder {
                color: #aab2bd;
                font-size: 12px;
            }

        </style>
        <script>
            function refreshCaptcha() {

                $("#captchaImage").attr("src", "images/captcha.jpeg?get=" + new Date());
            }
        </script>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <%
            Cookie[] cookies = request.getCookies();
            String email = "";
            String auto = "";
            if (cookies != null && cookies.length > 0) {
                for (int i = 0; i < cookies.length; i++) {
                    Cookie cookie = cookies[i];
                    if (cookie.getName().equals("email")) {
                        email = cookie.getValue();
                    } else if (cookie.getName().equals("auto")) {
                        auto = cookie.getValue();
                    }
                }
            }
        %>
        <div id="article">
            <div id="main">
                <img src="images/login.png" style="float: left; width: 40%; margin-right: -171px; 
                     margin-left: 130px; opacity: 0.55">
                <div class="login_main" style="float: left;">
                    <form class="login" method="POST" action="login.do">
                        <%
                            List<String> errors = (List<String>) request.getAttribute("errors");
                            if (errors != null && errors.size() > 0) {
                                out.println(errors);
                            }
                        %>
                        <div class="login_">
                            <h4 style="font-size: larger; margin-bottom: 13px;">會員登入</h4>
                        </div>
                        <div class="login_bar"> 
                            <span class="far fa-envelope" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></span>
                            <span>
                                <label for="uid"></label>
                            </span>
                            <input type="text" placeholder="請輸入註冊信箱" id="uid" name="email" style="border-style: none; vertical-align: middle" 
                                   required value='<%= request.getMethod().equals("GET") ? email : request.getParameter("email")%>'>
                        </div>


                        <div class="login_bar">
                            <span class="fas fa-key" style=" margin-right: 5px; vertical-align: middle; padding-right: 2px;"></span>
                            <span>
                                <input type="password" placeholder="請輸入會員密碼" name="pwd" style="border-style: none" required>
                            </span>
                        </div>

                        <div class="login_bar">                    
                            <img src="images/icon.png" style="width: 24px; padding-top: 0px;  vertical-align: middle; padding-right: 2px;">                                      
                            <input type="text" placeholder="請輸入右圖中驗證碼" name="captcha" autocomplete="off" 
                                   style="border-style: none; vertical-align: middle"
                                   value='<%= request.getMethod().equals("GET") ? "" : request.getParameter("captcha")%>'
                                   required>   

                            <a  href="javascript:refreshCaptcha()" title="點選圖片即可更新">
                                <img  id="captchaImage" src="images/captcha.jpeg" style="vertical-align: middle">
                            </a>
                        </div>
                        <div class="login_BTN">
                            <div class="login_"  >
                                <input  type="checkbox" style="vertical-align: middle; margin-bottom: 5px; " name="auto" value='ON'   <%= auto%>><span style="font-size:12px; vertical-align: middle">記住我的帳號</span>
                            </div>
                            <div class="login_" style="position: relative; float: left">
                                <button type="submit" style="background:url('images/login_BTN.png');width: 329px; height: 57px; 
                                        padding: 5px; margin-top: 10px; opacity: 0.75; margin-left: 7px; vertical-align: middle ; border-style: none; border-radius: 5px; font-family:'微軟正黑體';  "></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
