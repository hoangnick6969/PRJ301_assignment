package controller.user;

import dao.CartItemDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = (Customer) request.getSession().getAttribute("user");
            if (customer == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            CartItemDAO cartItemDAO = new CartItemDAO();
            List<CartItem> cartItems = cartItemDAO.getByCustomer(customer);
            request.setAttribute("cart", cartItems);
            request.getRequestDispatcher("cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi hiển thị giỏ hàng");
        }
    }
}
