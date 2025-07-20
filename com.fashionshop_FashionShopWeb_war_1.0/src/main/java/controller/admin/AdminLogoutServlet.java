package controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "AdminLogoutServlet", urlPatterns = {"/admin/logout"})
public class AdminLogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate(); // Hủy phiên làm việc
        }

        // Chuyển về trang login (tùy vào dự án, bạn có thể đặt lại cho phù hợp)
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
