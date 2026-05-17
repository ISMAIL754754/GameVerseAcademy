package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/mods")
public class ModController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Protection de la route
        if (!SessionUtil.isAuthenticated(request, response)) return;

        ModService modService = new ModService();

        // ✅ Sans try/catch car getAllMods() gère SQLException en interne
        List<Mod> mods = modService.getAllMods();
        request.setAttribute("mods", mods);
        request.getRequestDispatcher("/mods.jsp")
               .forward(request, response);
    }
}