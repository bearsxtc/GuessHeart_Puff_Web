/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.ghp.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ghp.entity.CartItem;
import uuu.ghp.entity.ShoppingCart;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateCartServlet", urlPatterns = {"/member/update_cart.do"})
public class UpdateCartServlet extends HttpServlet {

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
        ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
        if(cart!=null && cart.size()>0){            
            Set<CartItem> trashSet = new HashSet<>();
            for(CartItem item:cart.getCartItemSet()){ //java.util.ConcurrentModificationException
                //1.取得request中Form的Parameter
                String quantity = request.getParameter("quantity_"+item.hashCode());
                String delete = request.getParameter("delete_"+item.hashCode());                
                //2.呼叫商業邏輯
                if(delete==null && quantity!=null && quantity.matches("\\d+")){
                    //2.1呼叫修改購物明細中的數量
                    cart.update(item, Integer.parseInt(quantity));
                }else if(delete!=null){
                    //2.2刪除這筆購物明細(這樣會讓指位器的next()發生java.util.ConcurrentModificationException)
                    //cart.remove(item);
                    
                    //2.2.1將要刪除這筆購物明細先加入trashSet
                    trashSet.add(item);
                }        
            }
            
            //2.2.2依據trashSet中的待刪除item至購物車中執行刪除
            for(CartItem item:trashSet){
                cart.remove(item);
            }            
        }
        
        String submit = request.getParameter("submit");
        //3.切換畫面
        if("確認結帳".equals(submit)){
            response.sendRedirect(request.getContextPath()+"/member/check_out.jsp");
        }else if("繼續猜心".equals(submit)){
            response.sendRedirect(request.getContextPath()+"/products_list.jsp");
        }else{
            response.sendRedirect(request.getContextPath()+"/member/cart.jsp");
        }
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
