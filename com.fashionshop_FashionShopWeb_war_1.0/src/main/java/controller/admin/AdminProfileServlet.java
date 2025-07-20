package controller.admin;

import dao.AdminUserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.AdminUser;

import java.io.IOException;

@WebServlet("/admin/profile")
public class AdminProfileServlet extends HttpServlet {

    private final AdminUserDAO dao = new AdminUserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        AdminUser admin = (AdminUser) req.getSession().getAttribute("admin");
        req.setAttribute("admin", admin);
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        AdminUser admin = (AdminUser) req.getSession().getAttribute("admin");

        String name = req.getParameter("displayName");
        String current = req.getParameter("currentPassword");
        String newPass = req.getParameter("newPassword");
        String confirm = req.getParameter("confirmPassword");

        if (name != null) admin.setFullName(name); // dùng setFullName, vì entity bạn khai báo như vậy

        if (current != null && !current.isEmpty()) {
            if (!admin.getPassword().equals(current)) {
                req.setAttribute("error", "Mật khẩu hiện tại không đúng.");
            } else if (!newPass.equals(confirm)) {
                req.setAttribute("error", "Xác nhận mật khẩu không khớp.");
            } else {
                admin.setPassword(newPass);
                dao.update(admin);
                req.setAttribute("success", "Cập nhật thành công.");
            }
        } else {
            dao.update(admin);
            req.setAttribute("success", "Cập nhật thành công.");
        }

        req.getSession().setAttribute("admin", admin);
        req.setAttribute("admin", admin);
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }
}
