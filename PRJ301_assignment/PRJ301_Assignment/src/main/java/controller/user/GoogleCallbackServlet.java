package controller.user;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.GenericUrl;
import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestFactory;
import com.google.api.client.http.HttpResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.security.GeneralSecurityException;

@WebServlet("/login-google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "310697196810-p53d42ua0mm2gdld2sfl2493m4ihvibg.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "YOUR_CLIENT_SECRET"; // Thay bằng giá trị thật từ Google
    private static final String REDIRECT_URI = "http://localhost:8080/PRJ301_Assignment/login-google-callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("login.jsp?error=google");
            return;
        }

        try {
            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
            NetHttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();

            // Đổi code lấy access token
            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    httpTransport,
                    jsonFactory,
                    "https://oauth2.googleapis.com/token",
                    CLIENT_ID,
                    CLIENT_SECRET,
                    code,
                    REDIRECT_URI
            ).execute();

            String accessToken = tokenResponse.getAccessToken();

            // Gửi request để lấy thông tin người dùng
            HttpRequestFactory requestFactory = httpTransport.createRequestFactory(
                    request1 -> request1.getHeaders().setAuthorization("Bearer " + accessToken)
            );

            GenericUrl url = new GenericUrl("https://www.googleapis.com/oauth2/v2/userinfo");
            HttpRequest httpRequest = requestFactory.buildGetRequest(url);
            HttpResponse httpResponse = httpRequest.execute();

            String jsonIdentity = httpResponse.parseAsString();
            JsonObject json = JsonParser.parseString(jsonIdentity).getAsJsonObject();

            String email = json.get("email").getAsString();
            String name = json.get("name").getAsString();

            // Lưu session đăng nhập
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("name", name);

            response.sendRedirect("home");

        } catch (GeneralSecurityException e) {
            throw new ServletException("Security error when authenticating with Google", e);
        } catch (IOException e) {
            response.sendRedirect("login.jsp?error=token");
        }
    }
}
