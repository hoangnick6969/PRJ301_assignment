package controller.admin;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        OrderDAO orderDAO = new OrderDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        long productCount = productDAO.count();
        long orderCount = orderDAO.count();
        long customerCount = customerDAO.count();

        // 📊 Thống kê doanh thu theo tháng (6 tháng gần nhất)
        Map<String, Double> revenueByMonth = orderDAO.getMonthlyRevenue(6);

        request.setAttribute("productCount", productCount);
        request.setAttribute("orderCount", orderCount);
        request.setAttribute("customerCount", customerCount);
        request.setAttribute("revenueMap", revenueByMonth);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }
}
