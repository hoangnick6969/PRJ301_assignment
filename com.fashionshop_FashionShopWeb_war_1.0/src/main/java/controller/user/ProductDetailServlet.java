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
            Product product = new ProductDAO().findById(id);
            if (product == null) {
                throw new Exception("Không tìm thấy sản phẩm có ID = " + id);
            }

            List<ProductImage> images = new ProductImageDAO().getByProduct(product);

            request.setAttribute("product", product);
            request.setAttribute("images", images);
            request.getRequestDispatcher("views/user/product/detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();  // in stack trace
            request.setAttribute("error", "Lỗi xử lý sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("views/common/error.jsp").forward(request, response);
        }

    }
}
