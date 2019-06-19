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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/login.do"})
public class LoginServlet extends HttpServlet {

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
        //1.讀取request中Form的Parameter: id,password,captcha
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");
        String captcha = request.getParameter("captcha");
        String auto = request.getParameter("auto");
        //檢查 id, pwd, captcha為必要欄位
        if (email == null && email.length() == 0) {
            errors.add("請輸入帳號");
        }
        if (pwd == null && pwd.length() == 0) {
            errors.add("請輸入密碼");
        }
        HttpSession session = request.getSession();
        if (captcha == null && captcha.length() == 0) {
            errors.add("請輸入驗證碼");
        }else{
            String oldCaptcha = (String)session.getAttribute("captcha");
            if(!captcha.equalsIgnoreCase(oldCaptcha)){
                errors.add("驗證碼不正確");
            }
        }
        session.removeAttribute("captcha");
        //2.若檢查無誤，呼叫CustomerService的login
        if (errors.isEmpty()) {
            CustomerService service = new CustomerService();
            try {                
                Customer c = service.login(email, pwd); //checked exception: VGBException
                
                //login成功則依據使用者選擇來add cookie/remove cookie
                Cookie idCookie = new Cookie("email", email);
                Cookie autoCookie = new Cookie("auto", "checked");
                if(auto==null){//使用者選擇不要記住
                    idCookie.setMaxAge(0);
                    autoCookie.setMaxAge(0);
                }else{//使用者選擇要記住
                    idCookie.setMaxAge(7*24*60*60);
                    autoCookie.setMaxAge(7*24*60*60);                    
                }
                
                response.addCookie(idCookie);
                response.addCookie(autoCookie);
                
                session.setAttribute("member", c);
                
         
                
                //3.1 redirect 首頁                
                String uri = (String)session.getAttribute("previous.uri");
                String queryString = (String)session.getAttribute("previous.query_string");
                session.removeAttribute("previous.uri");
                session.removeAttribute("previous.query_string");
                if(uri!=null){
                    if(queryString!=null) uri = uri + "?" + queryString;
                    response.sendRedirect(uri);
                }else{                
                    response.sendRedirect(request.getContextPath());
                }
                return;                    
            } catch (GHPException ex) {
                System.out.println("登入失敗:" + ex);
                if (ex.getCause() != null) {
                    errors.add(ex.getMessage() + ",請聯絡系統管理人員");
                } else {
                    errors.add(ex.getMessage());
                }
            }catch(Exception ex){
                this.log("登入發生非預期錯誤", ex);
                errors.add("登入發生非預期錯誤:" + ex.toString());
            }
        }
        System.out.println("errors:" + errors);
        
        //3.2產生登入失敗畫面
        request.setAttribute("errors", errors);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
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
