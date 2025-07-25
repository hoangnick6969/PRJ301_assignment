package controller.admin;

import dao.BlogPostDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BlogPost;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminBlogServlet", urlPatterns = {"/admin/blogs"})
public class AdminBlogServlet extends HttpServlet {

    private final BlogPostDAO blogDAO = new BlogPostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<BlogPost> list = blogDAO.getAll();
            request.setAttribute("blogs", list);
            request.getRequestDispatcher("/admin/blog-list.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            BlogPost blog = blogDAO.findById(id);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("/admin/blog-form.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            blogDAO.delete(id);
            response.sendRedirect("blogs");
        } else if (action.equals("add")) {
            request.getRequestDispatcher("/admin/blog-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                ? 0 : Integer.parseInt(request.getParameter("id"));

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        

        BlogPost blog = new BlogPost();
        blog.setId(id);
        blog.setTitle(title);
        blog.setContent(content);
        
        blog.setCreatedAt(new Date());

        if (id == 0) {
            blogDAO.insert(blog);
        } else {
            blogDAO.update(blog);
        }

        response.sendRedirect("blogs");
    }
}
