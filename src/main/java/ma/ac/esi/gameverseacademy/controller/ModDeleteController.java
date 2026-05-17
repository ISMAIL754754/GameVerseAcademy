package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.SessionUtil;
import java.io.IOException;

@WebServlet("/ModDeleteController")
public class ModDeleteController extends HttpServlet {

    private ModService modService = new ModService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                modService.deleteMod(id);
            } catch (NumberFormatException e) {
                // ignorer
            }
        }
        response.sendRedirect(request.getContextPath() + "/mods");
    }
}