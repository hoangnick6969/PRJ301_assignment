package controller.user;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/remove-from-cart"})
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));

            HttpSession session = request.getSession();
            Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

            if (cart != null) {
                Iterator<Product> iterator = cart.keySet().iterator();
                while (iterator.hasNext()) {
                    Product p = iterator.next();
                    if (p.getId() == productId) {
                        iterator.remove();
                        break;
                    }
                }
                session.setAttribute("cart", cart);
            }

        } catch (NumberFormatException e) {
            // Không làm gì, chuyển hướng về giỏ hàng
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
