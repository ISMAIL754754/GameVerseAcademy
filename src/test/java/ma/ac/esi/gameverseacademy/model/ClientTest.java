package ma.ac.esi.gameverseacademy.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Timestamp;
import java.time.Instant;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests unitaires pour la classe {@link Client}.
 * Vérifie les constructeurs, getters/setters et toString.
 */
@DisplayName("Tests du modèle Client")
class ClientTest {

    private Client client;

    @BeforeEach
    void setUp() {
        client = new Client();
    }

    @Test
    @DisplayName("Constructeur par défaut : champs à valeurs par défaut")
    void testDefaultConstructor() {
        assertNotNull(client);
        assertEquals(0, client.getId());
        assertNull(client.getNom());
        assertNull(client.getEmail());
    }

    @Test
    @DisplayName("Constructeur complet : tous les champs renseignés")
    void testFullConstructor() {
        Timestamp now = Timestamp.from(Instant.now());
        Client c = new Client(1, "Dupont", "Jean", "jean@example.com",
                "0612345678", "Maroc", "GOLD", 5, 150.0, now, true);

        assertEquals(1,               c.getId());
        assertEquals("Dupont",        c.getNom());
        assertEquals("Jean",          c.getPrenom());
        assertEquals("jean@example.com", c.getEmail());
        assertEquals("0612345678",    c.getTelephone());
        assertEquals("Maroc",         c.getPays());
        assertEquals("GOLD",          c.getAbonnement());
        assertEquals(5,               c.getModsAchetes());
        assertEquals(150.0,           c.getSolde(), 0.001);
        assertEquals(now,             c.getDateInscription());
        assertTrue(c.isActif());
    }

    @Test
    @DisplayName("Setters : modification correcte de chaque champ")
    void testSetters() {
        client.setId(42);
        client.setNom("Martin");
        client.setPrenom("Alice");
        client.setEmail("alice@test.com");
        client.setTelephone("0699999999");
        client.setPays("France");
        client.setAbonnement("SILVER");
        client.setModsAchetes(3);
        client.setSolde(99.99);
        client.setActif(true);

        assertEquals(42,            client.getId());
        assertEquals("Martin",      client.getNom());
        assertEquals("Alice",       client.getPrenom());
        assertEquals("alice@test.com", client.getEmail());
        assertEquals("SILVER",      client.getAbonnement());
        assertEquals(3,             client.getModsAchetes());
        assertEquals(99.99,         client.getSolde(), 0.001);
        assertTrue(client.isActif());
    }

    @Test
    @DisplayName("toString : contient l'id, le nom et l'email")
    void testToString() {
        client.setId(7);
        client.setNom("Benali");
        client.setEmail("benali@esi.ma");

        String str = client.toString();
        assertTrue(str.contains("7"),          "toString doit contenir l'id");
        assertTrue(str.contains("Benali"),     "toString doit contenir le nom");
        assertTrue(str.contains("benali@esi.ma"), "toString doit contenir l'email");
    }

    @Test
    @DisplayName("Solde négatif : le setter l'accepte (validation dans le Service)")
    void testNegativeSoldeAccepted() {
        // La validation métier est dans ClientService, pas dans le modèle
        client.setSolde(-10.0);
        assertEquals(-10.0, client.getSolde(), 0.001);
    }
}
