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
        request.setAttribute("reviewList", list);
        request.getRequestDispatcher("/views/admin/review/list.jsp").forward(request, response);
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.delete(id);
            response.sendRedirect("reviews");
            return;
        }

    }
}
