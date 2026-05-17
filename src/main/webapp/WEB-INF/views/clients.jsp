<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Client" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Clients</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #0f1117; color: #fff; min-height: 100vh; }

        /* ── NAVBAR ── */
        .navbar {
            background: #1a1d2e; padding: 14px 28px;
            display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
            border-bottom: 1px solid #2a2d3e; position: sticky; top: 0; z-index: 100;
        }
        .nav-brand { font-size: 17px; font-weight: 700; color: #4A90D9; margin-right: 8px; text-decoration: none; }
        .nav-sep { color: #2a2d3e; font-size: 20px; }
        .nav-page { font-size: 15px; font-weight: 600; color: #fff; }
        .nav-link {
            padding: 7px 16px; border-radius: 20px; border: 1px solid #3a3d4e;
            cursor: pointer; font-size: 13px; color: #aaa; transition: all 0.2s;
            text-decoration: none; background: transparent;
        }
        .nav-link:hover, .nav-link.active { background: #3b82f6; color: white; border-color: #3b82f6; }
        .btn-add {
            margin-left: auto; display: flex; align-items: center; gap: 7px;
            padding: 8px 20px; background: linear-gradient(135deg, #22c55e, #16a34a);
            color: white; font-weight: 700; font-size: 13px; border-radius: 20px;
            text-decoration: none; border: none; cursor: pointer;
            box-shadow: 0 0 16px rgba(34,197,94,0.3); transition: all 0.25s;
        }
        .btn-add:hover { transform: translateY(-2px); box-shadow: 0 6px 24px rgba(34,197,94,0.5); }
        .search-wrap { position: relative; }
        .search-wrap input {
            background: #2a2d3e; border: 1px solid #3a3d4e; border-radius: 20px;
            padding: 8px 16px 8px 34px; color: #fff; font-size: 13px; width: 200px; outline: none;
        }
        .search-wrap input:focus { border-color: #3b82f6; }
        .search-icon { position: absolute; left: 11px; top: 50%; transform: translateY(-50%); color: #666; }
        .user-pill {
            display: flex; align-items: center; gap: 7px;
            background: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.3);
            border-radius: 20px; padding: 6px 14px; font-size: 13px; font-weight: 600; color: #93c5fd;
        }
        .logout-btn {
            display: flex; align-items: center; gap: 6px; padding: 7px 14px;
            background: transparent; border: 1px solid rgba(239,68,68,0.4); border-radius: 20px;
            color: #f87171; font-size: 13px; font-weight: 600; cursor: pointer; transition: all 0.2s;
        }
        .logout-btn:hover { background: rgba(239,68,68,0.15); border-color: #ef4444; }

        /* ── CONTENU ── */
        .container { max-width: 1300px; margin: 28px auto; padding: 0 24px; }

        /* ── STATS ── */
        .stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 14px; margin-bottom: 24px; }
        .stat-card {
            background: #1a1d2e; border: 1px solid #2a2d3e; border-radius: 12px;
            padding: 16px 20px; display: flex; align-items: center; gap: 14px;
        }
        .stat-icon { font-size: 28px; }
        .stat-num { font-size: 26px; font-weight: 700; color: #fff; }
        .stat-lbl { font-size: 12px; color: #888; margin-top: 2px; }

        /* ── TOAST ── */
        .toast {
            padding: 12px 20px; border-radius: 8px; margin-bottom: 20px;
            font-size: 14px; font-weight: 600; display: flex; align-items: center; gap: 10px;
        }
        .toast-success { background: rgba(34,197,94,0.15); border: 1px solid #22c55e; color: #22c55e; }
        .toast-error   { background: rgba(239,68,68,0.15); border: 1px solid #ef4444; color: #ef4444; }

        /* ── TABLE ── */
        .table-wrap { background: #1a1d2e; border: 1px solid #2a2d3e; border-radius: 12px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        thead { background: #12152a; }
        thead th {
            padding: 13px 16px; text-align: left; font-size: 11px;
            text-transform: uppercase; letter-spacing: 1px; color: #888; font-weight: 600;
        }
        tbody tr { border-top: 1px solid #2a2d3e; transition: background 0.15s; }
        tbody tr:hover { background: rgba(59,130,246,0.05); }
        tbody td { padding: 12px 16px; font-size: 13px; color: #ccc; vertical-align: middle; }
        .td-name { font-weight: 600; color: #fff; }
        .td-email { color: #93c5fd; }

        /* badges abonnement */
        .badge-abo {
            display: inline-block; padding: 3px 10px; border-radius: 4px;
            font-size: 11px; font-weight: 700; letter-spacing: 0.5px;
        }
        .abo-FREE     { background: rgba(136,136,136,0.2); color: #aaa; border: 1px solid #555; }
        .abo-SILVER   { background: rgba(148,163,184,0.2); color: #94a3b8; border: 1px solid #94a3b8; }
        .abo-GOLD     { background: rgba(245,166,35,0.2); color: #f5a623; border: 1px solid #f5a623; }
        .abo-PLATINUM { background: rgba(139,92,246,0.2); color: #a78bfa; border: 1px solid #a78bfa; }

        /* badge actif/inactif */
        .badge-actif   { background: rgba(34,197,94,0.15); color: #22c55e; border: 1px solid #22c55e; border-radius: 12px; padding: 3px 10px; font-size: 11px; }
        .badge-inactif { background: rgba(239,68,68,0.15); color: #f87171; border: 1px solid #f87171; border-radius: 12px; padding: 3px 10px; font-size: 11px; }

        /* boutons action */
        .actions { display: flex; gap: 7px; align-items: center; }
        .btn-edit {
            padding: 5px 12px; background: rgba(245,166,35,0.15); color: #f5a623;
            border: 1px solid #f5a623; border-radius: 6px; font-size: 12px; font-weight: 600;
            text-decoration: none; transition: all 0.2s;
        }
        .btn-edit:hover { background: rgba(245,166,35,0.3); }
        .btn-del {
            padding: 5px 12px; background: rgba(239,68,68,0.15); color: #f87171;
            border: 1px solid #f87171; border-radius: 6px; font-size: 12px; font-weight: 600;
            cursor: pointer; transition: all 0.2s;
        }
        .btn-del:hover { background: rgba(239,68,68,0.3); }
        .btn-del-form { margin: 0; }

        .empty { text-align: center; padding: 48px; color: #555; font-size: 15px; }
        .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
        .page-title  { font-size: 22px; font-weight: 700; color: #fff; }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <a href="<%= request.getContextPath() %>/mods" class="nav-brand">🎮 GameVerse</a>
    <span class="nav-sep">›</span>
    <span class="nav-page">Gestion Clients</span>

    <a href="<%= request.getContextPath() %>/mods" class="nav-link">🎮 Mods</a>
    <a href="<%= request.getContextPath() %>/clients" class="nav-link active">👥 Clients</a>

    <div class="search-wrap">
        <span class="search-icon"><i class="bi bi-search"></i></span>
        <input type="text" id="searchInput" placeholder="Rechercher..." onkeyup="filterTable()"/>
    </div>

    <a href="<%= request.getContextPath() %>/ClientAddController" class="btn-add">
        <i class="bi bi-person-plus-fill"></i> Ajouter un client
    </a>

    <div class="user-pill">
        <i class="bi bi-person-circle"></i>
        <%= session.getAttribute("login") != null ? session.getAttribute("login") : "Visiteur" %>
    </div>

    <form action="<%= request.getContextPath() %>/LogoutController" method="post">
        <button type="submit" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Déconnexion
        </button>
    </form>
</div>

<!-- CONTENU -->
<div class="container">

    <%-- Toast notifications --%>
    <% String success = request.getParameter("success"); %>
    <% if ("add".equals(success)) { %>
        <div class="toast toast-success"><i class="bi bi-check-circle-fill"></i> Client ajouté avec succès !</div>
    <% } else if ("edit".equals(success)) { %>
        <div class="toast toast-success"><i class="bi bi-check-circle-fill"></i> Client mis à jour avec succès !</div>
    <% } else if ("delete".equals(success)) { %>
        <div class="toast toast-success"><i class="bi bi-check-circle-fill"></i> Client supprimé avec succès !</div>
    <% } %>

    <%
        List<Client> clients = (List<Client>) request.getAttribute("clients");
        long nbActifs   = clients.stream().filter(Client::isActif).count();
        long nbGold     = clients.stream().filter(c -> "GOLD".equals(c.getAbonnement()) || "PLATINUM".equals(c.getAbonnement())).count();
        int  totalMods  = clients.stream().mapToInt(Client::getModsAchetes).sum();
        double totalSolde = clients.stream().mapToDouble(Client::getSolde).sum();
    %>

    <!-- STATS -->
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-icon">👥</div>
            <div><div class="stat-num"><%= clients.size() %></div><div class="stat-lbl">Total clients</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">✅</div>
            <div><div class="stat-num"><%= nbActifs %></div><div class="stat-lbl">Clients actifs</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🏆</div>
            <div><div class="stat-num"><%= nbGold %></div><div class="stat-lbl">Abonnés Gold/Platinum</div></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon">🎮</div>
            <div><div class="stat-num"><%= totalMods %></div><div class="stat-lbl">Mods achetés (total)</div></div>
        </div>
    </div>

    <!-- TABLEAU -->
    <div class="page-header">
        <div class="page-title">Liste des clients (<%= clients.size() %>)</div>
    </div>

    <div class="table-wrap">
        <table id="clientTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nom / Prénom</th>
                    <th>E-mail</th>
                    <th>Téléphone</th>
                    <th>Pays</th>
                    <th>Abonnement</th>
                    <th>Mods achetés</th>
                    <th>Solde (MAD)</th>
                    <th>Statut</th>
                    <th>Inscription</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% if (clients.isEmpty()) { %>
                    <tr><td colspan="11" class="empty">Aucun client enregistré. <a href="<%= request.getContextPath() %>/ClientAddController" style="color:#22c55e">Ajouter le premier client →</a></td></tr>
                <% } else { %>
                    <% for (Client c : clients) { %>
                    <tr>
                        <td style="color:#555"><%= c.getId() %></td>
                        <td class="td-name"><%= c.getNom() %> <%= c.getPrenom() %></td>
                        <td class="td-email"><%= c.getEmail() %></td>
                        <td><%= c.getTelephone() != null ? c.getTelephone() : "—" %></td>
                        <td><%= c.getPays() != null ? c.getPays() : "—" %></td>
                        <td><span class="badge-abo abo-<%= c.getAbonnement() %>"><%= c.getAbonnement() %></span></td>
                        <td style="text-align:center"><%= c.getModsAchetes() %></td>
                        <td><%= String.format("%.2f", c.getSolde()) %></td>
                        <td>
                            <% if (c.isActif()) { %>
                                <span class="badge-actif">Actif</span>
                            <% } else { %>
                                <span class="badge-inactif">Inactif</span>
                            <% } %>
                        </td>
                        <td style="font-size:12px;color:#666">
                            <%= c.getDateInscription() != null ? c.getDateInscription().toString().substring(0,10) : "—" %>
                        </td>
                        <td>
                            <div class="actions">
                                <a href="<%= request.getContextPath() %>/ClientEditController?id=<%= c.getId() %>" class="btn-edit">
                                    <i class="bi bi-pencil-fill"></i> Modifier
                                </a>
                                <form class="btn-del-form" action="<%= request.getContextPath() %>/ClientDeleteController" method="post"
                                      onsubmit="return confirm('Supprimer le client <%= c.getNom() %> <%= c.getPrenom() %> ?');">
                                    <input type="hidden" name="id" value="<%= c.getId() %>"/>
                                    <button type="submit" class="btn-del">
                                        <i class="bi bi-trash-fill"></i> Supprimer
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function filterTable() {
        const q = document.getElementById("searchInput").value.toLowerCase();
        document.querySelectorAll("#clientTable tbody tr").forEach(row => {
            row.style.display = row.textContent.toLowerCase().includes(q) ? "" : "none";
        });
    }
    // Auto-dismiss toasts after 4s
    setTimeout(() => {
        document.querySelectorAll(".toast").forEach(t => t.style.display = "none");
    }, 4000);
</script>
</body>
</html>
