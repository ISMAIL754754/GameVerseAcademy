package ma.ac.esi.gameverseacademy.model;

import java.sql.Timestamp;

public class Client {

    private int       id;
    private String    nom;
    private String    prenom;
    private String    email;
    private String    telephone;
    private String    pays;
    private String    abonnement;   // FREE, SILVER, GOLD, PLATINUM
    private int       modsAchetes;
    private double    solde;
    private Timestamp dateInscription;
    private boolean   actif;

    public Client() {}

    public Client(int id, String nom, String prenom, String email,
                  String telephone, String pays, String abonnement,
                  int modsAchetes, double solde,
                  Timestamp dateInscription, boolean actif) {
        this.id              = id;
        this.nom             = nom;
        this.prenom          = prenom;
        this.email           = email;
        this.telephone       = telephone;
        this.pays            = pays;
        this.abonnement      = abonnement;
        this.modsAchetes     = modsAchetes;
        this.solde           = solde;
        this.dateInscription = dateInscription;
        this.actif           = actif;
    }

    // Getters
    public int       getId()              { return id;              }
    public String    getNom()             { return nom;             }
    public String    getPrenom()          { return prenom;          }
    public String    getEmail()           { return email;           }
    public String    getTelephone()       { return telephone;       }
    public String    getPays()            { return pays;            }
    public String    getAbonnement()      { return abonnement;      }
    public int       getModsAchetes()     { return modsAchetes;     }
    public double    getSolde()           { return solde;           }
    public Timestamp getDateInscription() { return dateInscription; }
    public boolean   isActif()            { return actif;           }

    // Setters
    public void setId(int id)                          { this.id              = id;              }
    public void setNom(String nom)                     { this.nom             = nom;             }
    public void setPrenom(String prenom)               { this.prenom          = prenom;          }
    public void setEmail(String email)                 { this.email           = email;           }
    public void setTelephone(String telephone)         { this.telephone       = telephone;       }
    public void setPays(String pays)                   { this.pays            = pays;            }
    public void setAbonnement(String abonnement)       { this.abonnement      = abonnement;      }
    public void setModsAchetes(int modsAchetes)        { this.modsAchetes     = modsAchetes;     }
    public void setSolde(double solde)                 { this.solde           = solde;           }
    public void setDateInscription(Timestamp d)        { this.dateInscription = d;               }
    public void setActif(boolean actif)                { this.actif           = actif;           }

    @Override
    public String toString() {
        return "Client{id=" + id + ", nom='" + nom + "', email='" + email + "'}";
    }
}
