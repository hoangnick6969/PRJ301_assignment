package controller;

import dao.CartItemDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Customer;
import model.Product;

import java.io.IOException;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = (Customer) request.getSession().getAttribute("user");
            if (customer == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int pid = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(pid);

            CartItem item = new CartItem(0, customer, product, quantity);
            CartItemDAO cartItemDAO = new CartItemDAO();
            cartItemDAO.insert(item);

            response.sendRedirect("cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi thêm sản phẩm vào giỏ hàng");
        }
    }
}
