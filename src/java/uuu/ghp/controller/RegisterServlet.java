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
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register.do"})
public class RegisterServlet extends HttpServlet {

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
        //1.讀取request中Form的Parameter: 
        //userid,name,password1,password2,gender,email,birthday,phone,address,captcha
        //檢查 userid,name,password1,password2,gender,email,birthday,phone,captcha為必要欄位
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String pwd1 = request.getParameter("password1");
        String pwd2 = request.getParameter("password2");
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String captcha = request.getParameter("captcha");

         if (email == null || email.length() == 0) {
            errors.add("必須輸入Email");
        }


        if (name == null || name.length() == 0) {
            errors.add("必須輸入姓名");
        }

        if (pwd1 == null || pwd1.length() < 6 || pwd1.length() > 20) {
            errors.add("必須輸入6~20個字元的密碼");
        } else if (!pwd1.equals(pwd2)) {
            errors.add("必須輸入6~20個字元的密碼與相同的確認密碼");
        }

        if (gender == null || gender.length() != 1) {
            errors.add("必須輸入性別");
        }

      
        if (birthday == null || birthday.length() == 0) {
            errors.add("必須輸入生日");
        }

        HttpSession session = request.getSession();
        if (captcha == null || captcha.length() == 0) {
            errors.add("必須輸入驗證碼");
        } else {
            String oldCaptcha = (String) session.getAttribute("captcha");
            if (!captcha.equalsIgnoreCase(oldCaptcha)) {
                errors.add("驗證碼不正確");
            }
        }
        session.removeAttribute("captcha");
        //2.若無誤則呼叫商業邏輯
        if (errors.isEmpty()) {
            try {
                //2.1 將取得的欄位資料指派給Customer物件對應的屬性
                Customer c = new Customer();

                c.setEmail(email);
                c.setName(name);
                c.setPassword(pwd1);
                c.setGender(gender.charAt(0));
                c.setBirthday(birthday);
                c.setPhone(phone);
                c.setAddress(address);

                CustomerService service = new CustomerService();
                service.register(c);
                //3.1 註冊成功時轉交到首頁
                request.setAttribute("customer", c);

                RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
                dispatcher.forward(request, response);

                return;
            } catch (GHPException ex) {
                this.log("會員註冊發生錯誤", ex);
                errors.add(ex.getMessage());
            } catch (Exception ex) {
                this.log("會員註冊發生非預期錯誤", ex);
                errors.add("會員註冊發生非預期錯誤:" + ex);
            }
        }
        System.out.println(errors);
        //3.2 發生錯誤時轉交register.jsp
        request.setAttribute("errors", errors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
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
