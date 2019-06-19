<%-- 
    Document   : sb_body
    Created on : 2019/3/30, 下午 02:23:00
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--必須放在body內-->
<button onclick="snackbar()">Show Snackbar</button>

<div id="snackbar">修改成功！</div>

<script>
function snackbar() {
  var x = document.getElementById("snackbar");
  x.className = "show";
  setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
</script>