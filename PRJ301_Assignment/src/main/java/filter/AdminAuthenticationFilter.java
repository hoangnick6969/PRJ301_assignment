package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter(filterName = "AdminAuthenticationFilter", urlPatterns = {"/admin/*"})
public class AdminAuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("admin") != null);
        boolean isLoginPage = req.getRequestURI().endsWith("/admin/login");

        if (isLoggedIn || isLoginPage) {
            chain.doFilter(request, response); // cho phép đi tiếp
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/login");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void destroy() {}
}
