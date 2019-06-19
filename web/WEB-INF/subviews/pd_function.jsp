<%-- 
    Document   : pd_function
    Created on : 2019/4/15, 下午 05:30:39
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
function getPuffImage(target) {
$(target).attr("src", "images/icon.jpg");
}
function getProduct(pid) {
//同步GET請求
location.href = "product.jsp?productId=" + pid;
}
function getProductAjax(pid) {
//非同步GET請求
$.ajax({
url: "product_ajax.jsp?productId=" + pid
}).done(getProductDoneHandler);
}

function getProductDoneHandler(result, status, xhr) {
console.log(result);
$("#productDetail").html(result);
$.fancybox.open({
src: "#productDetail"
});
}

function addCart() {
//同步的請求
//        $("#cartForm").submit();        

//非同步的請求
var valid = validate();
console.log(valid);
if(valid){
var url = $("#cartForm").attr("action");
var method = $("#cartForm").attr("method");
console.log(url, method);
$.ajax({
url: url,
method: method,
data: $("#cartForm").serialize()
}).done(addCartDoneHandler);
}
}

function addCartDoneHandler(result, status, xhr) {
console.log(result);
$("#cartTotalQuantity").html(result);
var x = document.getElementById("snackbar");
x.className = "show";
setTimeout(function () {
x.className = x.className.replace("show", "");
}, 1500);
}