package controller.admin;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if (action == null) {
                // ✅ Xử lý lọc theo khách hàng (nếu có)
                String customerIdParam = request.getParameter("customerId");
                List<Order> orders;

                if (customerIdParam != null && !customerIdParam.isEmpty()) {
                    int customerId = Integer.parseInt(customerIdParam);
                    orders = orderDAO.findByCustomerId(customerId);
                } else {
                    orders = orderDAO.getAll();
                }

                request.setAttribute("orderList", orders);
                request.getRequestDispatcher("/views/admin/order/list.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Order o = orderDAO.findById(id);
                request.setAttribute("order", o);
                request.getRequestDispatcher("/views/admin/order/editStatus.jsp").forward(request, response);

            } else if ("detail".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Order o = orderDAO.findById(id);
                request.setAttribute("order", o);
                request.getRequestDispatcher("/views/admin/order/detail.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                orderDAO.delete(id);
                response.sendRedirect("orders");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi xử lý yêu cầu: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/common/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("updateStatus".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String status = request.getParameter("status");

                Order o = orderDAO.findById(id);
                if (o != null) {
                    o.setStatus(status);
                    orderDAO.update(o);
                }

                response.sendRedirect("orders");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật trạng thái: " + e.getMessage());
            request.getRequestDispatcher("/views/admin/common/error.jsp").forward(request, response);
        }
    }
}
