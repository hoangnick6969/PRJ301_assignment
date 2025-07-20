package controller.user;

import dao.AdminUserDAO;
import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.AdminUser;
import model.Customer;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String input = request.getParameter("email");  // Có thể là username (admin) hoặc email (user)
        String password = request.getParameter("password");
        HttpSession session = request.getSession();

        try {
            System.out.println("Đang đăng nhập với: " + input + " / " + password);

            // 1. Thử đăng nhập admin (theo username)
            AdminUser admin = new AdminUserDAO().findByUsernameAndPassword(input, password);
            if (admin != null) {
                session.setAttribute("admin", admin);
                response.sendRedirect("admin/dashboard");
                return;
            }

            // 2. Thử đăng nhập user (theo email)
            Customer customer = new CustomerDAO().findByEmailAndPassword(input, password);
            if (customer != null) {
                session.setAttribute("user", customer);
                response.sendRedirect("home");
                return;
            }

            // 3. Sai thông tin
            System.out.println("Không tìm thấy tài khoản phù hợp.");
            request.setAttribute("error", "Sai thông tin đăng nhập.");
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();  // Hiện lỗi trong console
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
    }
}
