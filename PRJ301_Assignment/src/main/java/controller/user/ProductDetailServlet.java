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
import model.ProductImage;
import model.Review;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductDetailServlet", urlPatterns = {"/product-detail"})
public class ProductDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            ProductDAO productDAO = new ProductDAO();
            ProductImageDAO imageDAO = new ProductImageDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
            CategoryDAO categoryDAO = new CategoryDAO();

            Product product = productDAO.findById(id);
            List<ProductImage> images = imageDAO.getByProductId(id);
            List<Review> reviews = reviewDAO.getByProductId(id);
            List<Category> categories = categoryDAO.getAll();

            request.setAttribute("product", product);
            request.setAttribute("images", images);
            request.setAttribute("reviews", reviews);
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/user/product/detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải chi tiết sản phẩm");
        }
    }
}
