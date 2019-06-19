/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.ghp.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ghp.entity.CartItem;
import uuu.ghp.entity.Customer;
import uuu.ghp.entity.GHPException;
import uuu.ghp.entity.Order;
import uuu.ghp.entity.OrderShoppingCart;
import uuu.ghp.entity.Order_Order;
import uuu.ghp.entity.PaymentType;
import uuu.ghp.entity.Product;
import uuu.ghp.entity.ShippingType;
import uuu.ghp.model.MailService;
import uuu.ghp.model.OrderService;
import uuu.ghp.model.Order_OrderService;

/**
 *
 * @author Admin
 */
@WebServlet(name = "COOServlet", urlPatterns = {"/member/order_check_out.do"})
public class COOServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<String> errors = new ArrayList<>();
        //1.讀取request中Form的Parameter: paymentType, shippingType, name, email, phone, address
        String paymentType = request.getParameter("paymentType");
        String shippingType = request.getParameter("shippingType");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        if (paymentType == null || paymentType.length() == 0) {
            errors.add("請選擇付款方式");
        }

        if (shippingType == null || shippingType.length() == 0) {
            errors.add("請選擇貨運方式");
        }

        if (name == null || name.length() == 0) {
            errors.add("請輸入收件人姓名");
        }

        if (email == null || email.length() == 0) {
            errors.add("請輸入收件人email");
        }

        if (phone == null || phone.length() == 0) {
            errors.add("請輸入收件人電話");
        }

        if (address == null || address.length() == 0) {
            errors.add("請輸入收件地址");
        }

        HttpSession session = request.getSession();
        Customer member = (Customer) session.getAttribute("member");
        OrderShoppingCart order_cart = (OrderShoppingCart) session.getAttribute("order_cart");
        if (member == null || order_cart == null) {
            response.sendRedirect("order_cart.jsp");
            return;
        }

        //2.若無誤，則呼叫商業邏輯
        if (errors.isEmpty()) {
            Order_Order order_order = new Order_Order();
            order_order.setMember(member);
            try {
                PaymentType pType = PaymentType.valueOf(paymentType);
                order_order.setPaymentType(pType);
                order_order.setPaymentFee(pType.getFee());

                ShippingType shType = ShippingType.valueOf(shippingType);
                order_order.setShippingType(shType);
                order_order.setShippingFee(shType.getFee());
            } catch (RuntimeException ex) {
                errors.add(ex.toString());
            }
            if (errors.isEmpty()) {
                order_order.setRecipientName(name);
                order_order.setRecipientEmail(email);
                order_order.setRecipientPhone(phone);
                order_order.setShippingAddress(address);

                order_order.add(order_cart);
                try {
                    Order_OrderService service = new Order_OrderService();
                    service.insert(order_order);

                    session.removeAttribute("order_cart");
                    //3.1 結帳成功，內部轉交./order.jsp
                    request.setAttribute("order_order", order_order);
                    String mail = "blackbear52@gmail.com";
                    MailService ms = new MailService();

                    for (CartItem item : order_cart.getCartItemSet()) {
                        Product p = item.getProduct();

//                    //不要命的精美訂單
                        String list
                                = "<table style='width:500px; margin-left:5px  '>"
                                + "<h2 style='font-size:larger;1px solid red; border-radius: 9px; width: 5.4%; padding: 9px;'> 猜心泡芙訂購單</h2>"
                                + "<h5 style='font-size:larger; color:red'>訂單編號：" + order_order.getFormatedId() + "</h5>"
                                + "<tr  ><th>商品名稱</th><th>口味</th><th>價格</th><th>數量</th><th>小計</th></tr>"
                                + "<tr ><th><hr></th><th><hr></th><th><hr></th><th><hr></th><th><hr></th></tr>"
                                + "<tr style='border: 2px solid black;'>"
                                + "<td style='text-align: center; 2px solid black;'>" + p.getName() + "</td>"
                                + "<td style='text-align: center; 2px solid black;'>" + p.getTaste() + "</td>"
                                + "<td style='text-align: center; 2px solid black;'>" + item.getProduct().getUnitPrice() + "</td>"
                                + "<td style='text-align: center; 2px solid black;'>" + order_order.getTotalQuantity() + "</td>"
                                + "<td style='text-align: center; 2px solid black;'>" + order_order.getTotalAmount() + "</td>"
                                + "</tr>"
                                + "</table>"
                                + "<h2 style='color:red; border: 1px solid red; border-radius: 9px; width: 5.4%; padding: 9px;'>取貨日期</h2><h2> 2019/04/25</h2>"
                                + "<hr style='width:500px;float:left;'><br>"
                                + "<br>"
                                + "<span style='font-size: larger;font-weight:700;clear:both;'>注意事項：</span><br>"
                                + "<br>"
                                + "<span>預訂店取需五個工作天(含周末)。</span><br>"
                                + "<span>P.S 如遇店休公告則順延。</span><br>"
                                + "<span>取貨時間請於取貨日期當天營業時間取貨。</span><br>"
                                + "<span>逾時將於關店前一個小時通知。</span><br>"
                                + "<span>若逾時未取將不予以補償。</span><br>"
                                + "<span>猜心泡芙，感謝您的光臨。</span><br>";//精美訂單 精美訂單 要用HTML做
                        ms.sendHelloMailWithLogo(mail, list);
                    }

                    //不要命的精美訂單
                    if (order_order.getPaymentType() == PaymentType.CARD) {
                        request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);
                        return;
                    }
                    request.getRequestDispatcher("order_order.jsp").forward(request, response);
                    return;
                } catch (GHPException ex) {
                    if (ex.getMessage().indexOf("產品庫存不足") > -1) {
                        errors.add("產品庫存不足，請回[購物車]修改數量");
                        request.setAttribute("errors", errors);
                        request.getRequestDispatcher("order_cart.jsp").forward(request, response);
                        return;
                    } else {
                        if (ex.getCause() != null) {
                            this.log("建立訂單失敗", ex);
                        }
                        errors.add(ex.getMessage());
                    }
                } catch (Exception ex) {
                    this.log("結帳作業建立訂單時發生非預期錯誤", ex);
                    errors.add("結帳作業建立訂單時發生非預期錯誤:" + ex.getMessage());
                }
            }
        }

        //3.2 結帳失敗，內部轉交./check_out.jsp
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("/member/order_check_out.jsp").forward(request, response);

    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
