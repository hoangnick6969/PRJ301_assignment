package controller.admin;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminReviewServlet", urlPatterns = {"/admin/reviews"})
public class AdminReviewServlet extends HttpServlet {

    private final ReviewDAO dao = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Review> list = dao.getAll();
        request.setAttribute("reviews", list);
        request.getRequestDispatcher("/admin/review-list.jsp").forward(request, response);
    }
}
