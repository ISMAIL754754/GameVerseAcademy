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

@WebServlet("/ModSubmitController")
public class ModSubmitController extends HttpServlet {

    private ModService modService = new ModService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        // 1. Récupérer les paramètres du formulaire
        String title       = request.getParameter("title");
        String category    = request.getParameter("category");
        String author      = request.getParameter("author");
        String description = request.getParameter("description");

        // 2. Construire l'objet Mod
        Mod mod = new Mod();
        mod.setTitle(title);
        mod.setCategory(category);
        mod.setAuthor(author);
        mod.setDescription(description);

        // 3. Appeler le service
        boolean success = modService.submitMod(mod);

        // 4. Résultat
        if (success) {
            request.setAttribute("message", "✅ Votre mod a été soumis avec succès !");
        } else {
            request.setAttribute("error", "❌ Erreur : le titre est obligatoire.");
        }

        request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
               .forward(request, response);
    }
}