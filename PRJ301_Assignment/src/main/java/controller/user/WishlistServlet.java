package controller.user;

import dao.WishlistDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Customer;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        // Lấy danh sách sản phẩm yêu thích
        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Product> wishlist = wishlistDAO.getProductsByCustomerId(customer.getId());
        request.setAttribute("wishlist", wishlist);

        // Gửi danh mục cho menu
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/user/wishlist/view.jsp").forward(request, response);
    }
}
