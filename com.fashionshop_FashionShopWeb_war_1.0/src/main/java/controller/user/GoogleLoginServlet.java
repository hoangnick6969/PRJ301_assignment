package controller.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/login-google")
public class GoogleLoginServlet extends HttpServlet {
    private static final String CLIENT_ID = "310697196810-4o2d70i186oiq4lsa2s2jkc7tfijp2n7.apps.googleusercontent.com";
    private static final String REDIRECT_URI = "http://localhost:8080/PRJ301_Assignment/login-google-callback";
    private static final String SCOPE = "email profile openid";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(REDIRECT_URI, "UTF-8")
                + "&response_type=code"
                + "&scope=" + URLEncoder.encode(SCOPE, "UTF-8")
                + "&access_type=offline"
                + "&prompt=consent";
        response.sendRedirect(loginUrl);
    }
}