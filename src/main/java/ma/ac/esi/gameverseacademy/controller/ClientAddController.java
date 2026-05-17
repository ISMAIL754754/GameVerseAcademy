package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import ma.ac.esi.gameverseacademy.model.Client;
import ma.ac.esi.gameverseacademy.service.ClientService;
import ma.ac.esi.gameverseacademy.util.SessionUtil;

import java.io.IOException;

@WebServlet("/ClientAddController")
public class ClientAddController extends HttpServlet {

    private final ClientService service = new ClientService();

    // Afficher le formulaire d'ajout
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;
        request.getRequestDispatcher("/WEB-INF/views/addClient.jsp")
               .forward(request, response);
    }

    // Traiter la soumission du formulaire
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        Client c = buildClientFromRequest(request);

        String erreur = service.addClient(c);

        if (erreur == null) {
            response.sendRedirect(request.getContextPath() + "/clients?success=add");
        } else {
            request.setAttribute("error", erreur);
            request.setAttribute("client", c);
            request.getRequestDispatcher("/WEB-INF/views/addClient.jsp")
                   .forward(request, response);
        }
    }

    private Client buildClientFromRequest(HttpServletRequest req) {
        Client c = new Client();
        c.setNom(req.getParameter("nom"));
        c.setPrenom(req.getParameter("prenom"));
        c.setEmail(req.getParameter("email"));
        c.setTelephone(req.getParameter("telephone"));
        c.setPays(req.getParameter("pays"));
        c.setAbonnement(req.getParameter("abonnement") != null ? req.getParameter("abonnement") : "FREE");
        try { c.setModsAchetes(Integer.parseInt(req.getParameter("modsAchetes"))); } catch (Exception e) { c.setModsAchetes(0); }
        try { c.setSolde(Double.parseDouble(req.getParameter("solde"))); } catch (Exception e) { c.setSolde(0.0); }
        c.setActif("on".equals(req.getParameter("actif")) || "true".equals(req.getParameter("actif")));
        return c;
    }
}
