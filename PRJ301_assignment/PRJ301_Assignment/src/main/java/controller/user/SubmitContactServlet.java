package controller.user;


import dao.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import model.ContactMessage;

@WebServlet(name = "SubmitContactServlet", urlPatterns = {"/SubmitContactServlet"})
public class SubmitContactServlet extends HttpServlet {
    private final ContactMessageDAO dao = new ContactMessageDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String msg = req.getParameter("message");

        ContactMessage cm = new ContactMessage();
        cm.setName(name);
        cm.setEmail(email);
        cm.setSubject(subject);
        cm.setMessage(msg);
        cm.setSentAt(new Date());

        dao.save(cm);

        resp.sendRedirect("contact.jsp?success=1");
    }
}
