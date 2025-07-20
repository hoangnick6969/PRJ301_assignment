package controller.user;

import dao.CartItemDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.*;

import java.io.IOException;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("user");

            // Nếu chưa đăng nhập → chuyển đến trang login
            if (customer == null) {
                response.sendRedirect("login");
                return;
            }

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);

            if (product == null || quantity <= 0) {
                response.sendRedirect("views/common/error.jsp");
                return;
            }

            CartItemDAO cartItemDAO = new CartItemDAO();
            CartItem existingItem = cartItemDAO.findByCustomerAndProduct(customer, product);

            if (existingItem != null) {
                // Nếu sản phẩm đã có trong giỏ, cập nhật số lượng
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                cartItemDAO.update(existingItem);
            } else {
                // Nếu chưa có, tạo mới
                CartItem item = new CartItem();
                item.setCustomer(customer);
                item.setProduct(product);
                item.setQuantity(quantity);
                cartItemDAO.insert(item);
            }

            // ✅ Chuyển hướng về giỏ hàng
            response.sendRedirect("cart");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/common/error.jsp");
        }
    }
}
