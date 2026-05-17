package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Client;
import ma.ac.esi.gameverseacademy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientRepository {

    private static final String SELECT_ALL =
        "SELECT id, nom, prenom, email, telephone, pays, abonnement, " +
        "       mods_achetes, solde, date_inscription, actif          " +
        "FROM clients                                                  " +
        "ORDER BY id ASC";

    // ── Lire tous les clients ────────────────────────────────────
    public List<Client> getAllClients() {
        List<Client> clients = new ArrayList<>();
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs           = stmt.executeQuery()) {
            while (rs.next()) {
                clients.add(mapRow(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL getAllClients(): " + e.getMessage());
        }
        return clients;
    }

    // ── Lire un client par ID ────────────────────────────────────
    public Client getClientById(int id) {
        String sql = SELECT_ALL.replace("ORDER BY id ASC", "WHERE id = ?");
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT id, nom, prenom, email, telephone, pays, abonnement, " +
                 "mods_achetes, solde, date_inscription, actif FROM clients WHERE id = ?")) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL getClientById(): " + e.getMessage());
        }
        return null;
    }

    // ── Vérifier si l'email existe déjà (pour la validation) ────
    public boolean emailExists(String email, int excludeId) {
        String sql = "SELECT id FROM clients WHERE email = ? AND id != ?";
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setInt(2, excludeId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── INSERT ───────────────────────────────────────────────────
    public boolean insertClient(Client c) {
        String sql = "INSERT INTO clients (nom, prenom, email, telephone, pays, abonnement, mods_achetes, solde, actif) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNom());
            stmt.setString(2, c.getPrenom());
            stmt.setString(3, c.getEmail());
            stmt.setString(4, c.getTelephone());
            stmt.setString(5, c.getPays());
            stmt.setString(6, c.getAbonnement());
            stmt.setInt(7, c.getModsAchetes());
            stmt.setDouble(8, c.getSolde());
            stmt.setBoolean(9, c.isActif());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── UPDATE ───────────────────────────────────────────────────
    public boolean updateClient(Client c) {
        String sql = "UPDATE clients SET nom=?, prenom=?, email=?, telephone=?, " +
                     "pays=?, abonnement=?, mods_achetes=?, solde=?, actif=? WHERE id=?";
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNom());
            stmt.setString(2, c.getPrenom());
            stmt.setString(3, c.getEmail());
            stmt.setString(4, c.getTelephone());
            stmt.setString(5, c.getPays());
            stmt.setString(6, c.getAbonnement());
            stmt.setInt(7, c.getModsAchetes());
            stmt.setDouble(8, c.getSolde());
            stmt.setBoolean(9, c.isActif());
            stmt.setInt(10, c.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── DELETE ───────────────────────────────────────────────────
    public boolean deleteClient(int id) {
        String sql = "DELETE FROM clients WHERE id=?";
        try (Connection conn        = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ── Mapper ResultSet → Client ────────────────────────────────
    private Client mapRow(ResultSet rs) throws SQLException {
        return new Client(
            rs.getInt("id"),
            rs.getString("nom"),
            rs.getString("prenom"),
            rs.getString("email"),
            rs.getString("telephone"),
            rs.getString("pays"),
            rs.getString("abonnement"),
            rs.getInt("mods_achetes"),
            rs.getDouble("solde"),
            rs.getTimestamp("date_inscription"),
            rs.getBoolean("actif")
        );
    }
}
