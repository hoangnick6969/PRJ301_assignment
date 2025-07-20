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

        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.delete(id);
                response.sendRedirect("messages");
                return;
            }

            List<ContactMessage> list = dao.getAll();
            request.setAttribute("contactList", list);
            request.getRequestDispatcher("/views/admin/contact/list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý liên hệ: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/common/error.jsp").forward(request, response);
        }
    }
}
