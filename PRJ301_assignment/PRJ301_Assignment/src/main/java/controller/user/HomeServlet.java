package controller.user;

import dao.BannerDAO;
import dao.BlogPostDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Banner;
import model.BlogPost;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Load danh sách danh mục sản phẩm
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);

            // 2. Load danh sách sản phẩm (mới nhất hoặc tất cả)
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.getAll();  // Có thể thay bằng getLatest() nếu có
            request.setAttribute("products", products);

            // 3. Load banner vị trí trang chủ
            BannerDAO bannerDAO = new BannerDAO();
            List<Banner> banners = bannerDAO.getByPosition("homepage-top");
            request.setAttribute("banners", banners);

            // 4. Load bài viết blog/news
            BlogPostDAO blogPostDAO = new BlogPostDAO();
            List<BlogPost> blogs = blogPostDAO.getAll();
            request.setAttribute("blogs", blogs);

            // 5. Forward tới view
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (Exception e) {
            // Ghi log lỗi nếu cần
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang chủ");
        }
    }
}
