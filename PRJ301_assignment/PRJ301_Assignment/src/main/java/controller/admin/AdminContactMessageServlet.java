package controller.admin;

import dao.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ContactMessage;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminContactMessageServlet", urlPatterns = {"/admin/messages"})
    public class AdminContactMessageServlet extends HttpServlet {

    private final ContactMessageDAO dao = new ContactMessageDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<ContactMessage> list = dao.getAll();
        request.setAttribute("messages", list);
        request.getRequestDispatcher("/admin/contact-message.jsp").forward(request, response);
    }
}
