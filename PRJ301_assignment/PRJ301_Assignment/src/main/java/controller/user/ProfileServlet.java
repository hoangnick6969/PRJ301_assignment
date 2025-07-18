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

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("user", customer);

        // Hiển thị thông báo nếu có ?success=1 hoặc ?success=0
        String success = request.getParameter("success");
        if ("1".equals(success)) {
            request.setAttribute("success", "Cập nhật thành công!");
        } else if ("0".equals(success)) {
            request.setAttribute("error", "Cập nhật thất bại. Vui lòng kiểm tra lại thông tin.");
        }

        request.getRequestDispatcher("/views/user/profile/view.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (customer == null) {
            response.sendRedirect("login");
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validate đơn giản
        if (name == null || name.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()
                || address == null || address.trim().isEmpty()) {
            response.sendRedirect("profile?success=0");
            return;
        }

        // Cập nhật dữ liệu
        customer.setName(name.trim());
        customer.setPhone(phone.trim());
        customer.setAddress(address.trim());

        CustomerDAO dao = new CustomerDAO();
        dao.update(customer);

        session.setAttribute("user", customer); // Cập nhật lại session
        response.sendRedirect("profile?success=1");
    }
}
