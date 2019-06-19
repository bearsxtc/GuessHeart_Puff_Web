<%-- 
    Document   : global
    Created on : 2019/3/27, 上午 11:28:18
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/style/ghp.css">
<link rel="shortcut icon" href="favicon.ico" >
<script src="https://code.jquery.com/jquery-3.0.0.js"
        integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo="
crossorigin="anonymous"></script>               
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" 
      integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
<link href="<%=request.getContextPath()%>/fancybox/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
<script src="<%=request.getContextPath()%>/fancybox/jquery.fancybox.js"></script>



<script>
    function login() {

        var xhr = $.ajax({
            url: '<%=request.getContextPath()%>/login.jsp',
            method: 'GET'
        }).done(loginDoneHandler);
    }

    function loginDoneHandler(result, status, xhr) {
        console.log("Login Done:" + result);
        $("#loginBox").html(result);
        $.fancybox.open({
            src: "#loginBox"
        });
    }

//    $(document).ready(init);
//    function init() {
//        $("#item4").mouseenter(mouseEnterHandler);
//        $(document).click(mouseClick);
//    }
//    function mouseEnterHandler() {
//        $("#item4").width("100px");
//    }
//    function mouseClick(){
//        $("#item4").width("14px");
//    }

</script>
<!-- global.jsp end -->