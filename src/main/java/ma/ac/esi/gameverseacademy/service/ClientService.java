package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Client;
import ma.ac.esi.gameverseacademy.repository.ClientRepository;

import java.util.List;

public class ClientService {

    private final ClientRepository repo = new ClientRepository();

    // ── Afficher tous les clients ────────────────────────────────
    public List<Client> getAllClients() {
        return repo.getAllClients();
    }

    // ── Afficher un client par ID ────────────────────────────────
    public Client getClientById(int id) {
        return repo.getClientById(id);
    }

    // ── Ajouter un client (INSERT) ───────────────────────────────
    public String addClient(Client c) {
        if (c.getNom() == null || c.getNom().trim().isEmpty())
            return "Le nom est obligatoire.";
        if (c.getPrenom() == null || c.getPrenom().trim().isEmpty())
            return "Le prénom est obligatoire.";
        if (c.getEmail() == null || !c.getEmail().contains("@"))
            return "Adresse e-mail invalide.";
        if (repo.emailExists(c.getEmail(), 0))
            return "Cet e-mail est déjà utilisé.";
        if (c.getSolde() < 0)
            return "Le solde ne peut pas être négatif.";

        return repo.insertClient(c) ? null : "Erreur lors de l'insertion en base.";
    }

    // ── Modifier un client (UPDATE) ──────────────────────────────
    public String updateClient(Client c) {
        if (c.getId() <= 0)
            return "ID client invalide.";
        if (c.getNom() == null || c.getNom().trim().isEmpty())
            return "Le nom est obligatoire.";
        if (c.getPrenom() == null || c.getPrenom().trim().isEmpty())
            return "Le prénom est obligatoire.";
        if (c.getEmail() == null || !c.getEmail().contains("@"))
            return "Adresse e-mail invalide.";
        if (repo.emailExists(c.getEmail(), c.getId()))
            return "Cet e-mail est déjà utilisé par un autre client.";
        if (c.getSolde() < 0)
            return "Le solde ne peut pas être négatif.";

        return repo.updateClient(c) ? null : "Erreur lors de la mise à jour en base.";
    }

    // ── Supprimer un client (DELETE) ─────────────────────────────
    public String deleteClient(int id) {
        if (id <= 0) return "ID invalide.";
        return repo.deleteClient(id) ? null : "Erreur lors de la suppression.";
    }
}
