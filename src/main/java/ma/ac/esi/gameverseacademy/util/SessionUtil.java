package ma.ac.esi.gameverseacademy.util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class SessionUtil {

    
     
    public static boolean isAuthenticated(HttpServletRequest request,
                                          HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("login") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return false;
        }

        return true;
    }

   
    
    public static String getLogin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute("login");
        }
        return null;
    }
}