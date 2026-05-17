<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Mods</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #0f1117;
            color: #fff;
            min-height: 100vh;
        }

        /* NAVBAR */
        .navbar {
            background: #1a1d2e;
            padding: 16px 32px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1px solid #2a2d3e;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .nav-btn {
            padding: 8px 18px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            background: transparent;
            color: #aaa;
            transition: all 0.2s;
        }

        .nav-btn.active { background: #3b82f6; color: white; }
        .nav-btn:hover:not(.active) { background: #2a2d3e; color: white; }

        /* BOUTON SOUMETTRE */
        .btn-submit {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 9px 20px;
            background: linear-gradient(135deg, #f5a623, #f97316);
            color: #000;
            font-weight: 700;
            font-size: 13px;
            border-radius: 20px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.25s;
            box-shadow: 0 0 16px rgba(245, 166, 35, 0.35);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 24px rgba(245, 166, 35, 0.55);
        }

        /* USER INFO */
        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(59, 130, 246, 0.1);
            border: 1px solid rgba(59, 130, 246, 0.3);
            border-radius: 20px;
            padding: 7px 16px;
            font-size: 13px;
            font-weight: 600;
            color: #93c5fd;
        }

        .user-info i {
            font-size: 16px;
            color: #3b82f6;
        }

        /* BOUTON DÉCONNEXION */
        .logout-btn {
            display: flex;
            align-items: center;
            gap: 7px;
            padding: 8px 16px;
            background: transparent;
            border: 1px solid rgba(239, 68, 68, 0.4);
            border-radius: 20px;
            color: #f87171;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }

        .logout-btn:hover {
            background: rgba(239, 68, 68, 0.15);
            border-color: #ef4444;
            color: #ef4444;
            transform: translateY(-1px);
        }

        .logout-btn i { font-size: 15px; }

        /* SEARCH */
        .search-box {
            margin-left: auto;
            position: relative;
        }

        .search-box input {
            background: #2a2d3e;
            border: 1px solid #3a3d4e;
            border-radius: 20px;
            padding: 8px 16px 8px 36px;
            color: #fff;
            font-size: 13px;
            width: 200px;
            outline: none;
            transition: border-color 0.2s, width 0.3s;
        }

        .search-box input:focus { border-color: #3b82f6; width: 240px; }
        .search-box input::placeholder { color: #666; }

        .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 14px;
        }

        /* CONTENU */
        .container {
            max-width: 1200px;
            margin: 32px auto;
            padding: 0 24px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            color: #4A90D9;
            margin-bottom: 24px;
        }

        /* CARTES */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .card {
            background: #1a1d2e;
            border-radius: 12px;
            overflow: hidden;
            border: 1px solid #2a2d3e;
            transition: transform 0.2s, box-shadow 0.2s;
            cursor: pointer;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 32px rgba(59, 130, 246, 0.2);
            border-color: #3b82f6;
        }

        .card-image {
            width: 100%;
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 64px;
            background: linear-gradient(135deg, #1e2340, #0d1020);
            position: relative;
        }

        .card-category-badge {
            position: absolute;
            bottom: 10px;
            left: 10px;
            background: rgba(0,0,0,0.7);
            border: 1px solid #3b82f6;
            color: #3b82f6;
            padding: 3px 10px;
            border-radius: 4px;
            font-size: 11px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .card-body { padding: 14px 16px; }

        .card-title {
            font-size: 16px;
            font-weight: 700;
            color: #fff;
            margin-bottom: 10px;
        }

        .card-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12px;
            color: #888;
            margin-bottom: 6px;
        }

        .card-info-icon {
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background: #3b82f6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            color: white;
            flex-shrink: 0;
        }

        .card-footer {
            padding: 10px 16px;
            border-top: 1px solid #2a2d3e;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .downloads {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            color: #888;
        }

        .metacritic {
            background: #22c55e;
            color: #000;
            font-weight: 800;
            font-size: 12px;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .metacritic.mid { background: #f5a623; }
        .metacritic.low { background: #ef4444; }

        /* Styles pour les boutons Edit/Delete */
        .action-buttons {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .btn-edit {
            padding: 4px 10px;
            background: #f5a623;
            color: #000;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-edit:hover {
            background: #f97316;
            transform: translateY(-1px);
        }
        .btn-delete {
            padding: 4px 10px;
            background: #ef4444;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-delete:hover {
            background: #dc2626;
            transform: translateY(-1px);
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <button class="nav-btn active">⭐ Nouveau</button>
    <button class="nav-btn">🔥 Tendances</button>
    <button class="nav-btn">⭐ Populaire</button>

    <!-- LIEN CLIENTS -->
    <a href="<%= request.getContextPath() %>/clients"
       style="padding:8px 18px;border-radius:20px;border:1px solid #2a9d8f;color:#2a9d8f;font-size:13px;font-weight:600;text-decoration:none;transition:all 0.2s;"
       onmouseover="this.style.background='rgba(42,157,143,0.15)'" onmouseout="this.style.background='transparent'">
        👥 Clients
    </a>

    <!-- BOUTON SOUMETTRE -->
    <a href="ModSubmitController" class="btn-submit">
        <span>＋</span> Soumettre un Mod
    </a>

    <!-- SEARCH -->
    <div class="search-box">
        <span class="search-icon">🔍</span>
        <input type="text" placeholder="Rechercher..." id="searchInput" onkeyup="filterCards()"/>
    </div>

    <!-- USER INFO -->
    <div class="user-info">
        <i class="bi bi-person-circle"></i>
        <span>
            <%= session.getAttribute("login") != null
                  ? session.getAttribute("login") : "Visiteur" %>
        </span>
    </div>

    <!-- BOUTON DÉCONNEXION -->
    <form action="<%= request.getContextPath() %>/LogoutController" method="post">
        <button type="submit" class="logout-btn">
            <i class="bi bi-box-arrow-right"></i> Déconnexion
        </button>
    </form>
</div>

<!-- CONTENU -->
<div class="container">
    <div class="page-title">🎮 Mods disponibles</div>

    <% List<Mod> mods = (List<Mod>) request.getAttribute("mods"); %>

    <div class="cards-grid" id="cardsGrid">
        <%
        String[] emojis = {"🗡️", "🌌", "🏰", "🐉", "🚀", "🏆", "⚔️", "🔮"};
        int i = 0;
        for (Mod mod : mods) {
            String emoji = emojis[i % emojis.length];
            i++;
        %>
        <div class="card" data-title="<%= mod.getTitle().toLowerCase() %>">
            <div class="card-image">
                <%= emoji %>
                <div class="card-category-badge"><%= mod.getCategory() %></div>
            </div>
            <div class="card-body">
                <div class="card-title"><%= mod.getTitle() %></div>
                <div class="card-info">
                    <div class="card-info-icon">A</div>
                    <span><%= mod.getAuthor() %></span>
                </div>
                <div class="card-info">
                    <div class="card-info-icon">📦</div>
                    <span>ID : <%= mod.getId() %></span>
                </div>
            </div>
            <div class="card-footer">
                <div class="downloads">
                    ⬇️ <%= mod.getDownloads() %> téléchargements
                </div>
                <div class="action-buttons">
                    <div class="metacritic <%= mod.getDownloads() > 3000 ? "" : mod.getDownloads() > 1000 ? "mid" : "low" %>">
                        <%= mod.getDownloads() > 3000 ? "TOP" : mod.getDownloads() > 1000 ? "MID" : "NEW" %>
                    </div>
                    <!-- Bouton Edit -->
                    <a href="<%= request.getContextPath() %>/ModUpdateController?id=<%= mod.getId() %>"
                       class="btn-edit">
                        ✏️ Edit
                    </a>
                    <!-- Bouton Delete -->
                    <form action="<%= request.getContextPath() %>/ModDeleteController" method="post"
                          onsubmit="return confirm('Supprimer ce mod ?');" style="margin: 0;">
                        <input type="hidden" name="id" value="<%= mod.getId() %>"/>
                        <button type="submit" class="btn-delete">
                            🗑️ Delete
                        </button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<script>
    function filterCards() {
        const input = document.getElementById('searchInput').value.toLowerCase();
        const cards = document.querySelectorAll('.card');
        cards.forEach(card => {
            const title = card.getAttribute('data-title');
            card.style.display = title.includes(input) ? 'block' : 'none';
        });
    }

    document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>

</body>
</html>