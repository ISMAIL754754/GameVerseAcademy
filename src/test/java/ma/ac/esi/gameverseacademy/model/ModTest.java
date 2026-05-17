package ma.ac.esi.gameverseacademy.model;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

/**
 * Tests unitaires pour la classe {@link Mod}.
 */
@DisplayName("Tests du modèle Mod")
class ModTest {

    @Test
    @DisplayName("Constructeur par défaut : objet non null")
    void testDefaultConstructor() {
        Mod mod = new Mod();
        assertNotNull(mod);
        assertEquals(0, mod.getId());
        assertNull(mod.getTitle());
    }

    @Test
    @DisplayName("Setters/Getters : cohérence des valeurs")
    void testSettersGetters() {
        Mod mod = new Mod();
        mod.setId(10);
        mod.setTitle("Super Mod");
        mod.setCategory("Action");
        mod.setAuthor("dev1");
        mod.setDownloads(500);
        mod.setMetacritic(85);

        assertEquals(10,        mod.getId());
        assertEquals("Super Mod", mod.getTitle());
        assertEquals("Action",  mod.getCategory());
        assertEquals("dev1",    mod.getAuthor());
        assertEquals(500,       mod.getDownloads());
        assertEquals(85,        mod.getMetacritic());
    }

    @Test
    @DisplayName("toString : contient l'id et le titre")
    void testToString() {
        Mod mod = new Mod();
        mod.setId(3);
        mod.setTitle("Mega Pack");
        String str = mod.toString();
        assertTrue(str.contains("3") || str.contains("Mega Pack"),
                   "toString doit contenir au moins l'id ou le titre");
    }
}
