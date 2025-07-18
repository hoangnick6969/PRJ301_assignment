package controller.user;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Customer customer = (Customer) request.getSession().getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("user", customer);

        // Gửi thông báo nếu có ?success=1
        String success = request.getParameter("success");
        if ("1".equals(success)) {
            request.setAttribute("success", "Cập nhật thành công!");
        }

        request.getRequestDispatcher("/user/profile/view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Customer customer = (Customer) request.getSession().getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        customer.setName(name);
        customer.setPhone(phone);
        customer.setAddress(address);

        CustomerDAO dao = new CustomerDAO();
        dao.update(customer);

        request.getSession().setAttribute("user", customer);
        response.sendRedirect("profile?success=1");
    }
}
