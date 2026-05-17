# GameVerseAcademy — Guide de Build Maven

## Structure du projet

```
GameVerseAcademy/
├── pom.xml                          ← Configuration Maven complète
├── settings-nexus.xml               ← Credentials Nexus (NE PAS committer)
├── BUILD.md                         ← Ce fichier
├── src/
│   ├── main/
│   │   ├── java/ma/ac/esi/...       ← Sources Java
│   │   ├── checkstyle/
│   │   │   └── checkstyle.xml       ← Règles Checkstyle personnalisées
│   │   └── webapp/                  ← JSP, HTML, WEB-INF
│   ├── site/
│   │   └── site.xml                 ← Habillage du site Maven
│   └── test/
│       └── java/ma/ac/esi/...       ← Tests JUnit 5
└── target/
    ├── GameVerseAcademy.war         ← Artefact déployable
    ├── site/                        ← Site complet (rapports)
    │   ├── index.html
    │   ├── jacoco/                  ← Couverture JaCoCo
    │   ├── apidocs/                 ← Javadoc
    │   ├── checkstyle.html
    │   ├── pmd.html / cpd.html
    │   └── spotbugs.html
    └── surefire-reports/            ← Résultats des tests XML/HTML
```

---

## Prérequis

| Outil    | Version minimale |
|----------|-----------------|
| Java JDK | 17              |
| Maven    | 3.9+            |
| Nexus RM | 3.x (optionnel) |

---

## Commandes Maven

### 1. Compilation

```bash
mvn compile
```
Compile les sources Java dans `target/classes/`.

---

### 2. Package (WAR)

```bash
mvn package
```
Produit `target/GameVerseAcademy.war`.  
Exécute aussi les tests unitaires.

```bash
mvn package -DskipTests    # Ignorer les tests (non recommandé)
```

---

### 3. Install (dépôt local)

```bash
mvn install
```
Installe dans `~/.m2/repository/ma/ac/esi/GameVerseAcademy/`.  
Rend l'artefact disponible pour d'autres projets Maven locaux.

---

### 4. Site (rapports complets)

```bash
mvn site
```
Génère `target/site/index.html` avec :
- Rapport JaCoCo (couverture)
- Rapport Checkstyle
- Rapport PMD + CPD
- Rapport SpotBugs
- Javadoc
- Résultats des tests

Ouvrez ensuite :
```bash
# Linux
xdg-open target/site/index.html
# macOS
open target/site/index.html
# Windows
start target/site/index.html
```

---

### 5. Deploy (Nexus Repository Manager)

**Prérequis :** Nexus démarré sur `http://localhost:8081`

```bash
# Avec le fichier settings fourni
mvn deploy -s settings-nexus.xml

# Ou si settings copiés dans ~/.m2/settings.xml
mvn deploy
```

L'artefact est publié dans :
- `maven-snapshots` si version = `*-SNAPSHOT`
- `maven-releases`  si version = release (ex: `1.0.0`)

---

### 6. Exécution complète (cycle complet recommandé)

```bash
mvn clean verify site
```

Ce cycle enchaîne :
1. `clean`     → supprime `target/`
2. `compile`   → compile les sources
3. `test`      → exécute les tests JUnit 5
4. `package`   → crée le WAR
5. `verify`    → lance JaCoCo check, Checkstyle, PMD, SpotBugs
6. `site`      → génère tous les rapports HTML

---

## Rapports de qualité

### Couverture de tests — JaCoCo

```bash
mvn jacoco:report          # Rapport seul (après mvn test)
mvn verify                 # Test + rapport + vérification seuil (30% min)
```

Rapport : `target/site/jacoco/index.html`

Pour modifier le seuil minimal (pom.xml, section jacoco-check) :
```xml
<minimum>0.50</minimum>   <!-- 50% de couverture requise -->
```

---

### Analyse statique — Checkstyle

```bash
mvn checkstyle:checkstyle  # Génère le rapport
mvn checkstyle:check       # Bloque le build si violations
```

Rapport : `target/site/checkstyle.html`

Configuration : `src/main/checkstyle/checkstyle.xml`  
Style par défaut : Google Java Style (`google_checks.xml`)

---

### Analyse statique — PMD

```bash
mvn pmd:pmd    # Détecte mauvaises pratiques
mvn pmd:cpd    # Détecte code dupliqué
mvn pmd:check  # Bloque le build si violations priorité >= 3
```

Rapport : `target/site/pmd.html` et `target/site/cpd.html`

---

### Analyse statique — SpotBugs

```bash
mvn spotbugs:spotbugs      # Analyse les classes compilées
mvn spotbugs:check         # Bloque si bug détecté
mvn spotbugs:gui           # Ouvre l'interface graphique SpotBugs
```

Rapport : `target/site/spotbugs.html`

---

### Documentation Javadoc

```bash
mvn javadoc:javadoc        # Génère la Javadoc HTML
mvn javadoc:jar            # Produit *-javadoc.jar
```

Documentation : `target/site/apidocs/index.html`

---

## Déploiement sur Nexus — Configuration détaillée

### 1. Démarrer Nexus (Docker)

```bash
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
# Attendre ~1 min, puis ouvrir http://localhost:8081
# Mot de passe admin initial : dans /nexus-data/admin.password
docker exec nexus cat /nexus-data/admin.password
```

### 2. Configurer settings-nexus.xml

Mettez à jour `settings-nexus.xml` avec vos credentials Nexus.

### 3. Déployer

```bash
mvn clean deploy -s settings-nexus.xml
```

### 4. Vérifier dans Nexus

Naviguez vers `http://localhost:8081` → Browse → maven-snapshots  
Vous devriez voir : `ma/ac/esi/GameVerseAcademy/1.0.0-SNAPSHOT/`

---

## Variables de configuration

| Propriété          | Valeur par défaut         | Description                     |
|--------------------|---------------------------|---------------------------------|
| `nexus.url`        | `http://localhost:8081`   | URL du Nexus                    |
| `java.version`     | `17`                      | Version Java cible              |
| `jacoco.minimum`   | `0.30` (30%)              | Seuil couverture (dans pom.xml) |

Surcharge en ligne de commande :
```bash
mvn deploy -Dnexus.url=http://mon-nexus:8081
```
