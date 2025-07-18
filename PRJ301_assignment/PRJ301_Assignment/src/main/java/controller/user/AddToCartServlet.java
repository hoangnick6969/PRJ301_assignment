package controller.user;

import dao.CartItemDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import model.CartItem;
import model.Customer;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.findById(productId);
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        if (product == null || quantity <= 0 || customer == null) {
            response.sendRedirect("views/common/error.jsp");
            return;
        }

        CartItemDAO cartItemDAO = new CartItemDAO();
        CartItem existingItem = cartItemDAO.findByCustomerAndProduct(customer, product);

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
            cartItemDAO.update(existingItem);
        } else {
            CartItem newItem = new CartItem();
            newItem.setCustomer(customer);
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            cartItemDAO.insert(newItem);
        }

        response.sendRedirect("cart");
    }
}
