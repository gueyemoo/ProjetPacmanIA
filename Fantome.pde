/*class Fantome {
  PVector position = new PVector (13*16+8, 11*16+8); //position de départ
  PVector dir = new PVector (1, 0);
  Noeud depart;  // Position du fantome en tant que noeud
  Noeud arrivee;  // Position de la cible du fantome en tant que noeud
  ArrayList<Noeud> noeudFantome = new ArrayList<Noeud>(); // Liste des noeuds allant de la position du fantome a la position de sa cible
  color couleur;
  Chemin meilleurChemin; // variable contenant le chemin que va suivre le fantome
  boolean chasse = true; // false si il est en mode dispersion
  boolean fuite = false;
  int compteurChasse = 0; // compteur pour passer du mode chasse a dispersion
  int compteurFuite = 0; // compteur pour que le fantome clignote en mode fuite
  boolean retourBase = false; // true si le fantome s'est fait mangé
  boolean mort = false; // true quand le fantome est dans la base apres avoir été mangé
  int compteurMort = 0; // compteur pour que le fantome reste dans la base
  String nom;

  // CONSTRUCTEUR
  Fantome(PVector position, color couleur, String nom) {
    this.position = position;
    this.couleur = couleur;
    this.nom = nom;
  }

  // METHODES
  void apparait() {
    // démarrage des compteurs
    compteurChasse ++;
    if (chasse) {
      if (compteurChasse > 2000) { // temps de chasse dépassé
        chasse = false;
        compteurChasse = 0; // remise a 0 du compteur pour prochaine chasse
      }
    }

    if (mort) {
      compteurMort ++;
      if (compteurMort > 300) { // temps mort dépassé
        mort = false;
      }
    } else { // retour dans la partie
      if (!fuite) {
        if (retourBase) { // rend le fantome transparent pour le retour base
          stroke(couleur, 100);
          fill(couleur, 100);
        } else {
          stroke(couleur);
          fill(couleur);
        }
        meilleurChemin.dessineLigne();
      } else { // cas ou fuite = true
        compteurFuite ++;
        if (compteurFuite > 800) {
          fuite = false;
          compteurFuite = 0;
        }

        if (floor(compteurFuite / 30) %2 ==0 ) { // permet de faire clignoter le fantome toutes les 30 images
          stroke(255);
          fill(255);
        } else {
          stroke(0, 0, 200);
          fill(0, 0, 200);
        }
      }
      ellipse(position.x, position.y, 20, 20);
    }
  }

  void setNoeud() {

      noeudFantome.add(new Noeud((position.x-8)/16, (position.y-8)/16)); // ajoute la position actuelle comme noeud
      for (int i = 1; i<27; i++) {
        for (int j = 1; j<30; j++) {
          if (!carreaux[j][i].mur) { // si il le fantome peut aller en haut ou en bas et droite ou gauche c'est un noeud
            if (!carreaux[j-1][i].mur || !carreaux[j+1][i].mur) { // verif si espace haut/bas
              if (!carreaux[j][i-1].mur || !carreaux[j][i+1].mur) { // verif si espace droite/gauche
                noeudFantome.add(new Noeud(i, j)); // ajout du noeud
              }
            }
          }

        }
      }

      if (retourBase) {
        noeudFantome.add(new Noeud(13,11));
      } else {
        if (chasse) { // switch entre les personnalites
          if(nom == "FantomeRouge") {
            noeudFantome.add(new Noeud((pacman.position.x-8)/16, (pacman.position.y-8)/16)); // poursuit pacman

          } else if (nom == "FantomeOrange") {
            if (dist((position.x-8)/16, (position.y-8)/16, (pacman.position.x-8)/16, (pacman.position.y-8)/16) >8 ) {
              noeudFantome.add(new Noeud((pacman.position.x-8)/16, (pacman.position.y-8)/16));
            } else {
              noeudFantome.add(new Noeud(1,29));
            }

          } else if (nom ==   "FantomeBleu") {
            PVector positionPacman = new PVector((pacman.position.x-8)/16, (pacman.position.y-8)/16);
            PVector positionFantomeRouge = new PVector((fantomeRouge.position.x-8)/16, (fantomeRouge.position.y-8)/16);
            PVector rougeAPacman = new PVector(positionPacman.x + positionFantomeRouge.x, positionPacman.y + positionFantomeRouge.y);
            PVector cible = new PVector(positionPacman.x + rougeAPacman.x, positionPacman.y + rougeAPacman.y);
            PVector noeudPlusProche = getCarreauNonMurProche(cible);

            if (dist((position.x-8)/16, (position.y-8)/16, noeudPlusProche.x, noeudPlusProche.y)<1) {
              noeudFantome.add(new Noeud((pacman.position.x-8)/16, (pacman.position.y-8)/16));
            } else {
              noeudFantome.add(new Noeud(noeudPlusProche.x, noeudPlusProche.y));
            }
          } else if (nom == "FantomeRose") { // rose cible 4 cases devant pacman
            int cibleAvancee = 4;
            PVector matricePositionPacman = new PVector((pacman.position.x-8)/16 + (pacman.direction.x*cibleAvancee), (pacman.position.y-8)/16 + (pacman.direction.y * cibleAvancee));
            while (!(matricePositionPacman.x >0 && matricePositionPacman.y >0 && matricePositionPacman.x <28 && matricePositionPacman.y < 31 && !carreaux[(int)matricePositionPacman.y][(int)matricePositionPacman.x].mur)) {
              cibleAvancee -= 1;
              matricePositionPacman = new PVector((pacman.position.x-8)/16 + (pacman.direction.x*cibleAvancee), (pacman.position.y-8)/16 + (pacman.direction.y *cibleAvancee));
            }
            if (dist((position.x-8)/16, (position.y-8)/16, matricePositionPacman.x, matricePositionPacman.y)<1) {
              noeudFantome.add(new Noeud((pacman.position.x-8)/16, (pacman.position.y-8)/16));
            } else {
              noeudFantome.add(new Noeud(matricePositionPacman.x, matricePositionPacman.y));
            }
          }
        } else { // en mode fuite
          noeudFantome.add(new Noeud(1,29));
        }
      }
      for (int i=0; i<noeudFantome.size(); i++) {
        noeudFantome.get(i).ajoutNoeud(noeudFantome);
      }
  }

  void deplacement() {
    if (!mort) { // pas de deplacment si il est dans la base
      position.add(dir);
      verifDirection(); // verifie si changement de direction necessaire au prochain deplacement
    }
  }

  void verifDirection() {
    if (pacman.touchePacman(position)) { // si il touche pacman
      if (fuite) {
        retourBase = true;
        fuite = false;
      } else if (!retourBase) { // si il touche pacman en mode normal, il le tue
        pacman.tue();
      }
    }

    if (retourBase) { // si il atteint la base
      if (dist((position.x-8)/16, (position.y-8)/16, 13, 11) <1) {
        // garde le fantome dans la base
        retourBase = false;
        mort = true;
        compteurMort = 0;
      }
    }

    if ((position.x-8)%16 == 0 && (position.y-8)%16 == 0) { // verif si position critique
      PVector matricePosition = new PVector((position.x-8)/16, (position.y-8)/16); // transforme la position en array de position
      if(fuite) {
        boolean estNoeud = false;
        for (int j =0; j<noeudFantome.size(); j++) {
          if (matricePosition.x == noeudFantome.get(j).x && matricePosition.y == noeudFantome.get(j).y) {
            estNoeud = true;
          }
        }
        if (!estNoeud) {
          return; // pas besoin d'action si ce n'est pas un noeud
        } else { // deplacement aleatoire
          PVector nouvelDir = new PVector();
          int alea = floor(random(4));
          switch(alea) {
            case 0:
              nouvelDir = new PVector(1,0);
              break;
            case 1:
              nouvelDir = new PVector(0,1);
              break;
            case 2:
              nouvelDir = new PVector(-1,0);
              break;
            case 3:
              nouvelDir = new PVector(0,-1);
              break;
          }

          while(carreaux[floor(matricePosition.y + nouvelDir.y)][floor(matricePosition.x + nouvelDir.x)].mur || (nouvelDir.x +2*dir.x == 0 && nouvelDir.y +2*dir.y == 0)) {
            // si il avance dans un mur ou dans la direction opposee, alors changement de direction
            alea = floor(random(4));
            switch(alea) {
              case 0:
                nouvelDir = new PVector(1,0);
                break;
              case 1:
                nouvelDir = new PVector(0,1);
                break;
              case 2:
                nouvelDir = new PVector(-1,0);
                break;
              case 3:
                nouvelDir = new PVector(0,-1);
                break;
            }
          }
          dir = new PVector(nouvelDir.x/2, nouvelDir.y/2);  // diminue de moitie la vitesse
        }
      } else { // pas en mode fuite
        definirChemin();
        for (int i =0; i<meilleurChemin.chemin.size(); i++) { // si sur un noeud, se diriger vers le prochain du chemin
          if (matricePosition.x == meilleurChemin.chemin.get(i).x && matricePosition.y == meilleurChemin.chemin.get(i).y) {
            dir = new PVector(meilleurChemin.chemin.get(i+1).x - matricePosition.x, meilleurChemin.chemin.get(i+1).y - matricePosition.y);
            dir.limit(1);
            return;
          }
        }
      }
    }
  }

  void definirChemin() {
    noeudFantome.clear();
    setNoeud();
    depart = noeudFantome.get(0);
    arrivee = noeudFantome.get(noeudFantome.size()-1);
    Chemin temporaire = AStar(depart, arrivee, dir);
    if(temporaire != null) {
      meilleurChemin = temporaire.dupliquer();
    }
  }
}*/
