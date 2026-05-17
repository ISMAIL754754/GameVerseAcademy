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

@WebServlet("/ClientEditController")
public class ClientEditController extends HttpServlet {

    private final ClientService service = new ClientService();

    // Afficher le formulaire pré-rempli
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/clients");
            return;
        }
        try {
            int id       = Integer.parseInt(idParam);
            Client client = service.getClientById(id);
            if (client == null) {
                response.sendRedirect(request.getContextPath() + "/clients");
                return;
            }
            request.setAttribute("client", client);
            request.getRequestDispatcher("/WEB-INF/views/editClient.jsp")
                   .forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/clients");
        }
    }

    // Traiter la mise à jour
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        Client c = buildClientFromRequest(request);
        String erreur = service.updateClient(c);

        if (erreur == null) {
            response.sendRedirect(request.getContextPath() + "/clients?success=edit");
        } else {
            request.setAttribute("error", erreur);
            request.setAttribute("client", c);
            request.getRequestDispatcher("/WEB-INF/views/editClient.jsp")
                   .forward(request, response);
        }
    }

    private Client buildClientFromRequest(HttpServletRequest req) {
        Client c = new Client();
        try { c.setId(Integer.parseInt(req.getParameter("id"))); } catch (Exception e) {}
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
