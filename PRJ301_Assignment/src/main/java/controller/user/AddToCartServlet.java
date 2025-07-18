package controller.user;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

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
        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

        if (cart == null) {
            cart = new LinkedHashMap<>();
        }

        if (cart.containsKey(product)) {
            cart.put(product, cart.get(product) + quantity);
        } else {
            cart.put(product, quantity);
        }

        session.setAttribute("cart", cart);

        // Chuyển hướng về lại trang sản phẩm hoặc giỏ hàng
        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
