package controller.user;

import dao.BlogPostDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.BlogPost;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BlogServlet", urlPatterns = {"/blog"})
public class BlogServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BlogPostDAO dao = new BlogPostDAO();
        List<BlogPost> blogs = dao.getAll();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("views/user/blog/list.jsp").forward(request, response);
    }
}
