package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Récupérer la session sans en créer une nouvelle
        HttpSession session = request.getSession(false);

        // 2. Invalider la session si elle existe
        if (session != null) {
            session.invalidate();
        }

        // 3. Rediriger vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
}
