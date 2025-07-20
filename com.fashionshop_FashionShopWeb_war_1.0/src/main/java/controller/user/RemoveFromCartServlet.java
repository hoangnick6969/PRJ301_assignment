package controller.user;

import dao.CartItemDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Category;
import model.Customer;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/remove-from-cart"})
public class RemoveFromCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            CartItemDAO cartItemDAO = new CartItemDAO();
            cartItemDAO.deleteByCustomerAndProduct(customer.getId(), productId);

        } catch (Exception e) {
            e.printStackTrace(); // Ghi log nếu có lỗi
        }

        response.sendRedirect("cart");
    }
}
