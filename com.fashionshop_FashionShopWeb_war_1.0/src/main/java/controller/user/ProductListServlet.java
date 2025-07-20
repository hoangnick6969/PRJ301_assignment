package controller.user;

import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductListServlet", urlPatterns = {"/products"})
public class ProductListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cid = Integer.parseInt(request.getParameter("cid"));

            CategoryDAO categoryDAO = new CategoryDAO();
            ProductDAO productDAO = new ProductDAO();

            // Lấy tất cả danh mục (dùng cho menu header)
            List<Category> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);

            // Lấy danh mục hiện tại
            Category category = categoryDAO.findById(cid);
            request.setAttribute("category", category);

            // Lấy danh sách sản phẩm thuộc danh mục đó
            List<Product> products = productDAO.getByCategory(cid);
            request.setAttribute("products", products);

            // Forward tới view
            request.getRequestDispatcher("views/user/product/list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải danh sách sản phẩm");
        }
    }
}
