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

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);

            if (product == null || quantity <= 0) {
                response.sendRedirect("views/common/error.jsp"); // hoặc báo lỗi nhẹ
                return;
            }

            HttpSession session = request.getSession();
            Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new LinkedHashMap<>();
            }

            boolean found = false;

            for (Product p : cart.keySet()) {
                if (p.getId() == product.getId()) {
                    int oldQty = cart.get(p);
                    cart.put(p, oldQty + quantity);
                    found = true;
                    break;
                }
            }

            if (!found) {
                cart.put(product, quantity);
            }

            session.setAttribute("cart", cart);
            response.sendRedirect(request.getContextPath() + "views/user/cart/view.jsp");

        } catch (NumberFormatException e) {
            response.sendRedirect("views/common/error.jsp");
        }
    }
}
