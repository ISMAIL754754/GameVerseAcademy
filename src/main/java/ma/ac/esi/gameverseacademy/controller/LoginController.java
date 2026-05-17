package ma.ac.esi.gameverseacademy.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.service.UserService;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login    = request.getParameter("uname");
        String password = request.getParameter("psw");

        UserService userService = new UserService();

        try {
            if (userService.finUserByCredentials(login, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("login", login);
                response.sendRedirect("mods");
            } else {
                response.sendRedirect("Error.html");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
