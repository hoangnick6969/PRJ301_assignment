package controller.admin;

import dao.CouponDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Coupon;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "AdminCouponServlet", urlPatterns = {"/admin/coupons"})
public class AdminCouponServlet extends HttpServlet {

    private final CouponDAO dao = new CouponDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            List<Coupon> list = dao.getAll();
            request.setAttribute("coupons", list);
            request.getRequestDispatcher("/admin/coupon-list.jsp").forward(request, response);

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Coupon c = dao.findById(id);
            request.setAttribute("coupon", c);
            request.getRequestDispatcher("/admin/coupon-form.jsp").forward(request, response);

        } else if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.delete(id);
            response.sendRedirect("coupons");

        } else if (action.equals("add")) {
            request.getRequestDispatcher("/admin/coupon-form.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = request.getParameter("id") == null || request.getParameter("id").isEmpty() ? 0 : Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        int discount = Integer.parseInt(request.getParameter("discountPercent"));
        Date expiry = Date.valueOf(request.getParameter("expiryDate"));

        Coupon coupon = new Coupon(id, code, discount, expiry);

        if (id == 0) dao.insert(coupon);
        else dao.update(coupon);

        response.sendRedirect("coupons");
    }
}
