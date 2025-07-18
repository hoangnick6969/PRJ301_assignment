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

        String action = request.getParameter("action");

        if (action == null) {
            // Hiển thị danh sách tin nhắn liên hệ
            List<ContactMessage> list = dao.getAll();
            request.setAttribute("contactList", list);
            request.getRequestDispatcher("/views/admin/contact/list.jsp").forward(request, response);

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.delete(id);
            response.sendRedirect("messages");
        }
    }
}
