package controller.user;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Customer customer = new Customer();
            customer.setName(request.getParameter("name"));
            customer.setEmail(request.getParameter("email"));
            customer.setPassword(request.getParameter("password"));
            customer.setPhone(request.getParameter("phone"));
            customer.setAddress(request.getParameter("address"));

            CustomerDAO dao = new CustomerDAO();

            // Kiểm tra email trùng
            if (dao.findByEmail(customer.getEmail()) != null) {
                request.setAttribute("error", "Email đã được sử dụng!");
                request.getRequestDispatcher("views/user/auth/register.jsp").forward(request, response);
                return;
            }

            dao.insert(customer);
            response.sendRedirect("login");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi đăng ký tài khoản");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.getRequestDispatcher("views/user/auth/register.jsp").forward(request, response);
    }
}
