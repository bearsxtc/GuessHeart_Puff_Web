/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.ghp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ghp.entity.Customer;
import uuu.ghp.entity.GHPException;
import uuu.ghp.entity.Order;
import uuu.ghp.entity.PaymentType;
import uuu.ghp.entity.ShippingType;
import uuu.ghp.entity.ShoppingCart;
import uuu.ghp.model.OrderService;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/member/check_out.do"})
public class CheckOutServlet extends HttpServlet {

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
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (member == null || cart == null) {
            response.sendRedirect("cart.jsp");
            return;
        }

        //2.若無誤，則呼叫商業邏輯
        if (errors.isEmpty()) {
            Order order = new Order();
            order.setMember(member);
            try {
                PaymentType pType = PaymentType.valueOf(paymentType);
                order.setPaymentType(pType);
                order.setPaymentFee(pType.getFee());

                ShippingType shType = ShippingType.valueOf(shippingType);
                order.setShippingType(shType);
                order.setShippingFee(shType.getFee());
            } catch (RuntimeException ex) {
                errors.add(ex.toString());
            }
            if (errors.isEmpty()) {
                order.setRecipientName(name);
                order.setRecipientEmail(email);
                order.setRecipientPhone(phone);
                order.setShippingAddress(address);

                order.add(cart);
                try {
                    OrderService service = new OrderService();
                    service.insert(order);

                    session.removeAttribute("cart");
                    //3.1 結帳成功，內部轉交./order.jsp
                    request.setAttribute("order", order);
                    if (order.getPaymentType() == PaymentType.CARD) {
                        request.getRequestDispatcher("/WEB-INF/credit_card.jsp").forward(request, response);
                        return;
                    }
                    request.getRequestDispatcher("order.jsp").forward(request, response);
                    return;
                } catch (GHPException ex) {
                    if (ex.getMessage().indexOf("產品庫存不足") > -1) {
                        errors.add("產品庫存不足，請回[購物車]修改數量");
                        request.setAttribute("errors", errors);
                        request.getRequestDispatcher("cart.jsp").forward(request, response);
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
        request.getRequestDispatcher("/member/check_out.jsp").forward(request, response);

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
