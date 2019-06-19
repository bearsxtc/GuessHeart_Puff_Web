<%-- 
    Document   : product
    Created on : 2019/3/27, 上午 11:04:03
    Author     : Admin
--%>


<%@page import="java.text.DecimalFormat"%>
<%@page import="uuu.ghp.model.ProductService"%>
<%@page import="uuu.ghp.entity.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8"> 
        <title>產品明細</title>
        <%@include file="/WEB-INF/subviews/global.jsp"  %>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            function getStock(pid) {
                var schedule = $("#schedule").val();
                if (schedule == "Eve") {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/get_product_stock.jsp?productId=' + pid
                    }).done(getStockDoneHandler);
                }
            }

            function getStockDoneHandler(result) {
                var stock = parseInt(result);
                if (stock > 0) {
                    $("#quantity").attr("min", 1);
                    $("#quantity").attr("max", stock);
                    $("#quantity").val(1);
                } else {
                    $("#quantity").attr("min", 0);
                    $("#quantity").attr("max", 0);
                    $("#quantity").val("");
                    $("#quantity").attr("placeholder", "已無庫存!");
                }
            }
            function addCart() {
                var valid = validate();
                console.log(valid);
                if (valid) {
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
            }
            function validate() {
                var min = parseInt($("#quantity").attr("min"));
                var max = parseInt($("#quantity").attr("max"));
                var value = parseInt($("#quantity").val());
                console.log(min, max, value);
                var message = "請";
                var isCorrect = true;
                if (isNaN(value) || value < min || value > max) {
                    isCorrect = isCorrect && (value >= min && value <= max);
                    if (message !== "請")
                        message += "和";
                    message += "輸入正確的數量";
                }
                if (!isCorrect) {
                    alert(message);
                }
                return (isCorrect);
            }

            $(function () {
                var tabs = $("#tabs").tabs();
                tabs.find(".ui-tabs-nav").sortable({
                    axis: "x",
                    stop: function () {
                        tabs.tabs("refresh");
                    }
                });
            });
        </script>
        <style>

            .item_img{
                width:360px;
                min-width:500px;
            }
            .pd{
                height: 420px;
                margin: 30px 0px 100px 277px;
            }
            .cart{
                margin-right: -170px;
            }
            #tabs{
                width: 600px;
                margin: 0 auto;
            }
            #tabs ul{
                background: white;
                border-style: none;
            }
            #tabs ul li{
                width: 30%;
                border-style: none;
            }
            #tabs ul li a{
                font-family: 微軟正黑體;
                font-size: 15px;
                font-weight: 700;

                color: #303030;
                text-align: center;
                margin-right: 2px;
                line-height: 1.42857143;
                border: 1px solid transparent;
                border-radius: 4px 4px 0 0;

            }
            .ui-state-active, .ui-widget-content .ui-state-active, .ui-widget-header .ui-state-active, a.ui-button:active, .ui-button:active, .ui-button.ui-state-active:hover{
                border: 1px solid whitesmoke;
                border-bottom: transparent;
                background: white; 
                font-weight: normal; 
                color: #ffffff; 
            }
            p{
                font-size: 14px;
                line-height: 1.42857143;
                color: #333;
                margin: 10px;
            }
            .ui-tabs .ui-tabs-nav .ui-tabs-anchor{
                float: none;
                text-align: center;
                vertical-align: middle;
            }
        </style>
    </head>
    <%
        String productId = request.getParameter("productId");

        ProductService service = new ProductService();
        Product p = null;
        if (productId != null) {
            p = service.searchProductById(productId);
        }
    %>
    <body>
        <%@ include file="/WEB-INF/subviews/header.jsp" %>
        <div id="article"> 
            <div id="main">
                <div class="pd">
                    <div class="productDetail" style="width: 600px; float: left;">
                        <%if (p != null) {%>
                        <div class="item_img" style="float: left">
                            <img style="width: 483px;" src="<%= p.getPhotoUrl()%>">
                        </div>
                        <div class="cart">
                            <h3><%= p.getName()%></h3>
                            <% if (p.getTaste() != null && p.getTaste().length() > 0) {%>
                            <h4>口味 : <%= p.getTaste()%></h4>
                            <%} else {%>
                            <br>
                            <%}%>
                            <p>價格 : <%
                                             Double a = p.getUnitPrice();
                                             DecimalFormat obj = new DecimalFormat();
                                             out.print(obj.format(a));
                                      %> 
                                元</p>
                            <form id='cartForm' onsubmit="return validate()" method="POST" action="add_cart.do">                        
                                <input style="padding-left: 10px" type='hidden' name='productId' value='<%= p.getId()%>'>
                                <p>
                                    <label>數量:</label>
                                    <% if (p.getStock() > 0) {%>
                                    <input type='number' id='quantity' name='quantity' required style="width: 120px;" min='<%= p.getStock() > 0 ? 1 : 0%>'
                                           max='<%= p.getStock() > 10 ? 10 : p.getStock()%>'  placeholder="<%= p.getStock() > 0 ? "輸入數量" : "已無庫存"%>">                        
                                    <%} else {%>
                                    <input type='text' id='quantity' style="width: 120px;" placeholder="已無庫存"> 
                                    <%}%>
                                    <a href='javascript:addCart()'>
                                        <span class="fas fa-shopping-cart"></span>
                                    </a>
                                </p>
                                
                            </form>
                        </div>
                        <% } else {%>
                        <p>查無此產品!</p>
                        <%}%>
                    </div>
                </div>  

                <div id="tabs">
                    <ul>
                        <li><a  href="#tabs-1">商品介紹</a></li>
                        <li><a  href="#tabs-2">規格說明</a></li>
                        <li><a  href="#tabs-3">運送方式</a></li>
                    </ul>
                    <div id="tabs-1">
                        <p>[季節限定每年約12月至3月]</p>
                        <p>選用大湖直送的新鮮草莓，在一顆顆精緻的泡芙中，與香滑柔順的奶醬交織，</p>
                        <p>草莓香氣濃郁，酸甜不膩口。</p>
                        <p>嚐一口便能吃出時飴的用心，是下午茶甜點、生日蛋糕、聚會送禮的最佳選擇。</p>
                        <p><strong>|保存方式|</strong></p>
                        <p>此商品為冷藏出貨：亦可冷凍保存，請放置冷藏回冰3小時再食用</p>
                        <p>夏季請勿在室外放置超過30分鐘</p>
                        <p>冬季請勿在室外放置超過1小時</p>
                        <p>最佳賞味期限:取貨後24小時內</p>
                        <p><strong>|取貨方式|</strong></p>
                        <p>1.星期一至日，皆可在營業時間內來高雄總店自取。</p>
                        <p>2.快遞，限高雄市，只能選上午或下午，無法指定時間。</p>
                        <p><strong>|注意事項|</strong></p>
                        <p>‼宅配泡芙因運送難免會有碰撞及轉手多人，有泡芙毀損的風險<br>
                            ‼宅配泡芙可能因天災及宅配業者貨量過多，有延遲到貨的風險<br>
                            <br>
                            <strong>以上猜心不予賠償，如無法接受，請勿宅配。<br>
                                選擇宅配泡芙，請評估是否能自行承擔(接受)宅配風險</strong><br>
                            <br>
                            ‼若您還是選擇日、一到貨。我們不會主動通知您無法出貨<br>
                            ‼無法選擇的日期代表無法訂購。<br>
                            ‼下單後需1小時內完成付款，逾時取消訂單。<br>
                            ‼若付款後需取消訂單退款，需扣10%手續費。<br>
                            ‼取貨日二天前無法取消訂單，費用不退還（不包含取貨當日。例：取貨日為12/31,最晚取消日為12/28）<br>
                            ‼泡芙屬生鮮產品，不適用網路購物7天鑑賞期<br>
                            ‼不收急單，最快可訂購5日後的泡芙。例：12/24下單付款，最快到貨日為12/29<br>
                            （實際可訂購日會因特殊節日及訂單數量而有所更動，還是以我方為主。）</p>

                        <p><br>
                            <strong>‼下單完成付款即代表同意以上規則</strong></p>
                    </div>
                    <div id="tabs-2">
                        <p><%= p.getDescription() %></p>
                    </div>
                    <div id="tabs-3">
                      
                        <div role="tabpanel" class="tab-pane active" id="product-detail-3">
                            <h4>店面自取(一~日)下午3~6點</h4>
                            <p></p><p>店面自取每周一~日 14:00-16:00, 泰順街60號</p><p></p>
                            <h4>快遞(高雄) 早上13:00前到</h4>
                            <p></p><p>配送區域: 高雄市．</p>
                            <p>週一到週日皆可配送, 運費需自付</p>
                            <p>**若無人收貨，需另自行付擔來回費用。（送回寄件方的費用及再次送達收件方的費用）</p>
                            <p>兩時段配送 早上 為13:00前，下午 為17:00前送到</p><p></p>
                            <h4>快遞(高雄) 下午17:00前到</h4>
                            <p></p><p>快遞可配送 高雄市．</p>
                            <p>週一到週日皆可配送, 運費自付</p>
                            <p>兩時段配送 早上 為13:00前，下午 為17:00前送到</p><p></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@include file="/WEB-INF/subviews/footer.jsp"  %>
</body>
</html>
