    package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Hủy toàn bộ session
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // ✅ Xóa cookies nếu có (đề phòng bị redirect loop do cookies cũ)
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                cookie.setMaxAge(0);
                cookie.setPath("/"); // Bắt buộc để xóa chính xác
                response.addCookie(cookie);
            }
        }

        // ✅ Quay về trang chủ hoặc login tùy bạn
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
