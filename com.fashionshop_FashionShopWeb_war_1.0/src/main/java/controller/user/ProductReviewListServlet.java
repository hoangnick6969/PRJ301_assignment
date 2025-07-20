package controller.user;

import dao.ProductDAO;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductReviewListServlet", urlPatterns = {"/product-reviews"})
public class ProductReviewListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            ReviewDAO reviewDAO = new ReviewDAO();
            List<Review> reviews = reviewDAO.findByProductId(productId);

            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("/views/user/review/list.jsp").forward(request, response);

        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
