/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uuu.ghp.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uuu.ghp.entity.GHPException;
import uuu.ghp.entity.OrderShoppingCart;
import uuu.ghp.entity.Product;
import uuu.ghp.model.ProductService;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddToOrderCartServlet", urlPatterns = {"/add_order_cart.do"})
public class AddToOrderCartServlet extends HttpServlet {

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
         //1. 取得request中的Form Data: productId, quantity, 並檢查
         String productId = request.getParameter("productId");
         String quantity = request.getParameter("quantity");
         
         if(productId == null || productId.length() < 0 ){
             errors.add("加入預訂購物車時產品名稱不正確"+ productId);
         }
         if(quantity == null || !quantity.matches("\\d+")){
             errors.add("加入預訂購物時購物數量不正確" + quantity);
         }
          //2. 若無誤，呼叫商業邏輯
          if(errors.isEmpty()){
            ProductService service = new ProductService();
              try {
               
                    Product p = service.searchProductById(productId);
                
                if(p != null ){
                    HttpSession session = request.getSession();
                    OrderShoppingCart order_cart = (OrderShoppingCart)session.getAttribute("order_cart");
                    
                    if(order_cart == null){
                        order_cart = new OrderShoppingCart();
                        session.setAttribute("order_cart", order_cart);
                        
                    }
                    
                    order_cart.addToOrderCart(p, Integer.parseInt(quantity)); 
                    System.out.println("Order_Cart = " + order_cart);
                }
                
            } catch (GHPException ex) {
               this.log("加入預訂購物車時發生錯誤" ,ex);
                errors.add("加入預訂購物車時發生錯誤" + ex);
            }catch(Exception ex){
                this.log("加入預訂購物車時發生非預期錯誤" ,ex);
                errors.add("加入預訂購物車時發生非預期錯誤" + ex);
            }
          }
         if(errors.size()>0){
            this.log(errors.toString());
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
        //3.切換畫面(同步GET請求:redirect to /vgb/products_list.jsp | 非同步請求:forward to /cart_total_quantity.jsp)
        response.sendRedirect("products_list.jsp");
        //request.getRequestDispatcher("/cart_total_quantity.jsp").forward(request, response); 
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
         //3.切換畫面(同步GET請求:redirect to /vgb/member/cart.jsp | 非同步POST請求:forward to /cart_total_quantity.jsp)
        //response.sendRedirect(request.getContextPath() + "/member/cart.jsp");
        request.getRequestDispatcher("/order_cart_total_quantity.jsp").forward(request, response);  
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
