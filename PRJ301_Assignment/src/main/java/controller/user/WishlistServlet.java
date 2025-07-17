package controller.user;

import dao.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Wishlist;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Customer customer = (Customer) request.getSession().getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Wishlist> wishlist = wishlistDAO.getByCustomer(customer);

        request.setAttribute("wishlist", wishlist);
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }
}
