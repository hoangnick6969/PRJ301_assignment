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
            // 1. Load danh mục cho header
            CategoryDAO categoryDAO = new CategoryDAO();
            List<Category> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);

            // 2. Load sản phẩm mới nhất (hoặc nổi bật)
            ProductDAO productDAO = new ProductDAO();
            List<Product> newProducts = productDAO.getNewest(8);  // cần viết getNewest() nếu chưa có
            request.setAttribute("newProducts", newProducts);

            // 3. Load banner cho slider trang chủ
            BannerDAO bannerDAO = new BannerDAO();
            List<Banner> banners = bannerDAO.getByPosition("homepage-slider");
            request.setAttribute("banners", banners);

            // 4. Load blog mới (nếu cần)
            BlogPostDAO blogPostDAO = new BlogPostDAO();
            List<BlogPost> blogs = blogPostDAO.getLatest(3); // optional
            request.setAttribute("blogs", blogs);

            // 5. Forward đến trang chủ
            request.getRequestDispatcher("views/home/index.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang chủ");
        }
    }
}
