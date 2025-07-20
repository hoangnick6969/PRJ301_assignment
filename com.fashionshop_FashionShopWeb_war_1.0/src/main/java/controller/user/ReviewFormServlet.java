package controller.user;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Product;

import java.io.IOException;

@WebServlet(name = "ReviewFormServlet", urlPatterns = {"/review-form"})
public class ReviewFormServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            request.setAttribute("product", product);
            request.getRequestDispatcher("/views/user/review/submit.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}
