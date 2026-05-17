package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Mod;
import ma.ac.esi.gameverseacademy.repository.ModRepository;

import java.util.List;

public class ModService {

    private ModRepository modRepository = new ModRepository();

    // ── Retourne tous les mods ───────────────────────────────────
    public List<Mod> getAllMods() {
        return modRepository.getAllMods();
    }

    // ── Retourne un mod par son ID ───────────────────────────────
    public Mod getModById(int id) {
        return modRepository.getModById(id);
    }

    // ── Retourne les mods filtrés par catégorie ──────────────────
    public List<Mod> getModsByCategory(String category) {
        List<Mod> all      = modRepository.getAllMods();
        List<Mod> filtered = new java.util.ArrayList<>();
        for (Mod mod : all) {
            if (mod.getCategory() != null &&
                mod.getCategory().equalsIgnoreCase(category)) {
                filtered.add(mod);
            }
        }
        return filtered;
    }

    // ── Création d’un nouveau mod (INSERT) ───────────────────────
    public boolean submitMod(Mod mod) {
        // Validation minimale : le titre est obligatoire
        if (mod.getTitle() == null || mod.getTitle().trim().isEmpty()) {
            return false;
        }
        return modRepository.insertMod(mod);
    }

    // ✅ UPDATE – met à jour un mod existant
    public boolean updateMod(Mod mod) {
        // Validation : le titre est obligatoire
        if (mod.getTitle() == null || mod.getTitle().trim().isEmpty()) {
            return false;
        }
        // L’ID doit être valide (supérieur à 0)
        if (mod.getId() <= 0) {
            return false;
        }
        return modRepository.updateMod(mod);
    }

    // ✅ DELETE – supprime un mod par son ID
    public boolean deleteMod(int id) {
        if (id <= 0) {
            return false;
        }
        return modRepository.deleteMod(id);
    }
}