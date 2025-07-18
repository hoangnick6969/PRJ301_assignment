package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Product;

import java.io.IOException;

@WebServlet(name = "RemoveFromWishlistServlet", urlPatterns = {"/remove-from-wishlist"})
public class RemoveFromWishlistServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));

        WishlistDAO dao = new WishlistDAO();
        dao.delete(customer.getId(), productId);

        response.sendRedirect("wishlist");
    }
}
