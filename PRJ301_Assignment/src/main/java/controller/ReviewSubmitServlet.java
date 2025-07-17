package controller;

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

        Customer customer = (Customer) request.getSession().getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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

        response.sendRedirect("product?id=" + productId + "&reviewSuccess=1");
    }
}
