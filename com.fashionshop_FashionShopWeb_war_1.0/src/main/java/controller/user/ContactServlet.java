package controller.user;

import dao.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ContactMessage;

import java.io.IOException;
import java.util.Date;

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/user/contact/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        ContactMessage msg = new ContactMessage();
        msg.setName(name);
        msg.setEmail(email);
        msg.setSubject(subject);
        msg.setContent(message);
        msg.setSentAt(new Date());

        new ContactMessageDAO().insert(msg);

        request.setAttribute("success", "✅ Cảm ơn bạn đã liên hệ!");
        request.getRequestDispatcher("/views/user/contact/contact.jsp").forward(request, response);
    }
}
