package controller.user;

import dao.NewsletterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "SubscribeNewsletterServlet", urlPatterns = {"/subscribe-newsletter"})
public class SubscribeNewsletterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        if (email != null && !email.isBlank()) {
            new NewsletterDAO().insert(email.trim());
            request.setAttribute("msg", "Cảm ơn bạn đã đăng ký nhận bản tin!");
        }

        request.getRequestDispatcher("/views/common/footer.jsp").forward(request, response);
    }
}
