    package controller.user;

import dao.CartItemDAO;
    import dao.CategoryDAO;
    import jakarta.servlet.ServletException;
    import jakarta.servlet.annotation.WebServlet;
    import jakarta.servlet.http.*;
    import model.Category;
    import model.Product;

    import java.io.IOException;
    import java.util.*;
import model.CartItem;
import model.Customer;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("user");

        Map<Product, Integer> cart = new LinkedHashMap<>();

        if (customer != null) {
            CartItemDAO cartItemDAO = new CartItemDAO();
            List<CartItem> items = cartItemDAO.getByCustomer(customer);

            for (CartItem item : items) {
                cart.put(item.getProduct(), item.getQuantity());
            }
        }

        double total = cart.entrySet().stream()
                .mapToDouble(e -> e.getKey().getPrice() * e.getValue())
                .sum();

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Category> categories = categoryDAO.getAll();
        request.setAttribute("categories", categories);

        request.setAttribute("cart", cart);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/views/user/cart/view.jsp").forward(request, response);
    }
}
