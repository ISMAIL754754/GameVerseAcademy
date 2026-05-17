<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Mod" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier un Mod — GameVerse Academy</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #0f1117; color: #fff; min-height: 100vh;
        }
        .navbar {
            background: #1a1d2e; padding: 16px 32px;
            display: flex; align-items: center; gap: 16px;
            border-bottom: 1px solid #2a2d3e;
        }
        .navbar-brand { font-size: 18px; font-weight: 700; color: #4A90D9; }
        .btn-back {
            margin-left: auto; padding: 8px 18px;
            background: transparent; border: 1px solid #3a3d4e;
            border-radius: 20px; color: #aaa; text-decoration: none;
            font-size: 13px; transition: all 0.2s;
        }
        .btn-back:hover { border-color: #3b82f6; color: #3b82f6; }
        .container { max-width: 680px; margin: 48px auto; padding: 0 24px; }
        .form-card {
            background: #1a1d2e; border-radius: 16px;
            border: 1px solid #2a2d3e; padding: 40px;
        }
        .form-title { font-size: 26px; font-weight: 700; color: #f5a623; margin-bottom: 32px; }
        .msg-error {
            background: rgba(239,68,68,0.15); border: 1px solid #ef4444;
            color: #ef4444; padding: 14px 18px; border-radius: 8px; margin-bottom: 24px;
        }
        .field { margin-bottom: 22px; }
        .field label {
            display: block; font-size: 13px; font-weight: 600;
            color: #aaa; letter-spacing: 0.5px; text-transform: uppercase; margin-bottom: 8px;
        }
        .field input, .field select, .field textarea {
            width: 100%; background: #0f1117; border: 1px solid #2a2d3e;
            border-radius: 8px; padding: 12px 16px; color: #fff;
            font-size: 14px; font-family: inherit; outline: none; transition: border-color 0.2s;
        }
        .field input:focus, .field select:focus, .field textarea:focus { border-color: #f5a623; }
        .field textarea { height: 120px; resize: vertical; }
        .field select option { background: #1a1d2e; }
        .btn-update {
            width: 100%; padding: 14px;
            background: linear-gradient(135deg, #f5a623, #f97316);
            color: #000; font-size: 15px; font-weight: 700;
            border: none; border-radius: 8px; cursor: pointer;
            transition: all 0.2s; box-shadow: 0 4px 16px rgba(245,166,35,0.3);
        }
        .btn-update:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(245,166,35,0.5); }
        .user-info {
            display: flex; align-items: center; gap: 8px;
            background: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.3);
            border-radius: 20px; padding: 7px 16px; font-size: 13px;
            font-weight: 600; color: #93c5fd; margin-left: 16px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="navbar-brand">🎮 GameVerse Academy</div>
    <div class="user-info">
        <i class="bi bi-person-circle"></i>
        <span><%= session.getAttribute("login") != null ? session.getAttribute("login") : "Visiteur" %></span>
    </div>
    <a href="<%= request.getContextPath() %>/mods" class="btn-back">← Retour aux Mods</a>
</div>

<div class="container">
    <div class="form-card">
        <div class="form-title">✏️ Modifier le mod</div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="msg-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% Mod mod = (Mod) request.getAttribute("mod"); %>

        <form action="<%= request.getContextPath() %>/ModUpdateController" method="post">

            <input type="hidden" name="id" value="<%= mod.getId() %>"/>

            <div class="field">
                <label>Titre du mod *</label>
                <input type="text" name="title" value="<%= mod.getTitle() %>" required/>
            </div>

            <div class="field">
                <label>Catégorie</label>
                <select name="category">
                    <option value="Combat"    <%= "Combat".equals(mod.getCategory())    ? "selected" : "" %>>Combat</option>
                    <option value="Skin"      <%= "Skin".equals(mod.getCategory())      ? "selected" : "" %>>Skin</option>
                    <option value="Map"       <%= "Map".equals(mod.getCategory())       ? "selected" : "" %>>Map</option>
                    <option value="RPG"       <%= "RPG".equals(mod.getCategory())       ? "selected" : "" %>>RPG</option>
                    <option value="Graphique" <%= "Graphique".equals(mod.getCategory()) ? "selected" : "" %>>Graphique</option>
                    <option value="Gameplay"  <%= "Gameplay".equals(mod.getCategory())  ? "selected" : "" %>>Gameplay</option>
                </select>
            </div>

            <div class="field">
                <label>Auteur</label>
                <input type="text" name="author" value="<%= mod.getAuthor() != null ? mod.getAuthor() : "" %>"/>
            </div>

            <div class="field">
                <label>Description</label>
                <textarea name="description"><%= mod.getDescription() != null ? mod.getDescription() : "" %></textarea>
            </div>

            <button type="submit" class="btn-update">💾 Enregistrer les modifications</button>
        </form>
    </div>
</div>

</body>
</html>