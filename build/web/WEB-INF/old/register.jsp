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
        </script>
        <style>
            #article{
                padding-top: 10px;
                padding-bottom: 11em;
            }
            .rge{
                border:20px solid transparent;
            }
            #main{

                border-image: url("<%= request.getContextPath()%>/images/tree.png")  30 30 round;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/subviews/header.jsp"/>
        <div id="article">
            <div id="main">
                <form name="myForm" action='register.do' method="POST" class="rge" >
                    <%
                        List<String> errors = (List<String>) request.getAttribute("errors");
                        if (errors != null && errors.size() > 0) {
                    %>
                    <%= errors%>
                    <%}%>
                    <p>
                        <label>帳號:</label>
                        <input name='userid' type='text' required ng-model="userid" pattern="[A-Z][12]\d{8}" 
                               value="${param.userid}" placeholder='請輸入身分證號'>
                    </p>
                    <p>
                        <label>姓名:</label>
                        <input name='name' type='text' required placeholder='請輸入姓名'
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("name")%>">
                    </p>
                    <p>
                        <label>密碼:</label>
                        <input name='password1' type='password' placeholder='請輸入密碼(6~20個字)'
                               minlength="6" maxlength="20" required><br>
                        <label>確認:</label>
                        <input name='password2' type='password' placeholder='請再確認密碼(6~20個字)'
                               minlength="6" maxlength="20" required>
                    </p>
                    <p>
                        <label>性別:</label>
                        <input type='radio' name='gender' id='male' value="<%= Customer.MALE%>" required 
                               <%= String.valueOf(Customer.MALE).equals(request.getParameter("gender")) ? "checked" : ""%>><label for='male'>男</label>
                        <input type='radio' name='gender' id='female' value="<%= Customer.FEMALE%>" required
                               <%= String.valueOf(Customer.FEMALE).equals(request.getParameter("gender")) ? "checked" : ""%>><label for='female'>女</label>
                    </p>
                    <p>
                        <label>Email:</label>
                        <input name='email' type='email' required placeholder='請輸入Email'
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("email")%>">
                    </p>              
                    <p>
                        <label>生日:</label>
                        <input name='birthday' type='date' required 
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("birthday")%>">
                    </p>                
                    <p>
                        <label>電話:</label>
                        <input name='phone' type='text' required placeholder='請輸入連絡電話' 
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("phone")%>">
                    </p>
                    <p>
                        <label>地址:</label>
                        <input name='address' type='text' placeholder='請輸入聯絡地址' 
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("address")%>">
                    </p>                


                    <p>                    
                        <label>驗證碼:</label>                                        
                        <input type="text" placeholder="請依右圖輸入驗證碼" name="captcha" required 
                               value="<%= request.getMethod().equals("GET") ? "" : request.getParameter("captcha")%>">                    
                        <a href="javascript:refreshCaptcha()" title="點選圖片即可更新">
                            <img id="captchaImage" src="images/register_captcha.jpeg" style="vertical-align: middle">
                        </a>                    
                    </p>
                    <input type='submit' value="確定">
                </form>            
            </div>
        </div>
        <%@include file="/WEB-INF/subviews/footer.jsp"  %>
    </body>
</html>
