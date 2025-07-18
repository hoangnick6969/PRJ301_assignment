package controller.user;

import dao.OrderDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;
import model.Order;
import model.Category;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderHistoryServlet", urlPatterns = {"/order-history"})
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");
        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy đơn hàng theo khách hàng
        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getByCustomer(customer);
        request.setAttribute("orders", orders);

        // Lấy danh mục cho menu (nếu cần)
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);

        // Chuyển đến giao diện lịch sử đơn hàng
        request.getRequestDispatcher("/user/order/history.jsp").forward(request, response);
    }
}
