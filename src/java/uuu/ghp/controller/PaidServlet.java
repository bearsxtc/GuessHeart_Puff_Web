/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.ghp.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
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
import uuu.ghp.model.OrderService;


/**
 *
 * @author Admin
 */
@WebServlet(name = "PaidServlet", urlPatterns = {"/member/paid.do"})
public class PaidServlet extends HttpServlet {

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
        HttpSession session = request.getSession();
        Customer member = (Customer) session.getAttribute("member");
        List<String> errors = new ArrayList<>();
        if (member == null) {
            errors.add("請重新登入");
        }
        //1. 讀取request中Form的輸入值: orderId,bank,last5Code,amount,date,time
        String orderId = request.getParameter("orderId");
        String bank = request.getParameter("bank");
        String last5Code = request.getParameter("last5Code");
        String amount = request.getParameter("amount");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        if (orderId == null || !orderId.matches("\\d+")) {
            errors.add("訂單編號不正確");
        }
        if (bank == null || bank.length() == 0) {
            errors.add("必須輸入轉帳銀行");
        }
        if (last5Code == null || last5Code.length() == 0) {
            errors.add("必須輸入帳號後5碼");
        }
        if (amount == null || amount.length() == 0) {
            errors.add("必須輸入轉帳金額");
        }

        try {
            LocalDate.parse(date);
        } catch (Exception ex) {
            errors.add("必須輸入轉帳日期");
        }

        try {
            LocalTime.parse(time);
        } catch (Exception ex) {
            errors.add("必須輸入轉帳時間");
        }
        
        if(errors.isEmpty()){
            try{
                OrderService service = new OrderService();                
                Order order = service.searchOrderById(orderId);
                if(member.equals(order.getMember())){
                    service.updateOrderStatusToTransfered(member.getEmail(),orderId, bank, last5Code, amount, date, time);                    
                    //3.1 redirect到歷史訂單
                    response.sendRedirect("orders_history.jsp");
                    return;
                }else{
                    errors.add("訂單編號不正確");
                }   
            }catch(GHPException ex){
                if(ex.getCause()!=null){
                    this.log("通知轉帳失敗", ex);                    
                }
                errors.add(ex.toString());
            }catch(Exception ex){
                this.log("通知轉帳發生非預期錯誤", ex);     
                errors.add("通知轉帳發生非預期錯誤" + ex);
            }
        }
        
        //3.2 forward回paid.jsp
        request.setAttribute("errors", errors);
        request.getRequestDispatcher("paid.jsp").forward(request, response);

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
