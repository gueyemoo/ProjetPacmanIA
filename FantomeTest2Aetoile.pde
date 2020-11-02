class FantomeTest2AEtoile extends Fantome {
  FantomeTest2AEtoile() {
    super(new PVector(1*16 + 8, 1*16+8), color(128, 0, 128), "FantomeTest2AEtoile");
    definirChemin();
  }

  // METHODES
  @Override
    public void apparait() {
    meilleurChemin.dessineLigne(); //Montre le chemin que le fantome va suivre
    ellipse(position.x, position.y, 15, 15);
  }

  @Override
    public void deplacement() {
    position.add(dir);
    verifDirection(); // verifie si changement de direction necessaire au prochain deplacement
  }

  @Override
    public void verifDirection() {

    if ((position.x-8)%16 == 0 && (position.y-8)%16 == 0) { // verif si position critique
      PVector matricePosition = new PVector((position.x-8)/16, (position.y-8)/16); // transforme la position en array de position

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
  @Override
    public void setNoeud() {

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
     //Noeud target = new Noeud(26,29); //objectif a atteindre par le fantome
     noeudFantome.add(new Noeud((pacman.position.x-8)/16, (pacman.position.y-8)/16)); // poursuit pacman
     
    // noeudFantome.add(target); //target le coin en bas à droite
    
    
    for (int i=0; i<noeudFantome.size(); i++) {
      noeudFantome.get(i).ajoutNoeud(noeudFantome);
    }
  }
  
  @Override
    void definirChemin() {
    noeudFantome.clear();
    setNoeud();
    depart = noeudFantome.get(0);
    arrivee = noeudFantome.get(noeudFantome.size()-1);
    Chemin temporaire = AlgoRechercheAEtoile(depart, arrivee, dir);
    if(temporaire != null) {
      meilleurChemin = temporaire.dupliquer();
    }
  }
}
