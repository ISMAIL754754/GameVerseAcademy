<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Client" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier un client — GameVerse Academy</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #0f1117; color: #fff; min-height: 100vh; }
        .navbar {
            background: #1a1d2e; padding: 14px 28px; display: flex; align-items: center; gap: 12px;
            border-bottom: 1px solid #2a2d3e;
        }
        .nav-brand { font-size: 17px; font-weight: 700; color: #4A90D9; text-decoration: none; }
        .nav-sep { color: #555; }
        .nav-page { font-size: 14px; color: #fff; }
        .btn-back {
            margin-left: auto; padding: 7px 16px; border: 1px solid #3a3d4e; border-radius: 20px;
            color: #aaa; text-decoration: none; font-size: 13px; transition: all 0.2s;
        }
        .btn-back:hover { border-color: #3b82f6; color: #3b82f6; }
        .user-pill {
            display: flex; align-items: center; gap: 7px;
            background: rgba(59,130,246,0.1); border: 1px solid rgba(59,130,246,0.3);
            border-radius: 20px; padding: 6px 14px; font-size: 13px; font-weight: 600; color: #93c5fd;
        }
        .container { max-width: 760px; margin: 40px auto; padding: 0 24px; }
        .form-card {
            background: #1a1d2e; border: 1px solid #2a2d3e; border-radius: 16px; padding: 36px;
        }
        .form-title { font-size: 22px; font-weight: 700; color: #f5a623; margin-bottom: 28px;
            display: flex; align-items: center; gap: 10px; }
        .client-id-badge {
            background: rgba(59,130,246,0.15); border: 1px solid rgba(59,130,246,0.3);
            color: #93c5fd; padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600;
            margin-bottom: 24px; display: inline-block;
        }
        .msg-error {
            background: rgba(239,68,68,0.12); border: 1px solid #ef4444;
            color: #f87171; padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 14px;
        }
        .row-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .field { margin-bottom: 18px; }
        .field label {
            display: block; font-size: 11px; font-weight: 700; color: #888;
            letter-spacing: 0.8px; text-transform: uppercase; margin-bottom: 7px;
        }
        .field input, .field select {
            width: 100%; background: #0f1117; border: 1px solid #2a2d3e;
            border-radius: 8px; padding: 11px 14px; color: #fff; font-size: 14px; outline: none;
            transition: border-color 0.2s; font-family: inherit;
        }
        .field input:focus, .field select:focus { border-color: #f5a623; }
        .field select option { background: #1a1d2e; }
        .toggle-row { display: flex; align-items: center; gap: 12px; }
        .toggle-row input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: #f5a623; }
        .toggle-row label { font-size: 14px; color: #ccc; font-weight: 400; }
        .btn-submit {
            width: 100%; padding: 13px; background: linear-gradient(135deg, #f5a623, #f97316);
            color: #000; font-size: 15px; font-weight: 700; border: none;
            border-radius: 8px; cursor: pointer; margin-top: 8px;
            box-shadow: 0 4px 16px rgba(245,166,35,0.3); transition: all 0.2s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(245,166,35,0.5); }
        .section-label {
            font-size: 11px; font-weight: 700; color: #555; text-transform: uppercase;
            letter-spacing: 1px; margin: 24px 0 14px; padding-bottom: 8px;
            border-bottom: 1px solid #2a2d3e;
        }
        .btn-footer { display: flex; gap: 10px; margin-top: 8px; }
        .btn-cancel {
            flex: 0 0 auto; padding: 13px 24px; background: transparent;
            border: 1px solid #3a3d4e; border-radius: 8px; color: #888; font-size: 14px;
            cursor: pointer; text-decoration: none; display: flex; align-items: center;
        }
        .btn-cancel:hover { border-color: #555; color: #ccc; }
    </style>
</head>
<body>

<%
    Client c = (Client) request.getAttribute("client");
    if (c == null) { response.sendRedirect(request.getContextPath() + "/clients"); return; }
%>

<div class="navbar">
    <a href="<%= request.getContextPath() %>/mods" class="nav-brand">🎮 GameVerse</a>
    <span class="nav-sep">›</span>
    <a href="<%= request.getContextPath() %>/clients" style="color:#888;text-decoration:none;font-size:14px">Clients</a>
    <span class="nav-sep">›</span>
    <span class="nav-page">Modifier #<%= c.getId() %></span>
    <div class="user-pill" style="margin-left:auto">
        <i class="bi bi-person-circle"></i>
        <%= session.getAttribute("login") != null ? session.getAttribute("login") : "Visiteur" %>
    </div>
    <a href="<%= request.getContextPath() %>/clients" class="btn-back">← Retour</a>
</div>

<div class="container">
    <div class="form-card">
        <div class="form-title"><i class="bi bi-pencil-fill"></i> Modifier le client</div>
        <div class="client-id-badge"><i class="bi bi-hash"></i> Client ID : <%= c.getId() %></div>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="msg-error"><i class="bi bi-exclamation-triangle-fill"></i> <%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/ClientEditController" method="post">
            <input type="hidden" name="id" value="<%= c.getId() %>">

            <div class="section-label">Informations personnelles</div>
            <div class="row-2">
                <div class="field">
                    <label>Nom *</label>
                    <input type="text" name="nom" value="<%= c.getNom() %>" required>
                </div>
                <div class="field">
                    <label>Prénom *</label>
                    <input type="text" name="prenom" value="<%= c.getPrenom() %>" required>
                </div>
            </div>
            <div class="row-2">
                <div class="field">
                    <label>E-mail *</label>
                    <input type="email" name="email" value="<%= c.getEmail() %>" required>
                </div>
                <div class="field">
                    <label>Téléphone</label>
                    <input type="text" name="telephone" value="<%= c.getTelephone() != null ? c.getTelephone() : "" %>">
                </div>
            </div>
            <div class="field">
                <label>Pays</label>
                <select name="pays">
                    <% String[] pays = {"Maroc","France","Algérie","Tunisie","Belgique","Canada","USA","Autre"};
                       for (String p : pays) { %>
                        <option value="<%= p %>" <%= p.equals(c.getPays()) ? "selected" : "" %>><%= p %></option>
                    <% } %>
                </select>
            </div>

            <div class="section-label">Compte & Abonnement</div>
            <div class="row-2">
                <div class="field">
                    <label>Abonnement</label>
                    <select name="abonnement">
                        <% String[] abos = {"FREE","SILVER","GOLD","PLATINUM"};
                           for (String a : abos) { %>
                            <option value="<%= a %>" <%= a.equals(c.getAbonnement()) ? "selected" : "" %>><%= a %></option>
                        <% } %>
                    </select>
                </div>
                <div class="field">
                    <label>Solde (MAD)</label>
                    <input type="number" name="solde" value="<%= c.getSolde() %>" min="0" step="0.01">
                </div>
            </div>
            <div class="field">
                <label>Mods achetés</label>
                <input type="number" name="modsAchetes" value="<%= c.getModsAchetes() %>" min="0">
            </div>
            <div class="field">
                <div class="toggle-row">
                    <input type="checkbox" id="actif" name="actif" <%= c.isActif() ? "checked" : "" %>>
                    <label for="actif">Compte actif</label>
                </div>
            </div>

            <div class="btn-footer">
                <a href="<%= request.getContextPath() %>/clients" class="btn-cancel">Annuler</a>
                <button type="submit" class="btn-submit" style="flex:1">
                    <i class="bi bi-check-circle-fill"></i> Enregistrer les modifications
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
