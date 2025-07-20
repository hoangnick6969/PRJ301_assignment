package controller.admin;

import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminCustomerServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomerServlet extends HttpServlet {

    private final CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Customer> customers = customerDAO.getAll();
        request.setAttribute("customerList", customerDAO.getAll());
        request.getRequestDispatcher("/views/admin/customer/list.jsp").forward(request, response);
    }
}
