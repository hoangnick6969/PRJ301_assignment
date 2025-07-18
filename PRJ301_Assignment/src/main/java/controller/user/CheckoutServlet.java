package controller.user;

import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.PaymentMethodDAO;
import dao.ShippingMethodDAO;
import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Load shipping & payment
        ShippingMethodDAO shippingDAO = new ShippingMethodDAO();
        PaymentMethodDAO paymentDAO = new PaymentMethodDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        List<ShippingMethod> shippingMethods = shippingDAO.getAll();
        List<PaymentMethod> paymentMethods = paymentDAO.getAll();
        List<Category> categories = categoryDAO.getAll();

        request.setAttribute("shippingMethods", shippingMethods);
        request.setAttribute("paymentMethods", paymentMethods);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("views/user/order/checkout.jsp").forward(request, response);
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

        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        int shippingId = Integer.parseInt(request.getParameter("shippingMethod"));
        int paymentId = Integer.parseInt(request.getParameter("paymentMethod"));

        double total = cart.entrySet().stream()
                .mapToDouble(e -> e.getKey().getPrice() * e.getValue())
                .sum();

        // Tạo đơn hàng
        Order order = new Order();
        order.setCustomer(customer);
        ShippingMethodDAO shippingDAO = new ShippingMethodDAO();
        ShippingMethod shipping = shippingDAO.findById(shippingId);

        PaymentMethodDAO paymentDAO = new PaymentMethodDAO();
        PaymentMethod payment = paymentDAO.findById(paymentId);

        order.setShippingMethod(shipping);
        order.setPaymentMethod(payment);
        order.setOrderDate(new Date());
        order.setTotal(total);
        order.setStatus("Chờ xử lý");

        OrderDAO orderDAO = new OrderDAO();
        orderDAO.insert(order);

        // Tạo chi tiết đơn hàng
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        for (Map.Entry<Product, Integer> entry : cart.entrySet()) {
            OrderDetail detail = new OrderDetail();
            detail.setOrder(order);
            detail.setProduct(entry.getKey());
            detail.setQuantity(entry.getValue());
            detail.setPrice(entry.getKey().getPrice());
            detailDAO.insert(detail);
        }

        // Xóa giỏ hàng
        session.removeAttribute("cart");

        // Chuyển đến trang thành công
        response.sendRedirect("order-success");
    }
}
