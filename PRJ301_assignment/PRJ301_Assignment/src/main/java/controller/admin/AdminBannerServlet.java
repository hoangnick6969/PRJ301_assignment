package controller.admin;

import dao.BannerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Banner;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminBannerServlet", urlPatterns = {"/admin/banners"})
public class AdminBannerServlet extends HttpServlet {

    private final BannerDAO bannerDAO = new BannerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Banner> list = bannerDAO.getAll();
            request.setAttribute("banners", list);
            request.getRequestDispatcher("/admin/banner-list.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Banner banner = bannerDAO.findById(id);
            request.setAttribute("banner", banner);
            request.getRequestDispatcher("/admin/banner-form.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            bannerDAO.delete(id);
            response.sendRedirect("banners");
        } else if (action.equals("add")) {
            request.getRequestDispatcher("/admin/banner-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0 : Integer.parseInt(request.getParameter("id"));

        String title = request.getParameter("title");
        String image = request.getParameter("image");
        String position = request.getParameter("position");

        Banner b = new Banner();
        b.setId(id);
        b.setTitle(title);
        b.setImage(image);
        b.setPosition(position);

        if (id == 0) {
            bannerDAO.insert(b);
        } else {
            bannerDAO.update(b);
        }

        response.sendRedirect("banners");
    }
}
