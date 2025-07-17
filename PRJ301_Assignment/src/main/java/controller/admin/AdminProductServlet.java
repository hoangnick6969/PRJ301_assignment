package controller.admin;

import dao.CategoryDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products"})
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // Mặc định: hiển thị danh sách sản phẩm
            List<Product> list = productDAO.getAll();
            request.setAttribute("products", list);
            request.getRequestDispatcher("/admin/product-list.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = productDAO.findById(id);
            List<Category> categories = categoryDAO.getAll();

            request.setAttribute("product", p);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.delete(id);
            response.sendRedirect("products");
        } else if (action.equals("add")) {
            List<Category> categories = categoryDAO.getAll();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/admin/product-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0 : Integer.parseInt(request.getParameter("id"));

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        String image = request.getParameter("image");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        Product p = new Product();
        p.setId(id);
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setMainImage(image);
        p.setCategory(categoryDAO.findById(categoryId));

        if (id == 0) {
            productDAO.insert(p);
        } else {
            productDAO.update(p);
        }

        response.sendRedirect("products");
    }
}
