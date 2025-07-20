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

        try {
            if (action == null) {
                List<Coupon> list = dao.getAll();
                request.setAttribute("coupons", list);
                request.getRequestDispatcher("/views/admin/coupon/list.jsp").forward(request, response);

            } else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Coupon c = dao.findById(id);
                request.setAttribute("coupon", c);
                request.getRequestDispatcher("/views/admin/coupon/form.jsp").forward(request, response);

            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.delete(id);
                response.sendRedirect("coupons");

            } else if (action.equals("add")) {
                request.getRequestDispatcher("/views/admin/coupon/form.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("coupons");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = request.getParameter("id") == null || request.getParameter("id").isEmpty()
                    ? 0 : Integer.parseInt(request.getParameter("id"));

            String code = request.getParameter("code");
            int discount = Integer.parseInt(request.getParameter("discountPercent"));
            Date expiry = Date.valueOf(request.getParameter("expiryDate"));

            Coupon coupon = new Coupon(id, code, discount, expiry);

            if (id == 0) dao.insert(coupon);
            else dao.update(coupon);

        } catch (Exception e) {
            e.printStackTrace();
            // Bạn có thể log lỗi hoặc set thông báo để hiện trong JSP
        }

        response.sendRedirect("coupons");
    }
}
