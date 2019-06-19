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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ghp.entity.Customer;
import uuu.ghp.entity.GHPException;
import uuu.ghp.model.CustomerService;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateMemberServlet", urlPatterns = {"/update.do"})
public class UpdateMemberServlet extends HttpServlet {

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
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session_for_update = httpRequest.getSession();
        Customer member = (Customer) session_for_update.getAttribute("member");
//TODO:檢查密碼後才修改???
        try {
            if (member.getPassword().equals(request.getParameter("password2"))) {
                member.setName(member.getName().equals(request.getParameter("name")) ? member.getName() : request.getParameter("name"));
                member.setPassword(member.getPassword().equals(request.getParameter("password1")) ? member.getPassword() : request.getParameter("password1"));
                member.setEmail(member.getEmail().equals(request.getParameter("email")) ? member.getEmail() : request.getParameter("email"));
                member.setPhone(member.getPhone().equals(request.getParameter("phone")) ? member.getPhone() : request.getParameter("phone"));
                member.setAddress(member.getAddress().equals(request.getParameter("address")) ? member.getAddress() : request.getParameter("address"));

                CustomerService service = new CustomerService();
                service.update(member);
                //3.1修改成功 轉交login
                request.setAttribute("Customer", member);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                dispatcher.forward(request, response);
            } else {
                errors.add("請輸入正確密碼");
            }

        } catch (GHPException ex) {
            this.log("會員修改發生錯誤", ex);
            errors.add(ex.getMessage());
        } catch (Exception ex) {
            this.log("會員修改發生非預期錯誤", ex);
            errors.add("會員修改發生非預期錯誤" + ex);
        }

        System.out.println(errors);
        //3.2 發生錯誤時轉交register.jsp

        request.setAttribute("errors", errors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/updateMember.jsp");
        dispatcher.forward(request, response);
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
