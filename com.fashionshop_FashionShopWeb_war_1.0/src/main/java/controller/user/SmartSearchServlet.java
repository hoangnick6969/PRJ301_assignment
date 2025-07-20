package controller.user;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SmartSearchServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Đảm bảo xử lý tiếng Việt
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String q = req.getParameter("q");
        List<Product> result = (q == null || q.trim().isEmpty())
            ? new ArrayList<>()
            : productDAO.smartSearch(q.trim());

        req.setAttribute("query", q);
        req.setAttribute("results", result);

        req.getRequestDispatcher("/views/user/search/search.jsp").forward(req, resp);
    }
}
