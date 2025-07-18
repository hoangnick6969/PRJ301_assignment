package controller.user;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Product;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "RemoveFromCartServlet", urlPatterns = {"/remove-from-cart"})
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();
        Map<Product, Integer> cart = (Map<Product, Integer>) session.getAttribute("cart");

        if (cart != null) {
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findById(productId);
            cart.remove(product);
            session.setAttribute("cart", cart);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
