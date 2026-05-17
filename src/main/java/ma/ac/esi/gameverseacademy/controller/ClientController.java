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
import java.util.List;

@WebServlet("/clients")
public class ClientController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isAuthenticated(request, response)) return;

        ClientService service = new ClientService();
        List<Client> clients  = service.getAllClients();
        request.setAttribute("clients", clients);
        request.getRequestDispatcher("/WEB-INF/views/clients.jsp")
               .forward(request, response);
    }
}
