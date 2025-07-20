package controller.user;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String current = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirm = request.getParameter("confirmPassword");

        if (!customer.getPassword().equals(current)) {
            request.setAttribute("error", "Mật khẩu hiện tại không đúng");
        } else if (!newPass.equals(confirm)) {
            request.setAttribute("error", "Xác nhận mật khẩu không khớp");
        } else {
            customer.setPassword(newPass);
            new CustomerDAO().update(customer);
            session.setAttribute("user", customer);
            request.setAttribute("success", "Đổi mật khẩu thành công");
        }

        request.setAttribute("user", customer);
        request.getRequestDispatcher("/views/user/auth/change-password.jsp").forward(request, response);
    }
}
