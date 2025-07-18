package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "RemoveFromWishlistServlet", urlPatterns = {"/remove-from-wishlist"})
public class RemoveFromWishlistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            WishlistDAO dao = new WishlistDAO();
            dao.delete(customer.getId(), productId);

        } catch (NumberFormatException e) {
            // Có thể log lỗi hoặc bỏ qua để tránh crash
        }

        response.sendRedirect(request.getContextPath() + "/wishlist");
    }
}
