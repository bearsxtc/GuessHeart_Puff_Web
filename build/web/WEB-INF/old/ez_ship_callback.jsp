<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<%
    //================================ 接收購物網站所需的各項參數 ==================================    
    String processID = request.getParameter("processID") == null ? "" : request.getParameter("processID");  // 訂單編號
    String stCate = request.getParameter("stCate") == null ? "" : request.getParameter("stCate");  // 超商別
    String stCode = request.getParameter("stCode") == null ? "" : request.getParameter("stCode");  // 門市代碼
    String stName = request.getParameter("stName") == null ? "" : request.getParameter("stName");  // 門市名稱
    String stAddr = request.getParameter("stAddr") == null ? "" : request.getParameter("stAddr");  // 門市地址
    String stTel = request.getParameter("stTel") == null ? "" : request.getParameter("stTel");    // 門市電話
    String webPara = request.getParameter("webPara") == null ? "" : request.getParameter("webPara");  // 網站所需額外判別資料。ezShip 將原值回傳，供網站判別使用。
    String params[] = webPara.split("&");
    System.out.println(Arrays.toString(params));
    Map<String, String> paramsMap = new HashMap<>();
    if (params != null && params.length > 0) {
        for (String data : params) {
            int index = data.indexOf('=');
            String name = data.substring(0, index);
            String value = java.net.URLDecoder.decode(data.substring(index + 1), "UTF-8");
            paramsMap.put(name, value);
        }
    }
    System.out.println("paramsMap = " + paramsMap);
%>
<%-- 以下程式是將ezship傳回的資料先帶到暫時form中再submit給check_out. --%>
<form action="check_out.jsp" method="post" id="myForm">
    <input name="processID" type="text" value="<%=processID%>">
    <input name="stCate" type="text" value="<%=stCate%>">
    <input name="stCode" type="text" value="<%=stCode%>">    
    <input name="stName" type="text" value="<%=stName%>">
    <input name="stAddr" type="text" value="<%=stAddr%>">
    <input name="stTel" type="text" value="<%=stTel%>">
    <input name="address" type="text" value="<%=stCode%>,<%=stName%>,<%=stAddr%>">
    <% for (String name : paramsMap.keySet()) {%>
    <input name="<%=name%>" type="hidden" value="<%= paramsMap.get(name)%>">
    <%}%>
    <script>
        document.getElementById("myForm").submit();
    </script>    
</form>

