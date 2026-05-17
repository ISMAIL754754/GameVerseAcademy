package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.service.ClientService;
import ma.ac.esi.gameverseacademy.util.SessionUtil;

import java.io.IOException;

@WebServlet("/ClientDeleteController")
public class ClientDeleteController extends HttpServlet {

    private final ClientService service = new ClientService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                service.deleteClient(id);
            } catch (NumberFormatException e) {
                // Ignorer les ID invalides
            }
        }
        response.sendRedirect(request.getContextPath() + "/clients?success=delete");
    }
}
