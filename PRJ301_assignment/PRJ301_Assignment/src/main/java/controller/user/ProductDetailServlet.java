package controller.user;

import dao.CategoryDAO;
import dao.ProductDAO;
import dao.ProductImageDAO;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product"})
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int pid = Integer.parseInt(request.getParameter("id"));

            ProductDAO productDAO = new ProductDAO();
            CategoryDAO categoryDAO = new CategoryDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
            ProductImageDAO imageDAO = new ProductImageDAO();

            Product product = productDAO.findById(pid);
            List<Category> categories = categoryDAO.getAll();
            List<Review> reviews = reviewDAO.getByProduct(product);

            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("reviews", reviews);
            request.setAttribute("images", imageDAO.getByProduct(product));

            request.getRequestDispatcher("productDetail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải chi tiết sản phẩm");
        }
    }
}
