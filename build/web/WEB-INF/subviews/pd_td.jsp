<%-- 
    Document   : pd_td
    Created on : 2019/4/15, 下午 05:28:08
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<td class="productItem" >
    <a href='javascript:getProduct(<%= p.getId()%>)'>                        
        <img src="<%=p.getPhotoUrl()%>" onerror="getPuffImage(this)">
        <h1 style="text-align: center; font-size: large"><%= p.getName()%>
            <% if (p.getTaste().length() > 0 && !p.getTaste().equals("null")) {%>
            /
            <small><%= p.getTaste()%></small>
            <%} else {%>
            <br>
            <%}%>
        </h1>
    </a>
    <div style="margin: 10px 0px 10px 0px;">

        <span style="color: #d50000; font-size: 14px; ">NT$</span> <span style="color: #d50000;font-size: medium">
            <%
                Double a = p.getUnitPrice();
                DecimalFormat obj = new DecimalFormat("0");
                out.print(obj.format(a));
            %>
        </span>
    </div>
    <a href='javascript:getProductAjax(<%= p.getId()%>)'>   
        <button type="button" class="btn btn-primary show-quick-dialog" data-value="10" 
                style="
                width: 115.64px;
                height: 33px;
                vertical-align: middle;
                text-align: center;
                background: transparent; 
                margin-bottom: 10px;
                border: 1px solid black;
                " >
            <i class="fa fa-shopping-cart"> <span style="font-family: '微軟正黑體';font-weight: 700">加入購物車</span></i>
           
        </button>
    </a>
</td>
