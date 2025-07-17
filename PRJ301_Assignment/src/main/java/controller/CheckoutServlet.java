package controller;

import dao.CartItemDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.PaymentMethodDAO;
import dao.ShippingMethodDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = (Customer) request.getSession().getAttribute("user");
            if (customer == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            CartItemDAO cartItemDAO = new CartItemDAO();
            List<CartItem> cartItems = cartItemDAO.getByCustomer(customer);

            request.setAttribute("cart", cartItems);
            request.setAttribute("shippingMethods", new ShippingMethodDAO().getAll());
            request.setAttribute("paymentMethods", new PaymentMethodDAO().getAll());

            request.getRequestDispatcher("checkout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tải trang thanh toán");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Customer customer = (Customer) request.getSession().getAttribute("user");
            if (customer == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int shippingId = Integer.parseInt(request.getParameter("shippingMethodId"));
            int paymentId = Integer.parseInt(request.getParameter("paymentMethodId"));
            double total = Double.parseDouble(request.getParameter("total"));

            ShippingMethod shipping = new ShippingMethodDAO().findById(shippingId);
            PaymentMethod payment = new PaymentMethodDAO().findById(paymentId);

            Order order = new Order();
            order.setCustomer(customer);
            order.setShippingMethod(shipping);
            order.setPaymentMethod(payment);
            order.setOrderDate(new Date());
            order.setTotal(total);

            new OrderDAO().insert(order);

            CartItemDAO cartItemDAO = new CartItemDAO();
            List<CartItem> cartItems = cartItemDAO.getByCustomer(customer);

            OrderDetailDAO detailDAO = new OrderDetailDAO();
            for (CartItem item : cartItems) {
                OrderDetail detail = new OrderDetail();
                detail.setOrder(order);
                detail.setProduct(item.getProduct());
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getProduct().getPrice());
                detailDAO.insert(detail);
            }

            cartItemDAO.clearByCustomer(customer);

            response.sendRedirect("order-success.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý đặt hàng");
        }
    }
}
