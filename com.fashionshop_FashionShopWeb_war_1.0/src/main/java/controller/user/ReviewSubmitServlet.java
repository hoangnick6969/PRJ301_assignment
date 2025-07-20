package controller.user;

import dao.ProductDAO;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Product;
import model.Review;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "ReviewSubmitServlet", urlPatterns = {"/submit-review"})
public class ReviewSubmitServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);

            Review review = new Review();
            review.setCustomer(customer);
            review.setProduct(product);
            review.setRating(rating);
            review.setComment(comment);
            review.setCreatedAt(new Date());

            ReviewDAO reviewDAO = new ReviewDAO();
            reviewDAO.save(review);

            // Chuyển về lại trang chi tiết sản phẩm
            response.sendRedirect("product-detail?id=" + productId + "&reviewSuccess=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("product-detail?id=" + request.getParameter("productId") + "&reviewError=1");
        }
    }
}
