package ma.ac.esi.gameverseacademy.service;

import ma.ac.esi.gameverseacademy.model.Client;
import ma.ac.esi.gameverseacademy.repository.ClientRepository;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

/**
 * Tests unitaires pour {@link ClientService}.
 * Le {@link ClientRepository} est mocké afin d'isoler la logique métier.
 */
@ExtendWith(MockitoExtension.class)
@DisplayName("Tests du service ClientService")
class ClientServiceTest {

    /** Mock du dépôt — remplace la vraie connexion PostgreSQL. */
    @Mock
    private ClientRepository repoMock;

    /** Instance testée avec injection du mock via réflexion. */
    private ClientService service;

    @BeforeEach
    void setUp() throws Exception {
        service = new ClientService();
        // Injection du mock dans le champ privé "repo"
        var field = ClientService.class.getDeclaredField("repo");
        field.setAccessible(true);
        field.set(service, repoMock);
    }

    // ─── addClient ────────────────────────────────────────────────

    @Test
    @DisplayName("addClient : nom vide → erreur de validation")
    void addClient_nomVide_retourneErreur() {
        Client c = buildClient("", "Jean", "jean@ok.com", 0.0);
        String result = service.addClient(c);
        assertEquals("Le nom est obligatoire.", result);
        verify(repoMock, never()).insertClient(any());
    }

    @Test
    @DisplayName("addClient : prénom null → erreur de validation")
    void addClient_prenomNull_retourneErreur() {
        Client c = buildClient("Dupont", null, "j@ok.com", 0.0);
        String result = service.addClient(c);
        assertEquals("Le prénom est obligatoire.", result);
    }

    @Test
    @DisplayName("addClient : email sans @ → erreur de validation")
    void addClient_emailInvalide_retourneErreur() {
        Client c = buildClient("Dupont", "Jean", "invalid-email", 0.0);
        String result = service.addClient(c);
        assertEquals("Adresse e-mail invalide.", result);
    }

    @Test
    @DisplayName("addClient : email déjà utilisé → erreur métier")
    void addClient_emailDuplique_retourneErreur() {
        Client c = buildClient("Dupont", "Jean", "taken@ok.com", 0.0);
        when(repoMock.emailExists("taken@ok.com", 0)).thenReturn(true);

        String result = service.addClient(c);
        assertEquals("Cet e-mail est déjà utilisé.", result);
    }

    @Test
    @DisplayName("addClient : solde négatif → erreur de validation")
    void addClient_soldeNegatif_retourneErreur() {
        Client c = buildClient("Dupont", "Jean", "j@ok.com", -5.0);
        String result = service.addClient(c);
        assertEquals("Le solde ne peut pas être négatif.", result);
    }

    @Test
    @DisplayName("addClient : données valides → insertion réussie, retour null")
    void addClient_donnéesValides_retourneNull() {
        Client c = buildClient("Dupont", "Jean", "new@ok.com", 50.0);
        when(repoMock.emailExists("new@ok.com", 0)).thenReturn(false);
        when(repoMock.insertClient(c)).thenReturn(true);

        assertNull(service.addClient(c));
        verify(repoMock).insertClient(c);
    }

    @Test
    @DisplayName("addClient : erreur base de données → message d'erreur")
    void addClient_erreurDB_retourneErreur() {
        Client c = buildClient("Dupont", "Jean", "new@ok.com", 0.0);
        when(repoMock.emailExists(anyString(), eq(0))).thenReturn(false);
        when(repoMock.insertClient(c)).thenReturn(false);

        assertEquals("Erreur lors de l'insertion en base.", service.addClient(c));
    }

    // ─── deleteClient ─────────────────────────────────────────────

    @Test
    @DisplayName("deleteClient : id <= 0 → erreur de validation")
    void deleteClient_idInvalide_retourneErreur() {
        assertEquals("ID invalide.", service.deleteClient(0));
        assertEquals("ID invalide.", service.deleteClient(-1));
        verify(repoMock, never()).deleteClient(anyInt());
    }

    @Test
    @DisplayName("deleteClient : id valide → suppression réussie")
    void deleteClient_idValide_retourneNull() {
        when(repoMock.deleteClient(5)).thenReturn(true);
        assertNull(service.deleteClient(5));
    }

    // ─── updateClient ─────────────────────────────────────────────

    @Test
    @DisplayName("updateClient : id <= 0 → erreur de validation")
    void updateClient_idInvalide_retourneErreur() {
        Client c = buildClient("X", "Y", "x@y.com", 0.0);
        c.setId(0);
        assertEquals("ID client invalide.", service.updateClient(c));
    }

    // ─── getAllClients ─────────────────────────────────────────────

    @Test
    @DisplayName("getAllClients : délègue au repository")
    void getAllClients_delegueAuRepository() {
        List<Client> liste = List.of(new Client(), new Client());
        when(repoMock.getAllClients()).thenReturn(liste);

        assertEquals(2, service.getAllClients().size());
        verify(repoMock).getAllClients();
    }

    // ─── Helpers ──────────────────────────────────────────────────

    private Client buildClient(String nom, String prenom, String email, double solde) {
        Client c = new Client();
        c.setNom(nom);
        c.setPrenom(prenom);
        c.setEmail(email);
        c.setSolde(solde);
        return c;
    }
}
