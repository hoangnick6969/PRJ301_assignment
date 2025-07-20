package controller.admin;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;
import model.OrderDetail;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            // Hiển thị danh sách đơn hàng
            List<Order> orders = orderDAO.getAll();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/admin/order-list.jsp").forward(request, response);

        } else if (action.equals("view")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Order order = orderDAO.findById(id);
            List<OrderDetail> details = orderDetailDAO.getByOrder(order);

            request.setAttribute("order", order);
            request.setAttribute("details", details);
            request.getRequestDispatcher("/admin/order-detail.jsp").forward(request, response);

        } else if (action.equals("updateStatus")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status");
            Order order = orderDAO.findById(id);
            if (order != null) {
                order.setStatus(status);
                orderDAO.update(order);
            }
            response.sendRedirect("orders");
        }
    }
}
