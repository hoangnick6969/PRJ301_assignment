package controller.user;

import dao.WishlistDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Product;
import model.Wishlist;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "AddToWishlistServlet", urlPatterns = {"/add-to-wishlist"})
public class AddToWishlistServlet extends HttpServlet {

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

        WishlistDAO wishlistDAO = new WishlistDAO();
        ProductDAO productDAO = new ProductDAO();

        Product product = productDAO.findById(productId);

        if (!wishlistDAO.exists(customer, product)) {
            Wishlist w = new Wishlist();
            w.setCustomer(customer);
            w.setProduct(product);
            w.setCreatedAt(new Date());
            wishlistDAO.insert(w);
        }

        response.sendRedirect("wishlist");
    }
}
