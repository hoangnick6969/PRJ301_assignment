package controller.admin;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCategoryServlet", urlPatterns = {"/admin/categories"})
public class AdminCategoryServlet extends HttpServlet {

    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Category> list = categoryDAO.getAll();
            request.setAttribute("categoryList", list); // ✅ đồng bộ với list.jsp
            request.getRequestDispatcher("/views/admin/category/list.jsp").forward(request, response);

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Category c = categoryDAO.findById(id);
            request.setAttribute("category", c);
            request.getRequestDispatcher("/views/admin/category/form.jsp").forward(request, response);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            categoryDAO.delete(id);
            response.sendRedirect("categories");

        } else if ("add".equals(action)) {
            request.getRequestDispatcher("/views/admin/category/form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0 : Integer.parseInt(request.getParameter("id"));

        String name = request.getParameter("name");

        Category c = new Category();
        c.setId(id);
        c.setName(name);

        if (id == 0) {
            categoryDAO.insert(c);
        } else {
            categoryDAO.update(c);
        }

        response.sendRedirect("categories");
    }
}
