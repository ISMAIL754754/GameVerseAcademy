package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.util.SessionUtil;
import java.io.IOException;

@WebServlet("/ModUpdateController")
public class ModUpdateController extends HttpServlet {

    private ModService modService = new ModService();

    // Afficher le formulaire d'édition pré-rempli
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérifier l'authentification
        if (!SessionUtil.isAuthenticated(request, response)) return;

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Mod mod = modService.getModById(id);
            if (mod == null) {
                response.sendRedirect(request.getContextPath() + "/mods");
                return;
            }
            request.setAttribute("mod", mod);
            request.getRequestDispatcher("/WEB-INF/views/updateMod.jsp")
                   .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/mods");
        }
    }

    // Traiter la mise à jour
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String category = request.getParameter("category");
        String author = request.getParameter("author");
        String description = request.getParameter("description");

        if (idParam == null || title == null || title.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/mods");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Mod mod = new Mod();
            mod.setId(id);
            mod.setTitle(title);
            mod.setCategory(category);
            mod.setAuthor(author);
            mod.setDescription(description);

            boolean success = modService.updateMod(mod);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/mods");
            } else {
                request.setAttribute("error", "❌ Erreur lors de la mise à jour.");
                request.setAttribute("mod", mod);
                request.getRequestDispatcher("/WEB-INF/views/updateMod.jsp")
                       .forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/mods");
        }
    }
}