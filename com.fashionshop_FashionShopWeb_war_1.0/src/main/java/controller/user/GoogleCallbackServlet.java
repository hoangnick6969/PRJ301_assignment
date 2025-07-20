package controller.user;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeTokenRequest;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.*;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Customer;

import java.io.IOException;

@WebServlet("/login-google-callback")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "310697196810-..."; // điền đúng
    private static final String CLIENT_SECRET = "GOCSPX-...";   // điền đúng
    private static final String REDIRECT_URI = "http://localhost:8080/PRJ301_Assignment/login-google-callback";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            request.setAttribute("errorMessage", "Không có mã xác thực từ Google.");
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
            return;
        }

        try {
            // Step 1: Lấy token từ Google
            JsonFactory jsonFactory = JacksonFactory.getDefaultInstance();
            NetHttpTransport httpTransport = GoogleNetHttpTransport.newTrustedTransport();

            GoogleTokenResponse tokenResponse = new GoogleAuthorizationCodeTokenRequest(
                    httpTransport, jsonFactory,
                    "https://oauth2.googleapis.com/token",
                    CLIENT_ID, CLIENT_SECRET, code, REDIRECT_URI
            ).execute();

            String accessToken = tokenResponse.getAccessToken();

            // Step 2: Lấy thông tin user
            HttpRequestFactory requestFactory = httpTransport.createRequestFactory(
                    req -> req.getHeaders().setAuthorization("Bearer " + accessToken)
            );

            GenericUrl url = new GenericUrl("https://www.googleapis.com/oauth2/v2/userinfo");
            HttpRequest httpRequest = requestFactory.buildGetRequest(url);
            HttpResponse httpResponse = httpRequest.execute();

            String jsonIdentity = httpResponse.parseAsString();
            JsonObject json = JsonParser.parseString(jsonIdentity).getAsJsonObject();

            String email = json.get("email").getAsString();
            String name = json.get("name").getAsString();

            // Step 3: Kiểm tra hoặc tạo user
            CustomerDAO dao = new CustomerDAO();
            Customer customer = dao.findByEmail(email);

            if (customer == null) {
                customer = new Customer();
                customer.setEmail(email);
                customer.setName(name);
                customer.setPassword("GOOGLE_USER");
                customer.setPhone("0000000000");
                customer.setAddress("Google Account");
                dao.create(customer);
            }

            // Step 4: Set session & redirect
            HttpSession session = request.getSession(true);
            session.setAttribute("user", customer);

            response.sendRedirect(request.getContextPath() + "/home");

        } catch (Exception e) {
            // Gửi lỗi chi tiết lên giao diện
            request.setAttribute("errorMessage", "Google Login Failed: " + e.getMessage());
            request.getRequestDispatcher("/views/common/login.jsp").forward(request, response);
        }
    }
}
