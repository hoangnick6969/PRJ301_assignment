package controller.user;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            CustomerDAO dao = new CustomerDAO();
            Customer customer = dao.findByEmail(email);

            if (customer != null && customer.getPassword().equals(password)) {
                request.getSession().setAttribute("user", customer);
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Sai email hoặc mật khẩu");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi đăng nhập");
        }
    }
}
