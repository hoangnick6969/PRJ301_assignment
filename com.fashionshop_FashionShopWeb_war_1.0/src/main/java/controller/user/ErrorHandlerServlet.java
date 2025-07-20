/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author HP
 */
@WebServlet("/error-handler")
public class ErrorHandlerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = (String) req.getAttribute("jakarta.servlet.error.request_uri");

        if (uri != null && uri.startsWith(req.getContextPath() + "/admin")) {
            resp.sendRedirect(req.getContextPath() + "/admin/404");
        } else {
            req.getRequestDispatcher("/views/common/404.jsp").forward(req, resp);
        }
    }
}
